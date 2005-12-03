Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbVLCJGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbVLCJGl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 04:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbVLCJGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 04:06:41 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:15375 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751216AbVLCJGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 04:06:40 -0500
Date: Sat, 3 Dec 2005 10:06:32 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Daniel Bonekeeper <thehazard@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel loading question
Message-ID: <20051203090632.GC22139@alpha.home.local>
References: <e1e1d5f40512022134y73318ed4p54064a07905cef3c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1e1d5f40512022134y73318ed4p54064a07905cef3c@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2005 at 09:34:26PM -0800, Daniel Bonekeeper wrote:
> Well, this probably should not be posted here, but who knows ? =)
> 
> Well, on arch/i386/boot/compressed/head.S line 65 we call
> decompress_kernel that decompresses the kernel starting at $0x100000.
> If we were loaded high, we first move the code back to $0x1000 before
> ljmp'ing it.
> 
> My question is: why, when loaded high, we care to disable interrupts
> (cli  # make sure we don't get interrupted) while otherwise, we don't
> do that ? in both cases, aren't we supposed to disable cli (as they
> can happen in both situations) ?
> 
> Since currently, the kernel boots fine for everybody in the world, I
> know that this is not a bug... but why don't disable interruptions on
> both cases ?

Agreed it's strange. I believe that since very few people load the
kernel in low memory nowadays given its size, it's possible that the
missing CLI never gets noticed, and I suspect that the very first
instructions after the jump are a CLI anyway.

Regards,
Willy

