Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277134AbRJDGZE>; Thu, 4 Oct 2001 02:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277135AbRJDGYy>; Thu, 4 Oct 2001 02:24:54 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:15408 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S277134AbRJDGYn>; Thu, 4 Oct 2001 02:24:43 -0400
To: Alexander Viro <viro@math.psu.edu>
Cc: landley@trommello.org, drepper@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Security question: "Text file busy" overwriting executables but not shared libraries?
In-Reply-To: <Pine.GSO.4.21.0110040004430.26177-100000@weyl.math.psu.edu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 Oct 2001 00:15:01 -0600
In-Reply-To: <Pine.GSO.4.21.0110040004430.26177-100000@weyl.math.psu.edu>
Message-ID: <m14rpg0w4a.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro <viro@math.psu.edu> writes:

> On 3 Oct 2001, Eric W. Biederman quoted:
> 
> > > >/* The right way to map in the shared library files is MAP_COPY, which
> > > >   makes a virtual copy of the data at the time of the mmap call; this
> > > >   guarantees the mapped pages will be consistent even if the file is
> > > > overwritten.  Some losing VM systems like Linux's lack MAP_COPY.  All we
> 
> > > >   get is MAP_PRIVATE, which copies each page when it is modified; this
> > > >   means if the file is overwritten, we may at some point get some pages
> > > > from the new version after starting with pages from the old version.  */
> 
> 
> IMO it needs a slight correction.
> 
> + /* Unfortunately, that is not an option, since losing bloatware like GNU's
> +    relies heavily on equally bloated shared libraries and use of MAP_COPY
> +    would eat memory with no mercy.  OTOH, implementing it might be a good
> + idea, since results would force people to switch to something less obese */

Hmm. Perhaps. But if we went there we would need to add something like.

/* But finding a less obese platform to run these less obese libraries is a
   challenge.  Unix clones like UZI have been shown to run a complete system
   including user space binaries in just 64KB of RAM, on systems
   originally designed to run CPM.  But today you can't find a general
   purpose kernel whose binary much less it footprint fits in 256KB.
   It seems bloatware is everywhere.
 */

I have days when I'm frustrated by the size of both glibc and the
linux kernel.  stripped both the linux kernel and glibc are comparable
in size.  Though I think the 400KB of compressed glibc-2.1.2 is
actually smaller than the kernel for the most part.  I have to strip
off practically everthing to get a useable bzImage under 400KB.

So any good ideas on how to get the size of linux down?

Eric
