Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbVIGUkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbVIGUkt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 16:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbVIGUkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 16:40:49 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:49612 "EHLO
	ogre.sisk.pl") by vger.kernel.org with ESMTP id S932248AbVIGUks
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 16:40:48 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: swsusp doesn't suspend devices
Date: Wed, 7 Sep 2005 22:40:42 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
       linux-pm@osdl.org
References: <431ECCE3.8080408@drzeus.cx> <200509072203.19283.rjw@sisk.pl> <431F4AC4.9030206@drzeus.cx>
In-Reply-To: <431F4AC4.9030206@drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509072240.42854.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 7 of September 2005 22:17, Pierre Ossman wrote:
> Rafael J. Wysocki wrote:
> 
> >On Wednesday, 7 of September 2005 13:20, Pierre Ossman wrote:
> >  
> >
> >>It would seem that swsusp doesn't properly suspend devices, or more
> >>precisely it wakes them up again before suspending the machine.
> >>    
> >>
> >
> >Yes, it does.  By design.
> >
> >  
> >
> 
> That seems counter-productive, so I'm obviously missing something.

In swsusp, the suspend consists of freezing processes, suspending devices, turning off
interrupts, and creating a memory snapshot (the image) in that state (ie of the "frozen"
system).  Afterwards the image is in memory and it has to be written to a swap partition.
For this purpose we need to resume some devices, in particular the disk that contains
this swap partition, but it always relies on some other devices that have to be resumed
as well.  In principle we could check what devices have to be resumed, but currently
we just resume them all.  An additional upside of this approach is that the suspend
and resume code is (almost) identical.

Greetings,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
