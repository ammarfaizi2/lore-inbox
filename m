Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129880AbQK0IGM>; Mon, 27 Nov 2000 03:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130010AbQK0IGC>; Mon, 27 Nov 2000 03:06:02 -0500
Received: from host156.207-175-42.redhat.com ([207.175.42.156]:47888 "EHLO
        devserv.devel.redhat.com") by vger.kernel.org with ESMTP
        id <S129880AbQK0IFr>; Mon, 27 Nov 2000 03:05:47 -0500
Date: Mon, 27 Nov 2000 02:35:37 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: initdata for modules?
Message-ID: <20001127023537.R1514@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <200011261530.HAA09799@baldur.yggdrasil.com> <1175.975279297@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1175.975279297@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Mon, Nov 27, 2000 at 09:54:57AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2000 at 09:54:57AM +1100, Keith Owens wrote:
> On Sun, 26 Nov 2000 07:30:44 -0800, 
> "Adam J. Richter" <adam@yggdrasil.com> wrote:
> >	In reading include/linux/init.h, I was surprised to discover
> >that __init{,data} expands to nothing when compiling a module.
> >I was wondering if anyone is contemplating adding support for
> >__init{,data} in module loading, to reduce the memory footprints
> >of modules after they have been loaded.
> 
> It has been discussed a few times but nothing was ever done about it.

Well, I've actually implemented it few years ago and even current modutils
you maintain support that already (see runsize member of struct module and
how is it assigned). __init stuff was not stored in a separate page and was
initially vmalloced together with the whole module, the only vm addition was
a shrink for a vmalloc area where it would free some pages from the end of
the area.
It lived in sparclinux-cvs for quite some time, but Linus have not accepted
it (I've posted several times).
I can dig the patch out of sparclinux CVS if anyone is interested.

	Jakub
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
