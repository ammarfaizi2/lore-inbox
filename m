Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbUBWObN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 09:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbUBWObN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 09:31:13 -0500
Received: from mail.shareable.org ([81.29.64.88]:24706 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261879AbUBWObJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 09:31:09 -0500
Date: Mon, 23 Feb 2004 14:30:56 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Coywolf Qi Hunt <coywolf@greatcn.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: BOOT_CS
Message-ID: <20040223143056.GC30321@mail.shareable.org>
References: <c16rdh$gtk$1@terminus.zytor.com> <40375261.6030705@greatcn.org> <20040221163213.GB15991@mail.shareable.org> <403984DD.4030108@greatcn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403984DD.4030108@greatcn.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt wrote:
> >It's to flush the instruction prefetch queue: that's one of the side
> >effects of ljmp.
> 
> Re-loading %cs and flushing prefetch queue are two different things.

Yes, they are.

> FYI, intel's example code located in STARTUP.ASM Listing arround line
> 180, chapter 9, IA-32 Intel Architecture Software Developer's Manual,
> Volume 3: System Programming Guide

Thanks.

> Please consider my patch for this issue.

I don't have the ability to look at that manual right now.

Your patch uses two instructions to flush the queue (push+ret) instead
of one (jmp or ljmp).  Is that documented as reliable?  I can easily
imagine an implementation which decodes one instruction after a mode
change predictably, but not two.

I doubt that it makes a difference - we're setting PG, not changing
the instruction format - but I'd like us to be sure it cannot fail on
things like 386s and 486s, and similar non-Intel chips.

-- Jamie
