Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbUBZXNV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 18:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbUBZXM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 18:12:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:62922 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261264AbUBZXJq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 18:09:46 -0500
Date: Thu, 26 Feb 2004 15:15:25 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jakub Jelinek <jakub@redhat.com>
cc: linux-kernel@vger.kernel.org, drepper@redhat.com
Subject: Re: [PATCH] Add getdents32t syscall
In-Reply-To: <20040226223212.GA31589@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.58.0402261504230.7830@ppc970.osdl.org>
References: <20040226193819.GA3501@sunsite.ms.mff.cuni.cz>
 <Pine.LNX.4.58.0402261411420.7830@ppc970.osdl.org>
 <Pine.LNX.4.58.0402261415590.7830@ppc970.osdl.org>
 <20040226223212.GA31589@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Feb 2004, Jakub Jelinek wrote:
> 
> Userland struct dirent is:

Ahh. So with the new thing, you'd need no conversion at all.

> (since 1997 or so), so with the extended getdents syscall glibc would need
> to memmove every name by 1 byte.

The thing is, I hate encouraging glibc's behaviour of "we'll make up our
own structures", and then ask the kernel to fix it later when it was done
wrong in glibc. This is a totally new format that is totally unnecessary,
and the RIGHT thing to do is to have glibc just use the proper 64-bit
format.

In other words, why doesn't glibc ever just make a new major number and
make its "struct dirent" be the 64-bit version? It is _ridiculous_ to
carry this baggage around, and then complain and add MORE baggage to the
kernel because of having done things wrong the first time around.

			Linus
