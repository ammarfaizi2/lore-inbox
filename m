Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031680AbWLABLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031680AbWLABLY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 20:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031687AbWLABLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 20:11:24 -0500
Received: from mail.parknet.jp ([210.171.160.80]:35339 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1031680AbWLABLX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 20:11:23 -0500
X-AuthUser: hirofumi@parknet.jp
To: Nick Piggin <npiggin@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [patch 3/3] fs: fix cont vs deadlock patches
References: <20061130072058.GA18004@wotan.suse.de>
	<20061130072202.GB18004@wotan.suse.de>
	<20061130072247.GC18004@wotan.suse.de>
	<20061130113241.GC12579@wotan.suse.de>
	<87r6vkzinv.fsf@duaron.myhome.or.jp>
	<20061201002750.GA455@wotan.suse.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 01 Dec 2006 10:11:14 +0900
In-Reply-To: <20061201002750.GA455@wotan.suse.de> (Nick Piggin's message of "Fri\, 1 Dec 2006 01\:27\:50 +0100")
Message-ID: <873b80v2rx.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <npiggin@suse.de> writes:

> I would be happy if you come up with a quick fix, I'm just trying to
> stamp out a few big bugs in mm. However I did prefer my way of moving
> all the exapand code into generic_cont_expand, out of prepare_write, and
> avoiding holding the target page locked while we're doing all the expand
> work (strictly, you might be able to get away with this, but it is
> fragile and ugly).
>
> AFAIKS, the only reason to use prepare_write is to avoid passing the
> get_block into generic_cont_expand?

IIRC, because generic_cont_expand is designed as really generic. It
can also use for non moronic filesystem.

In the case of reiserfs, it ->prepare_write might be necessary.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
