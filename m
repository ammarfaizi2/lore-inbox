Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757674AbWK1MJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757674AbWK1MJU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 07:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757795AbWK1MJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 07:09:20 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:20876 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S1757659AbWK1MJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 07:09:19 -0500
Date: Tue, 28 Nov 2006 13:09:16 +0100
To: Tejun Heo <htejun@gmail.com>
Cc: avl@logic.at, Alan <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Allow turning off hpa-checking.
Message-ID: <20061128120916.GG2352@gamma.logic.tuwien.ac.at>
Reply-To: avl@logic.at
References: <20061127130953.GA2352@gamma.logic.tuwien.ac.at> <20061127133044.28b8b4ed@localhost.localdomain> <20061127160144.GB2352@gamma.logic.tuwien.ac.at> <20061127163328.3f1c12eb@localhost.localdomain> <20061127175647.GD2352@gamma.logic.tuwien.ac.at> <20061127181033.58e72d9a@localhost.localdomain> <20061127182943.GE2352@gamma.logic.tuwien.ac.at> <20061127195940.1b90a897@localhost.localdomain> <20061128092930.GF2352@gamma.logic.tuwien.ac.at> <456C056D.2070008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <456C056D.2070008@gmail.com>
User-Agent: Mutt/1.3.28i
From: Andreas Leitgeb <avl@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems I was too eagerly deleting context from my mails.
This made people misunderstand my questions or answer
details that have been clarified in previous mails already.

I did learn quite a lot already about harddisks during this thread.
"Thank you" to Alan.  In particular, about the quantities involved:

                         1                      2
+---------------------------------------------+---+
                                   ^-3
There is
   1) the "native" size of the disk: strictly constant
   2) the spare sectors for remapping bad ones. (not included in 1)
   3) An arbitrary quantity, being what the drive advertises as size.

Bios thinks 3) is the disks total size. So does Linux before the
hpa-check.  During that "hpa-check", Linux queries the quantity "1)",
which is indeed the disks (constant) size. 

There seem to be many (in some way conflicting) uses for "3)":
  - fool the BIOS: because bioses might get upset for too large disks.
  - fool some old OS: because the OS might get upset ---"---
  - reserve some sectors for some non-volatile data hidden to 
      certain systems e.g. for "nanny the user"-purposes.

This thread is (for one part) about another appearant use of "3)",
namely by the drive to tell that "2)" is exhausted, and less than
"1)" sectors are left usable.  So quantity "3)" is set to the number
of actually physically remaining sectors.

This theory is backed by my observation of a nearly-broken disk,
that the quantity "3)" gradually goes down one step after some time.
The first such step was, when I noticed the problem about half a
year ago, and just recently it stepped down by another one.

Linux queries the real size "1)", gets read errors on the last two
sectors and consequencially turns off dma making the machine awfully
slow.  But this is not a kernel's problem, because really the disk
should be replaced (it doesn't contain precious data, so I keep
watching its degrade, till it no longer does anything).

The point I'm really trying to make is, that there should be a
boot option, to disable the query for "1)".  This *must* be a
boot option, because the querying that I want to be able to
prevent happens at boot time.
My broken drive surely doesn't justify the option (or even this
thread), but the third one of the "uses for 3)" mentioned above
does. Once the native size is read, I no longer know how many
sectors were previously "hidden away" by HPA, except by checking
the kernel-log.

While Alan has already said, why he thought that this was the
wrong approach, the reasoning was based on a misunderstanding
of my question, which I here tried to clear up.

