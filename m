Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262872AbTDIH1S (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 03:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262877AbTDIH1S (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 03:27:18 -0400
Received: from granite.he.net ([216.218.226.66]:38150 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S262872AbTDIH1R (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 03:27:17 -0400
Date: Wed, 9 Apr 2003 00:41:24 -0700
From: Greg KH <greg@kroah.com>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: KML <linux-kernel@vger.kernel.org>, sensors@Stimpy.netroedge.com
Subject: Re: [PATCH-2.5] Fix w83781d sensor to use Milli-Volt for in_* in sysfs
Message-ID: <20030409074124.GA9813@kroah.com>
References: <1049750163.4174.35.camel@nosferatu.lan> <20030407215443.GA4386@kroah.com> <1049775078.23992.2.camel@nosferatu.lan> <20030408220444.GA6674@kroah.com> <1049869101.2754.31.camel@workshop.saharact.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049869101.2754.31.camel@workshop.saharact.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 09, 2003 at 08:18:21AM +0200, Martin Schlemmer wrote:
> On Wed, 2003-04-09 at 00:04, Greg KH wrote:
> 
> > Oh, I'm getting the following warning when building the driver, want to
> > look into this?
> > 
> > drivers/i2c/chips/w83781d.c: In function `store_fan_div_reg':
> > drivers/i2c/chips/w83781d.c:715: warning: `old3' might be used uninitialized in this function
> >   
> 
> It is because old3 is only referenced if:
> 
>  ((data->type != w83781d) && data->type != as99127f)
> 
> as those two chips don't have extended divisor bits ...
> 
> It is however set in the first occurrence:
> 
> ---------------------------------------------------------------------
>        /* w83781d and as99127f don't have extended divisor bits */
>        if ((data->type != w83781d) && data->type != as99127f) {
>                old3 = w83781d_read_value(client, W83781D_REG_VBAT);
>        }
> ---------------------------------------------------------------------
> 
> and thus is rather gcc being brain dead for not being able to figure
> old3 is only used within a if block like that.
> 
> I was not sure about style policy in a case like this, so I left it as
> is, it should however be possible to 'fix' it with:

Thanks, I've applied this.

greg k-h
