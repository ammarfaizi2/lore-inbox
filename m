Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbTEENLU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 09:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262179AbTEENLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 09:11:20 -0400
Received: from elin.scali.no ([62.70.89.10]:34181 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id S262177AbTEENLR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 09:11:17 -0400
Subject: Re: The disappearing sys_call_table export.
From: Terje Eggestad <terje.eggestad@scali.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       D.A.Fedorov@inp.nsk.su
In-Reply-To: <1052133402.29361.2.camel@dhcp22.swansea.linux.org.uk>
References: <1052122784.2821.4.camel@pc-16.office.scali.no>
	 <20030505092324.A13336@infradead.org>
	 <1052127216.2821.51.camel@pc-16.office.scali.no>
	 <1052133402.29361.2.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain
Organization: Scali AS
Message-Id: <1052141018.2821.163.camel@pc-16.office.scali.no>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 05 May 2003 15:23:39 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-05 at 13:16, Alan Cox wrote:
> On Llu, 2003-05-05 at 10:33, Terje Eggestad wrote:
> > 1. performance is everything. 
> 
> Then you can live with building custom patched kernels
> 

If there was numerous issues, sure. But every time we get to the point
where it seem that that is necessary we find a workaround. 
Right now, this is the ONLY issue we got.. 
  

> > 2. We're making a MPI library, and as such we don't have any control
> > with the application. 
> 
> LD_PRELOAD
> 

IN general LD_PRELOAD is fun for testing and academic programs, but not
for production code. 

In specific you run into a problem with how fortran 90 compilers do
dynamical arrays. It's very compiler dependent.  

> > 3c. It's therefore necessary for HW to access user pages.
> 
> Like TV cards do. That isnt hard
>  

nobody said it is. 

> > 4. In order to to 3, the user pages must be pinned down. 
> > 5. the way MPI is written, it's not using a special malloc() to allocate
> > the send receive buffers. It can't since it would break language binding
> > to fortran. Thus ANY writeable user page may be used.
> 
> Well not all the pages are guaranteed DMAable, so I guess you already
> lost.
>  

Nope. The drivers test to see if the page is DMAable, and do a copy if
necessary. Most of the high performance interconnects NIC's do 64 bit
PCI.  

> > 10. kernel patches are impractical, I must be able to do this with std
> > stock, redhat, AND suse kernels.   
> 
> So you want every vendor to screw up their kernels and the base kernel
> for an obscure (but fun) corner case. Thats not a rational choice is it.
> You want "performance is everything" you pay the price, don't make
> everyone suffer.

No! I don't disagree with removing the export of the syscall_table!

I just want the "proper mechanism" indicated by Arjan in the changelog.
Pls read this thread. There are legitimate uses to having syscall
hooks/notifications, either you think mine is or not.    

-- 
_________________________________________________________________________

Terje Eggestad                  mailto:terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
N-0619 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

