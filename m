Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315487AbSEWBM1>; Wed, 22 May 2002 21:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315546AbSEWBM0>; Wed, 22 May 2002 21:12:26 -0400
Received: from crack.them.org ([65.125.64.184]:17420 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S315487AbSEWBMY>;
	Wed, 22 May 2002 21:12:24 -0400
Date: Wed, 22 May 2002 20:12:18 -0500
From: Daniel Jacobowitz <dmj+@andrew.cmu.edu>
To: Mark Gross <mgross@unix-os.sc.intel.com>
Cc: "Gross, Mark" <mark.gross@intel.com>, "'Erich Focht'" <efocht@ess.nec.de>,
        "'linux-kernel'" <linux-kernel@vger.kernel.org>,
        "'Robert Love'" <rml@tech9.net>,
        "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
        "Luck, Tony" <tony.luck@intel.com>
Subject: Re: PATCH Multithreaded core dumps for the 2.5.17 kernel  was ....RE: PATCH Multithreaded core dump support for the 2.5.14 (and 15) kernel.
Message-ID: <20020522201218.B16554@crack.them.org>
Mail-Followup-To: Mark Gross <mgross@unix-os.sc.intel.com>,
	"Gross, Mark" <mark.gross@intel.com>,
	'Erich Focht' <efocht@ess.nec.de>,
	'linux-kernel' <linux-kernel@vger.kernel.org>,
	'Robert Love' <rml@tech9.net>,
	'Alan Cox' <alan@lxorguk.ukuu.org.uk>,
	"Luck, Tony" <tony.luck@intel.com>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C057B489B@orsmsx111.jf.intel.com> <20020522183246.B16176@crack.them.org> <200205230009.g4N09Ow08254@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2002 at 05:09:01PM -0400, Mark Gross wrote:
> On Wednesday 22 May 2002 07:32 pm, Daniel Jacobowitz wrote:
> >
> > What about other things which take mmap_sem?  I believe at least ptrace
> > is involved.  The notion of avoiding taking a semaphore like this is a
> > somewhat risky one.
> 
> Yes access_process_vm down_writes the mmap_sem.  However; it can only read 
> and write to existing user pages.  As long as it doesn't delete any of them 
> its not a problem.  It won't cause a dead lock or panic during the core dump 
> processing if this happens.  
> 
> The only process I know that could honestly use this ptrace function is GDB 
> doing live debugging.
> 
> >
> > Why shouldn't you take the semaphore as before in elf_core_dump, if you
> > know that no suspended process has it - which you do if you hold it
> > while suspending them?
> 
> For Ia64 those down_writes are just a pain.  If a user application is 
> crashing because someone is being rude with GDB corrupting its user pages 
> then I don't think its worth the hassle of protecting the core dumped user 
> page mm data from being messed up by a GDB user.
> 
> I would like to leave the down_write out of elf_core_dump, but it could be 
> put back if its felt that its needed.
> 
> Opinions? Comments?

I'm not worried about the application crashing.  I'm worried about
oopsing if someone is poking at the mmap_sem while we are pretending to
have it.  If that is not a valid concern, there should at least be a
big red flag saying so.

-- 
Daniel Jacobowitz                           Debian GNU/Linux Developer
MontaVista Software                         Carnegie Mellon University
