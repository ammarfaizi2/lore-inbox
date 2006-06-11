Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751004AbWFKUsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbWFKUsP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 16:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbWFKUsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 16:48:15 -0400
Received: from liaag2ad.mx.compuserve.com ([149.174.40.155]:51885 "EHLO
	liaag2ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751001AbWFKUsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 16:48:14 -0400
Date: Sun, 11 Jun 2006 16:43:36 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] i386: use C code for current_thread_info()
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200606111647_MC3-1-C228-993B@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <Pine.LNX.4.64.0606111225380.5498@g5.osdl.org>

On Sun, 11 Jun 2006 12:33:10 -0700, Linus Torbalds wrote:

> On Sun, 11 Jun 2006, Chuck Ebbert wrote:
> >
> > Using C code for current_thread_info() lets the compiler optimize it.
> 
> Ok, me likee. I just worry that this might break some older gcc version. 
> Have you checked with gcc-3.2 or something?

I just tried gcc 3.3.3 and the kernel gets a little bigger but it boots
and runs OK. That's the oldest compiler I can find.

   text    data     bss     dec     hex filename
3593627  559864  342728 4496219  449b5b 2.6.17-rc6-32-post/vmlinux
3591371  559864  342728 4493963  44928b 2.6.17-rc6-32/vmlinux
  +2256

Looking at the generated code, it seems the compiler just makes dumb
choices and tends to recompute current_thread_info() in unlikely code
paths even when there is no register pressure.  4.0.2 makes better
choices.

-- 
Chuck

