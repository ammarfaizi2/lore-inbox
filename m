Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbTIURjs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 13:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262481AbTIURjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 13:39:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:51153 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262482AbTIURjr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 13:39:47 -0400
Date: Sun, 21 Sep 2003 10:39:26 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kronos <kronos@kronoz.cjb.net>
cc: davej@codemonkey.org.uk, <linux-kernel@vger.kernel.org>,
       <davej@redhat.com>
Subject: Re: [PATCH] Fix Athlon MCA
In-Reply-To: <20030921143934.GA1867@dreamland.darkstar.lan>
Message-ID: <Pine.LNX.4.44.0309211034080.11614-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 21 Sep 2003, Kronos wrote:
> 
> This messages go away if I revert cset 1.1119.9.1. AFAIK you were trying
> to decrease the logging level. After reading IA32 Architecture Software 
> Developers Manual, vol3 - chapter 14.5 "Machine-Check Initialization" I 
> think that the right way to do it is this:

Why not just handling the (different) 0-based case in front of the loop: 

	/* Clear status for MC index 0 separately, we don't touch CTL. */
	wrmsr (MSR_IA32_MC0_STATUS, 0x0, 0x0);

and leave the loop 1-based.

Dave, up to you..

		Linus

