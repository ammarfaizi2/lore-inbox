Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261966AbVEQXWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbVEQXWI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 19:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbVEQXWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 19:22:08 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:110 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261966AbVEQXVm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 19:21:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pIRHP/T3RzaHBojdvFSSA35UQp1RZaeiGF+Hccl4M2z1L3RV+6f8sq9qggDCbwMDXbV9fIqHD7OsQGW1vnkV8dWke1BwiHWnddtVBlx3vUTM8bnzfyocuzBsl6ow/Ybk7MymAEJTlF4gLxT3l8MKYbX1J+Ok7p9Vebk5t1dyNoo=
Message-ID: <25381867050517162126d18704@mail.gmail.com>
Date: Tue, 17 May 2005 19:21:41 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
To: Grant Coady <grant_lkml@dodo.com.au>
Subject: Re: [lm-sensors] [PATCH 2.6.12-rc4 15/15] drivers/i2c/chips/adm1026.c: use dynamic sysfs callbacks
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
In-Reply-To: <lqrk81degqp2id4sf1f4rjsnithljnibhb@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2538186705051703479bd0c29@mail.gmail.com>
	 <e9iUj0EZ.1116327879.1515720.khali@localhost>
	 <2538186705051704181a70dbbf@mail.gmail.com>
	 <0pik81hjboqvbf2jhgdut861cfpgl7sata@4ax.com>
	 <2538186705051713565d07e66b@mail.gmail.com>
	 <lqrk81degqp2id4sf1f4rjsnithljnibhb@4ax.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/05, Grant Coady <grant_lkml@dodo.com.au> wrote:
> Hi Yani,
> 
> On Tue, 17 May 2005 16:56:04 -0400, Yani Ioannou <yani.ioannou@gmail.com> wrote:
> >Those are the sysfs names? If so something looks wrong with the
> 
> Not the final ones, just from first macro expansion of driver
> source, that's why I'd like to see changes on w83627hf driver
> as I can test it right through.
>
> No, I'm not doing a proper compile, I'm intentionally doing partial
> compile of driver.c and _not_ including headers, ignoring errors due
> to missing headers.

Ah..OK, that is probably why, I've put the macros which would be
expanded in the first level in a separate header because it will
probably be shared amongst many drivers. Although I still don't see
where SENSOR_blah is coming from at all at the moment, if you can
track that down I'd be interested to know if its just something to do
with the script or a problem with the patch.


> Script is work in progress, updated to current version up at:
> 
>   http://scatter.mine.nu/hwmon/sysfs-names/

Ok, I'll have a look at it later.
> 
> >The group of attributes you've highlighted below don't use
> >sensor_device_attribute on purpose because they don't benefit from the
> >dynamic sysfs callbacks, mainly because they are singletons. Well its
> 
> Not singletons, 3 of each (from an intermediate file):
> 
> adm1026.c       temp1_crit_enable       S_IRUGO S_IWUSR
> adm1026.c       temp2_crit_enable       S_IRUGO S_IWUSR
> adm1026.c       temp3_crit_enable       S_IRUGO S_IWUSR
> adm1026.c       pwm1    S_IRUGO S_IWUSR
> adm1026.c       pwm2    S_IRUGO S_IWUSR
> adm1026.c       pwm3    S_IRUGO S_IWUSR
> adm1026.c       temp1_auto_point1_pwm   S_IRUGO S_IWUSR
> adm1026.c       temp2_auto_point1_pwm   S_IRUGO S_IWUSR
> adm1026.c       temp3_auto_point1_pwm   S_IRUGO S_IWUSR
> adm1026.c       temp1_auto_point2_pwm   S_IRUGO
> adm1026.c       temp2_auto_point2_pwm   S_IRUGO
> adm1026.c       temp3_auto_point2_pwm   S_IRUGO
> 
> Yet, in related groups of three you have:
> 
> adm1026.c       SENSOR_temp1_crit       S_IRUGO S_IWUSR
> adm1026.c       SENSOR_temp2_crit       S_IRUGO S_IWUSR
> adm1026.c       SENSOR_temp3_crit       S_IRUGO S_IWUSR

Well I said mainly singletons :-), some of the attributes don't
benefit from the dynamic sysfs callbacks simply because they already
only use one callback for a few different attributes, I believe that's
the case with the non-singletons in this case.

Thanks,
Yani
