Return-Path: <linux-kernel-owner+w=401wt.eu-S932823AbXAAUuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932823AbXAAUuF (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 15:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932825AbXAAUuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 15:50:04 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:40943 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932823AbXAAUuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 15:50:03 -0500
Message-ID: <459973F6.2090201@pobox.com>
Date: Mon, 01 Jan 2007 15:49:58 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Alessandro Suardi <alessandro.suardi@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       alan@lxorguk.ukuu.org.uk
Subject: Re: Happy New Year (and v2.6.20-rc3 released)
References: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org> <5a4c581d0701010528y3ba05247nc39f2ef096f84afa@mail.gmail.com> <Pine.LNX.4.64.0701011209140.4473@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701011209140.4473@woody.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Jeff, 
>  what was the resolution to this one? Just revert the offending commit, or 
> what?
> 
> We're about five weeks into the 2.6.20-rc series. I was hoping for a 
> two-month release rather than the usual dragged-out three months, so I'd 
> like to get these regressions to be actively fixed. By forcible reverts if 
> that is what it takes.

Data points:

* I was unable to argue against Alan's logic behind 
368c73d4f689dae0807d0a2aa74c61fd2b9b075f but I just don't like it. 
Regardless of whether or not this truly reflects how the PCI device is 
wired, it makes pci_request_regions() and similar resource handling code 
behave differently.

* Alan's 368c73d4f689dae0807d0a2aa74c61fd2b9b075f change was IMO 
incomplete, because he obviously did not fix all the breakage it caused

* Alan proposed a libata fix patch.  I noted two key breakages in his 
fix patch, one of which Alan agreed was a problem.

* Outside of the two bugfix pushes, I've been actively avoiding 
computers during the holidays.  It's a shocking concept I'm trying with 
the new wife :)  Don't expect anything useful from me until Jan 4th or so.

* This affects a lot of Intel ICH platforms in legacy/combined mode, so 
it's definitely high on my post-holiday priority list.  If the patch is 
not reverted, then I'll definitely fix it sooner rather than later.

* For 2.6.21, I proposed to yank out all the ugly combined mode hacks 
(grep for '____request_resource'), which should make Alan's change a bit 
easier... but nonetheless stirs the IDE quirks code again.

* I am lazy and would rather not touch the fragile ata_pci_init_one() 
code now /and/ in 2.6.21.


So I vote for revert, for 2.6.20, but I know Alan will squawk loudly. 
Also NOTE thoughfb0f2b40faff41f03acaa2ee6e6231fc96ca497c which fixes 
fallout from Alan's change, too.

	Jeff



