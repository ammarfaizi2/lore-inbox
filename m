Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315958AbSEGTyZ>; Tue, 7 May 2002 15:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315959AbSEGTyY>; Tue, 7 May 2002 15:54:24 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:21376 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315958AbSEGTyX>;
	Tue, 7 May 2002 15:54:23 -0400
Message-ID: <3CD830BE.CAB7FA96@vnet.ibm.com>
Date: Tue, 07 May 2002 14:53:34 -0500
From: Dave Engebretsen <engebret@vnet.ibm.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Memory Barrier Definitions
In-Reply-To: <3CD825E4.6950ED92@vnet.ibm.com> <E175AyE-0008NR-00@the-village.bc.nu>
X-MIMETrack: Itemize by SMTP Server on d27ml101/27/M/IBM(Release 5.0.10 |March 22, 2002) at
 05/07/2002 02:53:36 PM,
	Serialize by Router on d27ml101/27/M/IBM(Release 5.0.10 |March 22, 2002) at
 05/07/2002 02:53:37 PM,
	Serialize complete at 05/07/2002 02:53:37 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > A solution was pointed out by Rusty Russell that we should probabily be
> > using smp_*mb() for system memory ordering and reserve the *mb() calls
> 
> For pure compiler level ordering we have barrier()
> 
> Alan
> 

Sure, but none of these issues I think need disscussion are a compiler
reordering.  Perhaps you are just pointing out another barrier primitive
to provide a more complete listing?  There are some others, such as the
*before_atomic* that will require a seperate discussion, I think.

In case my point was not clear, I'll restate: where PowerPC (at a
minimum) gets into trouble is with the seperate ordering between
references to system memory and to I/O space with respect to the various
forms of processor memory barrier instructions.  It is _very_ expensive
to blindly force all memory references to be ordered completely to the
seperate spaces.  The use of wmb(), rmb(), and mb() is overloaded in the
context of PowerPC.

Dave.
