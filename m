Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261495AbTAXSdy>; Fri, 24 Jan 2003 13:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261506AbTAXSdy>; Fri, 24 Jan 2003 13:33:54 -0500
Received: from taz.cerebus.com ([208.254.26.145]:12241 "EHLO taz.cerebus.com")
	by vger.kernel.org with ESMTP id <S261495AbTAXSdx>;
	Fri, 24 Jan 2003 13:33:53 -0500
Date: Fri, 24 Jan 2003 13:43:00 -0500 (EST)
From: David C Niemi <lkernel2003@tuxers.net>
To: linux-kernel@vger.kernel.org
Subject: SSH Hangs in 2.5.59 and 2.5.55 but not 2.4.x, through Cisco PIX
Message-ID: <Pine.LNX.4.44.0301241237160.29548-100000@harappa.oldtrail.reston.va.us>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have been experiencing some baffling SSH client hangs under 2.5.59 (and
55) in which the session totally hangs up after I have typed (typically)
10-100 characters.  Right before it hangs permanently, a character is
echo'd back to the screen several seconds late.  Interestingly, data due
back for my client which is initiated by the server side does make it, I 
just can't type anything further.

To reproduce this: ssh in to a somewhat distant host.  At a command 
prompt, hold down a letter key for a couple of minutes, or just type text 
in.  If you cut'n'paste text, it rarely hangs (my guess is that this 
requires a lot fewer round trips than interactive typing).  It should hang 
before you get a screenful (sometimes the sessions hang even before they 
are set up).

The system involved is a new Dell desktop with a P4/2.6 CPU and an
integrated Intel E1000 NIC, being used at 100Mb full duplex
(autonegotiated).  Sessions go through a Cisco PIX on their way to
anywhere useful.  The problem doesn't seem to occur if the SSH client and
server are on the same subnet; I'm not sure whether the PIX is an
essential cause of this or if any old router would do the same thing.  
I've also reproduce it while being attached to different 100TX switches,
so I think the problem is higher-level.

As for networking options, I see the problem both using the (rather 
extensive) default options, and a stripped down set of options with no QOS 
or netfilter or anything else fancy.

Neither "ifconfig" nor dmesg show *any* errors whatsoever.

Anyone else seeing SSH client hangs to nonlocal hosts under 2.5.59?

David C Niemi

