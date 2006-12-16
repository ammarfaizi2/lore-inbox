Return-Path: <linux-kernel-owner+w=401wt.eu-S1161017AbWLPPFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161017AbWLPPFW (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 10:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161023AbWLPPFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 10:05:22 -0500
Received: from tallyho.bytemark.co.uk ([80.68.81.166]:55619 "EHLO
	tallyho.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161017AbWLPPFV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 10:05:21 -0500
Date: Sat, 16 Dec 2006 14:48:13 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Avi Kivity <avi@argo.co.il>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: Userspace I/O driver core
Message-ID: <20061216144813.GA29028@gallifrey>
References: <20061214010608.GA13229@kroah.com> <45811D0F.2070705@argo.co.il> <1166091570.27217.983.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1166091570.27217.983.camel@laptopd505.fenrus.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.32 (i686)
X-Uptime: 14:41:12 up 221 days,  3:53,  2 users,  load average: 0.26, 0.34, 0.30
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Arjan van de Ven (arjan@infradead.org) wrote:
> 
> > I understand one still has to write a kernel driver to shut up the irq.  
> > How about writing a small bytecode interpreter to make event than 
> > unnecessary?
> 
> if you do that why not do a real driver.

Because perhaps it is potentially very simple - i.e.
if most of these drivers turn out to be:

if (*loc1 & mask)
{
   *loc2=value;
   flag we have an interrupt
}

then all you actually need to do is provide a way to
specify loc1, mask, loc2 and value.  You could provide
a small handful of mechanisms to suit most simple pieces of hardware
and also provide a definition for the hardware designers to say
'if you make your interrupt registers like this then the software
is dead easy'.  A bytecode interpreter seems a little overkill
unless you think that two or three levels of that type of test/mask
could cope with 90%+ of the cases.
There are probably lots of people reinventing the wheel for simple IO 
boards and the hardware guys will be making it up each time as well.

Dave
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
