Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293058AbSCEMmc>; Tue, 5 Mar 2002 07:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293061AbSCEMmX>; Tue, 5 Mar 2002 07:42:23 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:51205 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S293058AbSCEMmN>; Tue, 5 Mar 2002 07:42:13 -0500
Date: Tue, 5 Mar 2002 09:41:56 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: arjan@fenrus.demon.nl
Cc: Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19pre1aa1
In-Reply-To: <200203050835.g258ZpW25134@fenrus.demon.nl>
Message-ID: <Pine.LNX.4.44L.0203050934340.1413-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Mar 2002 arjan@fenrus.demon.nl wrote:
> In article <20020305005215.U20606@dualathlon.random> you wrote:
>
> > I don't see how per-zone lru lists are related to the kswapd deadlock.
> > as soon as the ZONE_DMA will be filled with filedescriptors or with
> > pagetables (or whatever non pageable/shrinkable kernel datastructure you
> > prefer) kswapd will go mad without classzone, period.
>
> So does it with class zone on a scsi system....

Furthermore, there is another problem which is present in
both 2.4 vanilla, -aa and -rmap.

Suppose that (1) we are low on memory in ZONE_NORMAL and
(2) we have enough free memory in ZONE_HIGHMEM and (3) the
memory in ZONE_NORMAL is for a large part taken by buffer
heads belonging to pages in ZONE_HIGHMEM.

In that case, none of the VMs will bother freeing the buffer
heads associated with the highmem pages and kswapd will have
to work hard trying to free something else in ZONE_NORMAL.

Now before you say this is a strange theoretical situation,
I've seen it here when using highmem emulation. Low memory
was limited to 30 MB (16 MB ZONE_DMA, 14 MB ZONE_NORMAL)
and the rest of the machine was HIGHMEM.  Buffer heads were
taking up 8 MB of low memory, dcache and inode cache were a
good second with 2 MB and 5 MB respectively.


How to efficiently fix this case ?   I wouldn't know right now...
However, I guess we might want to come up with a fix because it's
a quite embarassing scenario ;)

regards,

Rik
-- 
Will hack the VM for food.

http://www.surriel.com/		http://distro.conectiva.com/

