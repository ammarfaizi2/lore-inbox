Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282213AbRLaGFA>; Mon, 31 Dec 2001 01:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286723AbRLaGEu>; Mon, 31 Dec 2001 01:04:50 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:42768 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S282213AbRLaGEp>; Mon, 31 Dec 2001 01:04:45 -0500
Message-ID: <3C2FFF1C.BC989F2F@zip.com.au>
Date: Sun, 30 Dec 2001 22:01:00 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>,
        Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] [WIP] Unbork fs.h, 1 of 3
In-Reply-To: <E16Kv7E-0003CM-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> ...
> Nevertheless, the VFS still calls the module_exit for the root filesystem,
> which calls unregister_filesystem, which tries to destroy the its own inode
> cache, which isn't empty, because of special-case code connected with the
> root.

As far as I know, UML is the only port which implements exitcalls
for statically linked code.  So this problem won't be observed on
the other architectures.

The problem still *exists*, of course, but isn't too serious.  Maybe a
judicious hack to hide the problem would suffice.  Depends how hard
it is to unmount root during shutdown.


-
