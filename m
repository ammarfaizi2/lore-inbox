Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280889AbRKTD6q>; Mon, 19 Nov 2001 22:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280883AbRKTD6h>; Mon, 19 Nov 2001 22:58:37 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:2664 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S280878AbRKTD63>; Mon, 19 Nov 2001 22:58:29 -0500
To: Rock Gordon <rockgordon@yahoo.com>
Cc: Terje Eggestad <terje.eggestad@scali.no>, linux-kernel@vger.kernel.org
Subject: Re: Executing binaries on new filesystem
In-Reply-To: <20011119163455.11507.qmail@web14804.mail.yahoo.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Nov 2001 20:39:33 -0700
In-Reply-To: <20011119163455.11507.qmail@web14804.mail.yahoo.com>
Message-ID: <m18zd26rgq.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rock Gordon <rockgordon@yahoo.com> writes:

> All said and done, the file is with correct
> permissions (for that matter any binary that I execute
> on my filesystem has correct permissions). The only
> thing strace tells me is "bad file format". The same
> binary works perfectly elsewhere.
> 
> I don't think mmap is the problem; you don't need it
> in order to run binaries ...

Yes you do.   Look at all of the calls to do_mmap in binfmt_elf,
binfmt_aout and others.  The only case that doesn't use mmap
is old a.out binaries that are not properly aligned so cannot be
mmaped.

Linux implements demand paging in the loading of binaries and
for that you need mmap.

Eric


