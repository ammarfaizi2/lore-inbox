Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312169AbSDCQW3>; Wed, 3 Apr 2002 11:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312178AbSDCQWJ>; Wed, 3 Apr 2002 11:22:09 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:17672 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S312162AbSDCQWD>; Wed, 3 Apr 2002 11:22:03 -0500
Date: Wed, 3 Apr 2002 18:21:18 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@redhat.com>,
        Stelian Pop <stelian.pop@fr.alcove.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
Message-ID: <20020403182118.A10959@dualathlon.random>
In-Reply-To: <20020220131310.GE8539@come.alcove-fr> <Pine.LNX.4.21.0202201539410.1232-100000@localhost.localdomain> <20020220110127.A13240@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2002 at 11:01:27AM -0500, Arjan van de Ven wrote:
> Now if it should be EXPORT_SYMBOL or EXPORT_SYMBOL_GPL() I leave to Ingo

It has to be EXPORT_SYMBOL. Requiring non GPL drivers to walk pagetables
by hand is pointless. we should definitely recommend those driver
authors to use vmalloc_to_page, in particular if the drivers are not
GPL.

To see it in another way If we make vmalloc_to_page linkable only by GPL
drivers, then we should do the same with all the other functionalities
too starting from map_user_kiobuf etc...

Infact I'm not really sure the _GPL tag makes sense in the first place.
If an interface shouldn't be used by a binary only module, why should it
be used by a GPL module? It doesn't make any sense to me, of course
I'm looking at it from a technical prospective. If your grand plan is to
forbid a non GPL module to call vmalloc/kmalloc/alloc_pages, then the
non GPL module developer will be in great pain I see, but that still
doesn't make any sense to me because the rule is that binary only
modules are legal. Not that I will ever use binary only modules myself,
not that I will ever do anything to help binary only modules, but I
don't either do anything to explicitly hurt them, I just ignore them.

--- 2.4.19pre5aa1/kernel/ksyms.c.~1~	Sun Mar 31 03:37:18 2002
+++ 2.4.19pre5aa1/kernel/ksyms.c	Wed Apr  3 17:53:29 2002
@@ -114,7 +114,7 @@
 EXPORT_SYMBOL(kfree);
 EXPORT_SYMBOL(vfree);
 EXPORT_SYMBOL(__vmalloc);
-EXPORT_SYMBOL_GPL(vmalloc_to_page);
+EXPORT_SYMBOL(vmalloc_to_page);
 #ifndef CONFIG_DISCONTIGMEM
 EXPORT_SYMBOL(contig_page_data);
 EXPORT_SYMBOL(mem_map);
Andrea
