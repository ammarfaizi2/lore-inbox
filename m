Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266969AbSLQT6u>; Tue, 17 Dec 2002 14:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266998AbSLQT6u>; Tue, 17 Dec 2002 14:58:50 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:14005
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S266969AbSLQT6t>; Tue, 17 Dec 2002 14:58:49 -0500
Message-ID: <3DFF83C5.6000007@redhat.com>
Date: Tue, 17 Dec 2002 12:06:29 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20021216
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: "H. Peter Anvin" <hpa@transmeta.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.4.44.0212171132530.1095-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0212171132530.1095-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> The thing is, gettimeofday() isn't _that_ special. It's just not worth a
> vsyscall of it's own, I feel. Where do you stop? Do we do getpid() too?

This is why I'd say mkae no distinction at all.  Have the first
nr_syscalls * 8 bytes starting at 0xfffff000 as a jump table.  We can
transfer to a different slot for each syscall.  Each slot then could be
a PC-relative jump to the common sysenter code or to some special code
sequence which is also in the global page.

If we don't do this now and it seems desirable in future we wither have
to introduce a second ABI for the vsyscall stuff (ugly!) or you'll have
to do the demultiplexing yourself in the code starting at 0xfffff000.


-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

