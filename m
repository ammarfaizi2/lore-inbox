Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265249AbRHEXo3>; Sun, 5 Aug 2001 19:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264942AbRHEXoT>; Sun, 5 Aug 2001 19:44:19 -0400
Received: from [63.209.4.196] ([63.209.4.196]:57870 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265249AbRHEXoH>; Sun, 5 Aug 2001 19:44:07 -0400
From: Linus Torvalds <torvalds@transmeta.com>
Date: Sun, 5 Aug 2001 16:41:43 -0700
Message-Id: <200108052341.f75Nfhx08227@penguin.transmeta.com>
To: jakob@unthought.net, linux-kernel@vger.kernel.org
Subject: Re: /proc/<n>/maps getting _VERY_ long
Newsgroups: linux.dev.kernel
In-Reply-To: <20010806010738.B11372@unthought.net>
In-Reply-To: <20010805171202.A20716@weta.f00f.org> <E15TNbk-0007pu-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010806010738.B11372@unthought.net> you write:
>> 
>> Linus took itout because it was quite complex and nobody seemed to have
>> cases that triggered it or made it useful
>
>What ??
>
>It was put back in because RH GCC-2.96 triggers this too.  There was a thread
>about this some months ago.

Strictly speaking, it wasn't put back. 

What recent kernels will do is merge a certain subset of mergeable
areas: this speeds up anonymous page allocation, whether by
mmap(MAP_ANONYMOYS) or by brk(). That subset was just made a bit larger
(and no, the subset hasn't been shrunk).

However, it doesn't merge in the generic case (it does not merge
mappings with backing store, for example), and it also does not merge
the case of the user actively changing the memory protections, for
example. 

So we certainly used to do more aggressive merging.

We could merge more, but I'm not interested in working around broken
applications. Right now we sanely merge the cases of consecutive
anonymous mmaps, but we do _not_ merge cases where the app plays silly
games, for example.

I'd like to know more than just the app that shows problems - I'd like
to know what it is doing.

		Linus
