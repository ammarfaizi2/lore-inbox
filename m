Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261666AbVCYO6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbVCYO6o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 09:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbVCYO6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 09:58:44 -0500
Received: from rproxy.gmail.com ([64.233.170.198]:39250 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261666AbVCYO6l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 09:58:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=h3KofV5U4vowms+5e+FPGRfxL5bGw/9+laACMtLJU0zIX1NM0tbvseBP3B/OcGg5UT59a4nBtg890E+qLMqmNf6Bxm37NX6yXwCJlRKjq6fp5BaRS+adtl3r+2awwwZjMjXWMN40ZbzYBwT1fjhuuHUgubz8csKvwWiNanDjIak=
Message-ID: <d120d50005032506582451d581@mail.gmail.com>
Date: Fri, 25 Mar 2005 09:58:40 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Andy Isaacson <adi@hexapodia.org>
Subject: Re: swsusp 'disk' fails in bk-current - intel_agp at fault?
Cc: Stefan Seyfried <seife@suse.de>,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050324235439.GA27902@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050323184919.GA23486@hexapodia.org> <4242CE43.1020806@suse.de>
	 <20050324181059.GA18490@hexapodia.org> <4243252D.6090206@suse.de>
	 <d120d50005032413145adaa283@mail.gmail.com>
	 <d120d50005032413105950045c@mail.gmail.com>
	 <20050324235439.GA27902@hexapodia.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Mar 2005 15:54:39 -0800, Andy Isaacson <adi@hexapodia.org> wrote:
> On Thu, Mar 24, 2005 at 04:10:39PM -0500, Dmitry Torokhov wrote:
> > If you do "ls /sys/bus/serio/devices" and see more than 3 ports you
> > have MUX mode active.
> 
> Just serio0 and serio1.
> 
> On Thu, Mar 24, 2005 at 04:14:52PM -0500, Dmitry Torokhov wrote:
> > On Thu, 24 Mar 2005 12:20:40 -0800, Andy Isaacson <adi@hexapodia.org> wrote:
> > > (How can I verify that "nomux" was accepted?  It shows up on the "Kernel
> > > command line" but there's no other mention of it in dmesg.)
> >
> > Ignore my babbling, I just noticed in your dmesg that your KBC does
> > not support MUX mode to begin with.
> 
> OK, anything else I should try?
> 
> Why does it only fail when I have *both* intel_agp and i8042 aux?
> 
> In the SysRq-T trace I see one interesting process: most things are
> in D state in refrigerator(), but sh shows the following traceback:
> 
> wait_for_completion
> call_usermodehelper
> kobject_hotplug
> kobject_del
> class_device_del
> class_device_unregister
> mousedev_disconnect
> input_unregister_device
> alps_disconnect
> psmouse_disconnect
> serio_driver_remove
> device_release_driver
> serio_release_driver
> serio_resume

I wonder why ALPS reconnect failed. You don't have a serial console
set up, do you? If not then maybe you could make a huge framebuffer to
capture as much info as you can... I hope you have a digital camera ;)

Then do "echo 1 > /sys/modules/i8042/parameters/debug" and try to
suspend. I am interested of data coming in and out of i8042.

-- 
Dmitry
