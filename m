Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293276AbSDEAtF>; Thu, 4 Apr 2002 19:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310190AbSDEAs4>; Thu, 4 Apr 2002 19:48:56 -0500
Received: from elin.scali.no ([62.70.89.10]:40206 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S293276AbSDEAsg>;
	Thu, 4 Apr 2002 19:48:36 -0500
Date: Fri, 5 Apr 2002 02:47:58 +0200 (CEST)
From: Steffen Persvold <sp@scali.com>
To: Arjan van de Ven <arjanv@redhat.com>
cc: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>,
        Ingo Molnar <mingo@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Keith Owens <kaos@ocs.com.au>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrea Arcangeli <andrea@suse.de>, Hugh Dickins <hugh@veritas.com>,
        Stelian Pop <stelian.pop@fr.alcove.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Linux kernel and binary drivers (was: [PATCH 2.5.5] do export
 vmalloc_to_page to modules...)
In-Reply-To: <20020404125954.C27384@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.30.0204050225150.7535-100000@elin.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Apr 2002, Arjan van de Ven wrote:

>
> On Thu, Apr 04, 2002 at 04:35:33PM +0100, Tigran Aivazian wrote:
> > disappeared). Then, to make your thoughts consistent you would need to
> > disable the exported interfaces required for development of a journalling
>
> You assume EXPORT_SYMBOL is an exported, stable interface
> that constitutes a GPL barrier. I disagree with
> that and I think quite a few others do too.
>
> That seems to be the core issue here...

Ok since the issue has been brought up by this thread I felt it was about
time I got this right (beeing a writer of binary "partly" drivers).

The way we have solved it is to divide our drivers into two parts : one
core system and one kernel abstraction layer, which between them has a
defined ABI. The core system (which contains the "intelligent" parts) is
licensed under our own license and therefore only shipped as a
pre-compiled object file (or a collection of several) while the kernel
abstraction layer (which uses the Linux kernel header files and their
"API") is licensed under LGPL and shipped as source which can be compiled
agains any kernel tree. In the end all is linked together as one module
in order to make it load into the kernel.

There are also other reasons why we've made this split and that is to
maintain the same source for several OS'es without too much hassle. If a
new OS comes along, only a new kernel abstraction layer is needed, and
only minor changes are needed for the core system.

Do you think this is a clean way of doing things having the previous
discussions in mind ?

Regards,
 --
  Steffen Persvold   | Scalable Linux Systems |   Try out the world's best
 mailto:sp@scali.com |  http://www.scali.com  | performing MPI implementation:
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.13.8 -
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >320MBytes/s and <4uS latency

