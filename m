Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318041AbSG2Acb>; Sun, 28 Jul 2002 20:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318043AbSG2Acb>; Sun, 28 Jul 2002 20:32:31 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23049 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318041AbSG2Aca>; Sun, 28 Jul 2002 20:32:30 -0400
Date: Sun, 28 Jul 2002 17:37:07 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/13] remove pages from the LRU in __free_pages_ok()
In-Reply-To: <3D448D38.D156C249@zip.com.au>
Message-ID: <Pine.LNX.4.44.0207281733370.8208-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 28 Jul 2002, Andrew Morton wrote:
>
> OK.  This means that put_page() against userspace-mapped pages
> is to be avoided.

Yes. I think we've gotten most of it, and I just fixed the
access_process_vm() thing in my tree.

> Did an audit.  What on earth is drivers/scsi/sg.c:sg_rb_correct4mmap()
> doing?

I don't know. The code looks fundamentally broken (why do a
"put_page_testzero()" if you don't actually test the return value?
Somebody is confused).

		Linus

