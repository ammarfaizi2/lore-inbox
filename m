Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965000AbVINEyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965000AbVINEyI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 00:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932632AbVINEyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 00:54:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:63159 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932624AbVINEyG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 00:54:06 -0400
Date: Wed, 14 Sep 2005 06:54:05 +0200
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Markus F.X.J. Oberhumer" <markus@oberhumer.com>,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>, jh@suse.cz
Subject: Re: [PATCH] i386: fix stack alignment for signal handlers
Message-ID: <20050914045405.GA11338@wotan.suse.de>
References: <43273CB3.7090200@oberhumer.com> <Pine.LNX.4.58.0509131542510.26803@g5.osdl.org> <4327611D.7@oberhumer.com> <Pine.LNX.4.58.0509131649060.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509131649060.26803@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Andi - you know the gcc people, is there some documented rules somewhere? 
> How does gcc itself try to align the stack when it generates the calls?

The x86-64 ABI says

>>
    The end of the input argument area shall be aligned on a 16 byte boundary.
In other words, the value (%rsp - 8) is always a multiple of 16 when control is
transferred to the function entry point. The stack pointer, %rsp, always points to
the end of the latest allocated stack frame. 7
<<

I presume acts i386 (it's likely undocumented because the ABI documents
predate this), but Jan surely can confirm? 

It makes sense because when long double is passed on the stack
you really want them to be aligned there.

This would mean Markus' patch is correct for x86-64 and likely for i386
too.

-Andi

