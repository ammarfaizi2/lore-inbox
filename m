Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964926AbWBAKHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbWBAKHV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 05:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbWBAKHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 05:07:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57302 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964926AbWBAKHT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 05:07:19 -0500
Date: Wed, 1 Feb 2006 02:06:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: Avuton Olrich <avuton@gmail.com>
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@codemonkey.org.uk>,
       john stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.16-rc1-mm4
Message-Id: <20060201020650.47b92fad.akpm@osdl.org>
In-Reply-To: <3aa654a40602010154r54e0072bp3e7bd46ce9aafa03@mail.gmail.com>
References: <20060129144533.128af741.akpm@osdl.org>
	<3aa654a40601311445t65fc9b6aqf2d565b72ded9c1a@mail.gmail.com>
	<20060131151028.3a6c1c75.akpm@osdl.org>
	<3aa654a40602010154r54e0072bp3e7bd46ce9aafa03@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avuton Olrich <avuton@gmail.com> wrote:
>
> On 1/31/06, Andrew Morton <akpm@osdl.org> wrote:
> > Avuton Olrich <avuton@gmail.com> wrote:
> > > I'm getting a kernel panic on my Libretto L5 on boot, I don't have a
> > > serial port on this laptop, I don't have time at the moment to setup
> > > netconsole, and it doesn't get the full information. Hopefully this
> > > picture helps a bit:
> > >
> > > http://68.111.224.150:8080/P1010306.JPG
> > >
> > > If it doesn't help I will attempt to get a netconsole on this computer
> > > on the near future.
> >
> > jpeg is fine.  It helps if you can get 50 rows on the screen - boot with
> > the appropriate `vga=' option, put SYSFONT="iso08.08" in
> > /etc/sysconfig/i18n, etc.
> >
> > It seems that some cpufreq notifier has done a divide-by-zero.  But I can't
> > see any sign of which one it is.  You might get a better trace if you set
> > CONFIG_FRAME_POINTER=n.
> >
> > If you could do those things and then prepare another photo it would really
> > help, thanks.
> 
> Disabled CONFIG_FRAME_POINTER and changed my font to ultra small. It's
> painful to read so use a good image viewing tool with zoom :)
> 
> http://68.111.224.150:8080/P1010001.JPG
> 
> Also, I tried the cpufreq.debug=7 thing that Dave Jones recommended
> and got no more output than I got without. I may have done something
> wrong, please let me know if it's needed.
> 

Ah, better, thanks.

You got the divide-by-zero in time_cpufreq_notifier().  John has been
playing with that in the time patches in -mm, so perhaps he broke it?

At a guess I'd say that there's some new startup ordering thing and
we're now passing zero into cpufreq_scale().
