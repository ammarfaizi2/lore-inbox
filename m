Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316494AbSEOUMu>; Wed, 15 May 2002 16:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316488AbSEOULg>; Wed, 15 May 2002 16:11:36 -0400
Received: from [195.39.17.254] ([195.39.17.254]:33943 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316492AbSEOUKd>;
	Wed, 15 May 2002 16:10:33 -0400
Date: Wed, 15 May 2002 14:04:48 +0000
From: Pavel Machek <pavel@suse.cz>
To: "Vamsi Krishna S ." <vamsi@in.ibm.com>
Cc: "Gross, Mark" <mark.gross@intel.com>, "'Erich Focht'" <efocht@ess.nec.de>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        "'Bharata B Rao'" <bharata@in.ibm.com>
Subject: Re: PATCH Multithreaded core dump support for the 2.5.14 (and 15) kernel.
Message-ID: <20020515140448.C37@toy.ucw.cz>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C057B485B@orsmsx111.jf.intel.com> <20020515120722.A17644@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> To respond to your specific question, if a thread happens to be in 
> kernel mode when some other thread is dumping core (capturing
> register state of other threads, to be more accurate) then
> we would capture the _user mode_ register of that thread from the
> bottom of it's kernel stack. GDB will show back trace untill the
> thread entered kernel (int 0x80), eip will be pointing to the
> instruction after the system call (return address).

Okay, what about:

Thread 1 is in kernel and holds lock A. You need lock A to dump state.
When you move 1 to phantom runqueue, you loose ability to get A and
deadlock.

What prevents that?
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

