Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315411AbSEWAKV>; Wed, 22 May 2002 20:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315458AbSEWAKU>; Wed, 22 May 2002 20:10:20 -0400
Received: from scfdns02.sc.intel.com ([143.183.152.26]:64747 "EHLO
	crotus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S315411AbSEWAKT>; Wed, 22 May 2002 20:10:19 -0400
Message-Id: <200205230009.g4N09Ow08254@unix-os.sc.intel.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Mark Gross <mgross@unix-os.sc.intel.com>
Reply-To: mgross@unix-os.sc.intel.com
Organization: SSG Intel
To: Daniel Jacobowitz <dmj+@andrew.cmu.edu>,
        "Gross, Mark" <mark.gross@intel.com>
Subject: Re: PATCH Multithreaded core dumps for the 2.5.17 kernel  was ....RE: PATCH Multithreaded core dump support for the 2.5.14 (and 15) kernel.
Date: Wed, 22 May 2002 17:09:01 -0400
X-Mailer: KMail [version 1.3.1]
Cc: "'Erich Focht'" <efocht@ess.nec.de>,
        "'linux-kernel'" <linux-kernel@vger.kernel.org>,
        "'Robert Love'" <rml@tech9.net>,
        "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
        "Luck, Tony" <tony.luck@intel.com>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C057B489B@orsmsx111.jf.intel.com> <20020522183246.B16176@crack.them.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 May 2002 07:32 pm, Daniel Jacobowitz wrote:
>
> What about other things which take mmap_sem?  I believe at least ptrace
> is involved.  The notion of avoiding taking a semaphore like this is a
> somewhat risky one.

Yes access_process_vm down_writes the mmap_sem.  However; it can only read 
and write to existing user pages.  As long as it doesn't delete any of them 
its not a problem.  It won't cause a dead lock or panic during the core dump 
processing if this happens.  

The only process I know that could honestly use this ptrace function is GDB 
doing live debugging.

>
> Why shouldn't you take the semaphore as before in elf_core_dump, if you
> know that no suspended process has it - which you do if you hold it
> while suspending them?

For Ia64 those down_writes are just a pain.  If a user application is 
crashing because someone is being rude with GDB corrupting its user pages 
then I don't think its worth the hassle of protecting the core dumped user 
page mm data from being messed up by a GDB user.

I would like to leave the down_write out of elf_core_dump, but it could be 
put back if its felt that its needed.

Opinions? Comments?

--mgross


