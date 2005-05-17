Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262005AbVEQU4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbVEQU4X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 16:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbVEQU4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 16:56:22 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:4544 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261999AbVEQU4F convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 16:56:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ayTKLdLlzkuZ21W4hPhUfhIQupVioHLYHh1YySsdkwnogy+oUgPykUBqzR79A+0/wETw6OlDxF8mz71yB+UHiOqyd/Cdr5jc8tj22Fjq66Pley1UIzPs3VvB8V9YAgScBEi3DmfznhgdfLzLyspaR01x4Z1WSsCfI8vUa/mlFP0=
Message-ID: <2538186705051713565d07e66b@mail.gmail.com>
Date: Tue, 17 May 2005 16:56:04 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
To: Grant Coady <grant_lkml@dodo.com.au>
Subject: Re: [lm-sensors] [PATCH 2.6.12-rc4 15/15] drivers/i2c/chips/adm1026.c: use dynamic sysfs callbacks
Cc: Jean Delvare <khali@linux-fr.org>, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
In-Reply-To: <0pik81hjboqvbf2jhgdut861cfpgl7sata@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2538186705051703479bd0c29@mail.gmail.com>
	 <e9iUj0EZ.1116327879.1515720.khali@localhost>
	 <2538186705051704181a70dbbf@mail.gmail.com>
	 <0pik81hjboqvbf2jhgdut861cfpgl7sata@4ax.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Grant,

Those are the sysfs names? If so something looks wrong with the
SENSOR_ ones..maybe an unintended effect of the new
sensor_device_attribute macro. I can't seem to find anything like that
in "gcc -I ../../../include/ -E adm1026.c" though, would you mind
sending me your script? Also make sure you are including the new
i2c-sysfs.h header file.

The group of attributes you've highlighted below don't use
sensor_device_attribute on purpose because they don't benefit from the
dynamic sysfs callbacks, mainly because they are singletons. Well its
possible you could roll all the attribute callbacks into one if you
wanted but that seems a bit extreme, and you'd have a large nasty
if-else going on in it :-).

BTW looks like a useful script :-), I'm always worried when doing
these changes I might accidently change a sysfs attribute permission.

Thanks,
Yani

On 5/17/05, Grant Coady <grant_lkml@dodo.com.au> wrote:
> Hi Yani,
> On Tue, 17 May 2005 07:18:51 -0400, Yani Ioannou <yani.ioannou@gmail.com> wrote:
> 
> Following is derived from gcc -E adm1026.c with your patch (the
> script strips all but base number from numbered names):
> 
> adm1026.c    SENSOR_fan1_div                    RW
> adm1026.c    SENSOR_fan1_input                  R
> adm1026.c    SENSOR_fan1_min                    RW
> adm1026.c    SENSOR_in0_input                   R
> adm1026.c    SENSOR_in0_max                     RW
> adm1026.c    SENSOR_in0_min                     RW
> adm1026.c    SENSOR_temp1_auto_point1_temp      RW
> adm1026.c    SENSOR_temp1_auto_point1_temp_hyst R
> adm1026.c    SENSOR_temp1_crit                  RW
> adm1026.c    SENSOR_temp1_input                 R
> adm1026.c    SENSOR_temp1_max                   RW
> adm1026.c    SENSOR_temp1_min                   RW
> adm1026.c    SENSOR_temp1_offset                RW
> adm1026.c    alarm_mask                         RW
> adm1026.c    alarms                             R
> adm1026.c    analog_out                         RW
> adm1026.c    gpio                               RW
> adm1026.c    gpio_mask                          RW
> adm1026.c    pwm1                               RW << these also should also
> adm1026.c    pwm1_enable                        RW << have SENSOR_ in front
> adm1026.c    temp1_auto_point1_pwm              RW << of them, seems you
> adm1026.c    temp1_crit_enable                  RW << missed a group?
> adm1026.c    vid                                R
> adm1026.c    vrm                                RW
> 
> I'm assuming some magic elsewhere sees that 'SENSOR_' and removes
> it before it gets to sysfs.  I can test adm9240, w83627hf and it87
> drivers as well as watch the overall patterns as above.
> 
> --Grant.
> 
>
