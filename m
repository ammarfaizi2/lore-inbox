Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317622AbSHHQRe>; Thu, 8 Aug 2002 12:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317638AbSHHQRe>; Thu, 8 Aug 2002 12:17:34 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:63222 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317622AbSHHQRd>;
	Thu, 8 Aug 2002 12:17:33 -0400
Date: Thu, 08 Aug 2002 11:20:50 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.30+] Second attempt at a shared credentials patch
Message-ID: <44050000.1028823650@baldur.austin.ibm.com>
In-Reply-To: <shsofcdfjt6.fsf@charged.uio.no>
References: <23130000.1028818693@baldur.austin.ibm.com>
 <shsofcdfjt6.fsf@charged.uio.no>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Thursday, August 08, 2002 05:32:05 PM +0200 Trond Myklebust
<trond.myklebust@fys.uio.no> wrote:

> What the hell is that change to fs/nfs/dir.c below all about? Try
> mounting an NFSv2 partition with that applied...

Oops.  Looks like I managed to make a mistake in merging.  Here's a fixed
version:

http://www.ibm.com/linux/ltc/patches/misc/cred-2.5.30-4.diff.gz

> Instead of doing this as one big unreadable monolithic patch and
> risking getting things wrong like in the above case, it would be nice
> if you could go via a set of wrapper functions:
> 
># define get_current_uid() (current->uid)
># define set_current_uid(a) current->uid = a

I don't see this as a win.  I *could* do a big monolithic patch to change
all references to current->*id to macros, then change the macros in a
separate patch.  But then we'd be stuck with macros for all those
references forever, and they're not likely to change again any time soon.
I don't think we'd really want to have macros for all our structure
references on the off chance that someone might change it in the future.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

