Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316620AbSEPKLl>; Thu, 16 May 2002 06:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316621AbSEPKLk>; Thu, 16 May 2002 06:11:40 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:516 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S316620AbSEPKLk>; Thu, 16 May 2002 06:11:40 -0400
Date: Thu, 16 May 2002 12:11:40 +0200
From: Pavel Machek <pavel@suse.cz>
To: Mark Gross <mgross@unix-os.sc.intel.com>
Cc: Pavel Machek <pavel@suse.cz>, "Vamsi Krishna S ." <vamsi@in.ibm.com>,
        "Gross, Mark" <mark.gross@intel.com>,
        "'Erich Focht'" <efocht@ess.nec.de>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        "'Bharata B Rao'" <bharata@in.ibm.com>
Subject: Re: PATCH Multithreaded core dump support for the 2.5.14 (and 15) kernel.
Message-ID: <20020516101140.GB10035@atrey.karlin.mff.cuni.cz>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C057B485B@orsmsx111.jf.intel.com> <20020515120722.A17644@in.ibm.com> <20020515140448.C37@toy.ucw.cz> <200205152353.g4FNrew30146@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Thread 1 is in kernel and holds lock A. You need lock A to dump state.
> > When you move 1 to phantom runqueue, you loose ability to get A and
> > deadlock.
> >
> > What prevents that?
> 
> Any pending tasklet / bottom half + top half get processes by the real CPU's 
> even thought the I/O bound process may have been moved to the phantom run 
> queue.  Its just that for the suspended processes sitting on the phantom 
> queue this processing stops with the call to try_to_wake_up, until the 
> process is moved back onto a run queue with a CPU.
> 
> The only way I can see what your talking about happening is for some kernel 
> code (or driver) to grab a lock and then hold it across a call to one of the 
> sleep_on functions pending some I/O.
> 
> Any driver that holds a lock across any sleep_on call I think is abusing 
> locks and needs adjusting.

I do not think so. It is okay to grab a lock then sleep.
									Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
