Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262355AbRGNQLz>; Sat, 14 Jul 2001 12:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262389AbRGNQLp>; Sat, 14 Jul 2001 12:11:45 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:45836 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262355AbRGNQL2>; Sat, 14 Jul 2001 12:11:28 -0400
Subject: Re: RFC: Remove swap file support
To: jlnance@intrex.net
Date: Sat, 14 Jul 2001 17:12:24 +0100 (BST)
Cc: ebiederm@xmission.com (Eric W. Biederman), linux-kernel@vger.kernel.org
In-Reply-To: <20010714104447.A1327@bessie.localdomain> from "jlnance@intrex.net" at Jul 14, 2001 10:44:47 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15LS1o-0001OU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The case of swap files with holes would be a nice thing to have.
> It would effectivly give us a way to say "use the extra space on this
> file system for swap" and at the same time the ability to set a limit
> on how much space could be taken up by swap.  For example you could
> create a totally sparse 1G file at bootup, and use it as a swap file.
> If the system needed swap it could grow the file, but you would know
> that it would never grow beyond 1G.

Growing a swap file gets complex and complex where complexity is bad and 
resources are constrained due to memory pressure. 

We do need to sort this out for 2.5, for one the way that swap is 'different'
to the rest of the backing store is ugly in itself and causes a lot of
duplication and overcomplex code.

Really there should be no pages going to some anonymous magic 'swap' object.
Instead each virtual memory area should be backed by a file system object,
including a 'swapfs' - which might be the existing style of swap, might be
something stacked onto an existing fs that allocates and manages free space
or might be completely bizarre (eg a high speed SAN network swap protocol)

