Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWHMHp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWHMHp7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 03:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbWHMHp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 03:45:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:15500 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750738AbWHMHp6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 03:45:58 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH for review] [43/145] i386: Redo semaphore and rwlock assembly helpers
Date: Sun, 13 Aug 2006 09:42:46 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, Jan Beulich <jbeulich@novell.com>
References: <20060810 935.775038000@suse.de> <200608130850.01592.ak@suse.de> <20060812235407.87f298d7.akpm@osdl.org>
In-Reply-To: <20060812235407.87f298d7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608130942.46376.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 13 August 2006 08:54, Andrew Morton wrote:
> On Sun, 13 Aug 2006 08:50:01 +0200
> Andi Kleen <ak@suse.de> wrote:
> 
> > On Sunday 13 August 2006 02:53, Andrew Morton wrote:
> > > On Thu, 10 Aug 2006 21:35:57 +0200 (CEST)
> > > Andi Kleen <ak@suse.de> wrote:
> > > 
> > > > - Move them to a pure assembly file. Previously they were in 
> > > > a C file that only consisted of inline assembly. Doing it in pure
> > > > assembler is much nicer.
> > > > - Add a frame.i include with FRAME/ENDFRAME macros to easily
> > > > add frame pointers to assembly functions 
> > > > - Add dwarf2 annotation to them so that the new dwarf2 unwinder
> > > > doesn't get stuck on them
> > > > [TBD: needs review from someone who knows more about CFA than me, e.g. Jan]
> > > > - Random cleanups
> > > 
> > > This patch causes the below crash after some seconds of disk stresstesting.
> > 
> > I can't reproduce this with either LTP nor OraSim.
> > Also I looked over the patch and i can't see any mistakes.
> > 
> > Can you double check please?
> > 
> 
> 2-way pIII with the below .config crashes in seconds running LTP's

Ok fixed now.

On the second patch revision I added FRAMEs to the write lock functions too
and that was broken in the frame pointer case, which I didn't retest :/
Sorry. Fixed now on ff.

-Andi
