Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261768AbVBXDT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbVBXDT3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 22:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbVBXDT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 22:19:29 -0500
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:45710 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261768AbVBXDTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 22:19:08 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Anthony DiSante <theant@nodivisions.com>
Subject: Re: mouse still losing sync and thus jumping around
Date: Wed, 23 Feb 2005 22:18:56 -0500
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <421C83A2.9040502@vollwerbung.at> <d120d50005022308536d29dab7@mail.gmail.com> <421D4460.6050308@nodivisions.com>
In-Reply-To: <421D4460.6050308@nodivisions.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502232218.56665.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 February 2005 22:05, Anthony DiSante wrote:
> Dmitry Torokhov wrote:
> > Yes, It usually happens either under high load, when mouse interrupts are
> > significantly delayed. Or sometimes it happen when applications poll
> > battey status and on some boxes it takes pretty long time. And because
> > it is usually the same chip that serves keyboard/mouse it again delays
> > mouse interrupts.
> 
> I have this problem with recent 2.6.10 kernels too, but it has nothing to do 
> with load in my case; it happens whenever I switch my KVM to the linux box.
> 

Hi Anthony,

This is a bit different problem and we trying to find a reliable solution
for it.

> Long ago and far away, it used to be that switching out of X, then back in 
> (ctrl-alt-F1, then ctrl-alt-F7) would reset the mouse and stop the jumping. 
>   At some point in late 2.4/early 2.6 that stopped working, and the only fix 
> was to unplug the mouse from the KVM switch and re-plug it.
> 
> In Oct 2004 I posted to lkml with subject "KVM -> jumping mouse... still no 
> solution?"  Dmitry Torokhov (hi :) responded that this would work on 2.6.9-rc3+:
> 
> 	echo -n "reconnect" > /sys/bus/serio/devices/serioX/driver
> 
> That was GREAT and it worked for a while, but now my last few 2.6.10 kernels 
> don't seem to care when I do that, and again, unplugging the mouse is the 
> only thing that works.  I'm currently running 2.6.10-gentoo-r6.
> 

It still should work fine, but in a bit different form:

	echo -n "reconnect" > /sys/bus/serio/devices/serioX/drvctl

I.e. substitute "driver" with "drvctl" as now "driver" is a symlink to
a currently bound driver that is set up by driver core.

-- 
Dmitry
