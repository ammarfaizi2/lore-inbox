Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267391AbUG2Anv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267391AbUG2Anv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 20:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267380AbUG2Akr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 20:40:47 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:4043 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S267377AbUG2AkK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 20:40:10 -0400
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] USB trouble since 2.6.8-rc1...
Date: Tue, 27 Jul 2004 13:17:39 -0700
User-Agent: KMail/1.6.2
Cc: Wes Janzen <superchkn@sbcglobal.net>, linux-kernel@vger.kernel.org
References: <41004A8C.1000906@sbcglobal.net>
In-Reply-To: <41004A8C.1000906@sbcglobal.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200407271317.39470.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 July 2004 16:15, Wes Janzen wrote:
> I've been having trouble with USB since 2.6.8-rc1; khubd ends up 
> blocking on something which makes USB hotplugging stop working (and only 
> half my devices even get initialized).  I did get 2.6.8-rc1 to work once 
> though it seemed to help inserting modules before calling hotplug.  
> However I haven't been able to repeat that during my last 5 attempts 
> with no changes besides a reboot.  I'm running 2.6.7-ck5 right now with 
> no apparent problems.
> 
> I haven't done extensive testing, but things seemed to work OK until I 
> plugged in my Belkin F5U231 4-port multi-tt hub.  My other hub is a 
> 4-port single-tt Belkin F5U224.

The log messages you sent didn't show a multi-tt hub ... just a
single-TT one from NEC.

One of the boot problems you had was because you didn't start
EHCI first.  That meant that when you started EHCI, it grabbed
that hub, which had already been enumerated (and the devices
on the hub) ... it's possible some of the recent changes to the
hub code made that misbehave.  Basically it's like pulling out
a hub with three devices attached, and I think I recently saw
that misbehave too.

If that's really what's up, then the workaround is to do what you
should have been doing all along:  initialize EHCI first, so it
grabs all high speed devices before the other controllers grab
on to them.

- Dave
