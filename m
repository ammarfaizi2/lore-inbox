Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161399AbWJ3TNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161399AbWJ3TNJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 14:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161261AbWJ3TNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 14:13:09 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:37289 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1161399AbWJ3TNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 14:13:08 -0500
Date: Mon, 30 Oct 2006 12:13:07 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Linus Torvalds <torvalds@osdl.org>, "Adam J. Richter" <adam@yggdrasil.com>,
       akpm@osdl.org, bunk@stusta.de, greg@kroah.com,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       pavel@ucw.cz, shemminger@osdl.org
Subject: Re: [patch] drivers: wait for threaded probes between initcall levels
Message-ID: <20061030191307.GE10235@parisc-linux.org>
References: <200610282350.k9SNoljL020236@freya.yggdrasil.com> <Pine.LNX.4.64.0610281651340.3849@g5.osdl.org> <A2B15573-3DDD-4F70-AC04-C37DBA3AC752@mac.com> <20061030144259.GD10235@parisc-linux.org> <87F87E8E-9434-4844-AA3F-ED850BEFAD29@mac.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87F87E8E-9434-4844-AA3F-ED850BEFAD29@mac.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2006 at 01:47:53PM -0500, Kyle Moffett wrote:
> Well, yes, but it would help some architectures.  It would seem  
> rather stupid to build a hardware limitation into a 64+ cpu system  
> such that it cannot initialize or reconfigure multiple pieces of  
> hardware at once.  It also would help for more "mundane" systems such  
> as my "Quad" G5 desktop which takes an appreciable time to probe all  
> the various PCI, USB, SATA, and  Firewire devices in the system.

Probing PCI devices really doesn't take that long.  It's the extra stuff
the drivers do at ->probe that takes the time.  And the stand-out
offender here is SCSI (and FC), which I'm working to fix.  Firewire, USB
and SATA are somewhere intermediate.
