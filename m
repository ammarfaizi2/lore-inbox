Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316350AbSEOG36>; Wed, 15 May 2002 02:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316351AbSEOG35>; Wed, 15 May 2002 02:29:57 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:30675 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S316350AbSEOG35>; Wed, 15 May 2002 02:29:57 -0400
Date: Wed, 15 May 2002 12:07:22 +0530
From: "Vamsi Krishna S ." <vamsi@in.ibm.com>
To: "Gross, Mark" <mark.gross@intel.com>
Cc: "'Erich Focht'" <efocht@ess.nec.de>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        "'Bharata B Rao'" <bharata@in.ibm.com>
Subject: Re: PATCH Multithreaded core dump support for the 2.5.14 (and 15) kernel.
Message-ID: <20020515120722.A17644@in.ibm.com>
Reply-To: vamsi@in.ibm.com
In-Reply-To: <59885C5E3098D511AD690002A5072D3C057B485B@orsmsx111.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erich,

To respond to your specific question, if a thread happens to be in 
kernel mode when some other thread is dumping core (capturing
register state of other threads, to be more accurate) then
we would capture the _user mode_ register of that thread from the
bottom of it's kernel stack. GDB will show back trace untill the
thread entered kernel (int 0x80), eip will be pointing to the
instruction after the system call (return address).

-- 
Vamsi Krishna S.
Linux Technology Center,
IBM Software Lab, Bangalore.
Ph: +91 80 5262355 Extn: 3959
Internet: vamsi@in.ibm.com

On Tue, May 14, 2002 at 09:38:28AM -0700, Gross, Mark wrote:
> See attached unit test code.  its not very pretty...
> 
> These are NOT exhaustive tests, yet they are a reasonable attempt at unit
> testing / exercising the feature to check for stability issues.  My stress
> test was to induce core dumps in these test programs while running the IBM
> chat room benchmark.  The XMM.c program was written by Rao Bharata as part
> of the 2.4.17 tcore testing.  I don't remember who wrote test.c, but ptest.c
> is my fault.
> 
> I know that the i386 elf core file note sections only contain the class of
> register data that's restored by __switch_to.  So I suppose a kernel thread,
> like the migration_thread, or ksoftirq "could" dump core and GDB could do a
> bt on such a dump.  However; these note sections only contain any data that
> can be accessed from a non-privileged processor modes and your mileage will
> vary.
> 
> --mgross
> 
> > -----Original Message-----
> > From: Erich Focht [mailto:efocht@ess.nec.de]
> > Sent: Tuesday, May 14, 2002 8:36 AM
> > To: mark.gross@intel.com
> > Cc: Linus Torvalds; linux-kernel@vger.kernel.org; Vamsi Krishna S .
> > Subject: Re: PATCH Multithreaded core dump support for the 2.5.14 (and
> > 15) kernel.
> > 
> > 
> > Hi Mark!
> > 
> > Thanks for sending the new patch, I'd be interested in the 
> > testprograms :-)
> > 
> > BTW: any idea what happens when a thread which is suspended 
> > happens to be in 
> > kernel mode? Guess this could be possible with 2.5.X... Does 
> > gdb handle that?
> > 
> > Regards,
> > Erich
> > 
> > On Monday 13 May 2002 21:17, you wrote:
> > > The following patch for 2.5.14 kernel, applies cleanly to the 2.5.15
> > > kernel.
> > >
> > > This work has been tested on the 2.5.14 kernel using a few pthread
> > > applications to dump core, from SIGQUIT and SIGSEV. This 
> > unit test has been
> > > done on both 2 and 4 way systems.  Further, some stress 
> > testing has been
> > > done where, the core files have been created while the 
> > system is under
> > > schedule stress from the chat room benchmark running while 
> > creating the
> > > core files.  This implementation seems to be quit stable 
> > under a busy
> > > scheduler, YMMV.  These test programs are available uppon request ;)
> > 
> > 
