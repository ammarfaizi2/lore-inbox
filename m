Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130231AbQLFNuL>; Wed, 6 Dec 2000 08:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130673AbQLFNuB>; Wed, 6 Dec 2000 08:50:01 -0500
Received: from cs85214.pp.htv.fi ([212.90.85.214]:55291 "EHLO
	chip.nutshakers.dhs.org") by vger.kernel.org with ESMTP
	id <S130231AbQLFNtr>; Wed, 6 Dec 2000 08:49:47 -0500
Date: Wed, 6 Dec 2000 15:18:46 +0200 (EET)
From: Panu Matilainen <pmatilai@pp.htv.fi>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <aviro@redhat.com>, Andrew Morton <andrewm@uow.edu.au>,
        "Stephen C. Tweedie" <sct@redhat.com>, Alan Cox <alan@redhat.com>,
        Christoph Rohland <cr@sap.com>, Rik van Riel <riel@conectiva.com.br>,
        MOLNAR Ingo <mingo@chiara.elte.hu>, <urban@svenskatest.se>
Subject: Re: test12-pre5
In-Reply-To: <Pine.LNX.4.10.10012041906510.2047-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0012061518050.26107-100000@chip.nutshakers.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2000, Linus Torvalds wrote:

>
> Ok, this contains one of the fixes for the dirty inode buffer list (the
> other fix is pending, simply because I still want to understand why it
> would be needed at all). Al?
>
> Also, it has the final installment of the PageDirty handling, and now
> officially direct IO can work by just marking the physical page dirty and
> be done with it. NFS along with all filesystems have been converted, the
> one hold-out still being smbfs.
>
> Who works on smbfs these days? I see two ways of fixing smbfs now that
> "writepage()" only gets an anonymous page and no "struct file" information
> any more (this also fixes the double page unlock that Andrew saw).

Urban Widmark is the smbfs maintainer nowadays. BTW Urban thanks again for
the NetApp-fix, it has saved my behind quite a few times by now :)

        - Panu -


>
>  - disable shared mmap over smbfs (very easily done by just setting
>    writepage to NULL)
>
>  - fetch the dentry that writepage needs by just looking at the
>    inode->i_dentry list and/or just make the smbfs page cache host be the
>    dentry instead of the inode like other filesystems. The first approach
>    assumes that all paths are equal for writeout, the second one assumes
>    that there are no hard linking going on in smbfs.
>
> Somebody more knowledgeable than I will have to make the decision
> (otherwise I'll just end up disabling shared mmap - I doubt anybody really
> uses it anyway, but it would be more polite to just support it).
>
> NOTE! There's another change to "writepage()" semantics than just dropping
> the "struct file": the new writepage() is supposed to mirror the logic of
> readpage(), and unlock the page when it is done with it. This allows the
> VM system more visibility into what IO is pending (which the VM doesn't
> take advantage of yet, but now it can _truly_ use the same logic for both
> swapout and for dirty file writeback).
>
> The other change is that I forward-ported the ymfpci driver from 2.2.18,
> as it works better than the ALSA one on my now-to-be-main-laptop ;)
>
> [ Alan - I ahve your patches in my incoming queue still, I wanted to get
>   an interim version out to check with Al on the block list and the VM
>   stuff with Rik and people. ]
>
> 		Linus
>
> ----
>  - pre5:
>     - Jaroslav Kysela: ymfpci driver
>     - me: get rid of bogus MS_INVALIDATE semantics
>     - me: final part of the PageDirty() saga
>     - Rusty Russell: 4-way SMP iptables fix
>     - Al Viro: oops - bad ext2 inode dirty block bug
>
>  - pre4:
>     - Andries Brouwer: final isofs pieces.
>     - Kai Germaschewski: ISDN
>     - play CD audio correctly, don't stop after 12 minutes.
>     - Anton Altaparmakov: disable NTFS mmap for now, as it doesn't work.
>     - Stephen Tweedie: fix inode dirty block handling
>     - Bill Hartner: reschedule_idle - prefer right cpu
>     - Johannes Erdfelt: USB updates
>     - Alan Cox: synchronize
>     - Richard Henderson: alpha updates and optimizations
>     - Geert Uytterhoeven: fbdev could be fooled into crashing fix
>     - Trond Myklebust: NFS filehandles in inode rather than dentry
>
>  - pre3:
>     - me: more PageDirty / swapcache handling
>     - Neil Brown: raid and md init fixes
>     - David Brownell: pci hotplug sanitization.
>     - Kanoj Sarcar: mips64 update
>     - Kai Germaschewski: ISDN sync
>     - Andreas Bombe: ieee1394 cleanups and fixes
>     - Johannes Erdfelt: USB update
>     - David Miller: Sparc and net update
>     - Trond Myklebust: RPC layer SMP fixes
>     - Thomas Sailer: mixed sound driver fixes
>     - Tigran Aivazian: use atomic_dec_and_lock() for free_uid()
>
>  - pre2:
>     - Peter Anvin: more P4 configuration parsing
>     - Stephen Tweedie: O_SYNC patches. Make O_SYNC/fsync/fdatasync
>       do the right thing.
>     - Keith Owens: make mdule loading use the right struct module size
>     - Boszormenyi Zoltan: get MTRR's right for the >32-bit case
>     - Alan Cox: various random documentation etc
>     - Dario Ballabio: EATA and u14-34f update
>     - Ivan Kokshaysky: unbreak alpha ruffian
>     - Richard Henderson: PCI bridge initialization on alpha
>     - Zach Brown: correct locking in Maestro driver
>     - Geert Uytterhoeven: more m68k updates
>     - Andrey Savochkin: eepro100 update
>     - Dag Brattli: irda update
>     - Johannes Erdfelt: USB update
>
>  - pre1: (for ISDN synchronization _ONLY_! Not complete!)
>     - Byron Stanoszek: correct decimal precision for CPU MHz in
>       /proc/cpuinfo
>     - Ollie Lho: SiS pirq routing.
>     - Andries Brouwer: isofs cleanups
>     - Matt Kraai: /proc read() on directories should return EISDIR, not EINVAL
>     - me: be stricter about what we accept as a PCI bridge setup.
>     - me: always set PCI interrupts to be level-triggered when we enable them.
>     - me: updated PageDirty and swap cache handling
>     - Peter Anvin: update A20 code to work without keyboard controller
>     - Kai Germaschewski: ISDN updates
>     - Russell King: ARM updates
>     - Geert Uytterhoeven: m68k updates
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
