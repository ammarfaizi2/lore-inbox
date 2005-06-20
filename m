Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbVFTKEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbVFTKEv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 06:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVFTKEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 06:04:32 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:39068 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261294AbVFTKE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 06:04:26 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Nick Warne <nick@linicks.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12 udev hangs at boot
Date: Mon, 20 Jun 2005 13:04:10 +0300
User-Agent: KMail/1.5.4
References: <200506181332.25287.nick@linicks.net> <42B45173.6060209@pobox.com> <200506181806.49627.nick@linicks.net>
In-Reply-To: <200506181806.49627.nick@linicks.net>
Cc: gregkh@suse.de, Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506201304.10741.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 June 2005 20:06, Nick Warne wrote:
> On Saturday 18 June 2005 17:53, Jeff Garzik wrote:
> > Nick Warne wrote:
> > > New 2.6.12 build hangs at initialising udev dynamic device directory on
> > > boot.
> >
> > Did you try simply waiting a while?
> >
> > udev took a long time to initialize (30-40 seconds) for me, then
> > everything worked and the machine booted just fine.
> >
> > I've seen this on both new and old udev.  Some patience will fix things :)
> 
> Yes, I waited a while first time.  No drive activity, no nothing.  Keyboard 
> was still awake though, so it wasn't a 'crash' as such. The boot just stopped 
> there twiddling it's thumbs...
> 
> Installing the latest udev though makes the machine boot so fast I can't see 
> the 'initialising udev devices' message unless I scroll back to see in 
> console.  I thought at first I broke it, and udev wasn't working at all now 
> and was being ignored, but it is working just fine :-)
> 
> But remember, what got me was it boots fine on 2.6.11.12, insomuch I never 
> really saw the udev message away and never had to investigate it before.

udev-030 is looking for detached_state somewhere inside /sys tree,
but somewhere between 2.6.12-rc3 and -rc5 detached_state is gone.

I installed udev-058 and it fixed things.

It took me more than hour to figure out, from 02:00 to after 03:00.

Greg, any plans to distribute udev and hotplug within kernel tarballs
so that people do not need to track such changes continuously?

After all, udev is tied to /sys layout which changes with kernel
and also udev is vital for properly functioning boot process
(I mean: if udev breaks, you cannot easily debug it: your box
is unusable since lots of things gone avry like gettys not having ttys
to let you log in...).
--
vda

