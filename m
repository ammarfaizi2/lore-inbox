Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbUEaXYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbUEaXYw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 19:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264609AbUEaXYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 19:24:52 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:46770 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261159AbUEaXYu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 19:24:50 -0400
From: tabris <tabris@tabris.net>
To: Shobhit Mathur <shobhitmmathur@yahoo.com>
Subject: Re: [LKML]kmalloc -contiguous locations ?
Date: Mon, 31 May 2004 19:24:00 -0400
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org
References: <20040531094939.74138.qmail@web51007.mail.yahoo.com>
In-Reply-To: <20040531094939.74138.qmail@web51007.mail.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200405311924.06505.tabris@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 31 May 2004 5:49 am, Shobhit Mathur wrote:
> Hello,
>
> I would like to know whether kmalloc() guarantees
> virtually contiguous memory locations ?
> Is there a limit on the amount of contiguous memory
> that can be returned by kmalloc() ?
	First, kmalloc returns physically contiguous memory.
	second, the limit (on x86) is 128kb (32 pages), allocatable in powers of two 
pages. (1,2,4,8,16,32. often called 0-order thru 5-order allocations)

	vmalloc returns virtual contiguous allocations, with no guarantee on physical 
contiguity. The problem with vmalloc, iirc, is that there's a [total] limit 
of 128MB for vmallocs.

	Also remember that all kernel memory allocated with vmalloc() or kmalloc() is 
non-swappable.

	I don't know how this changes under any other architecture, such as x86-64 or 
PPC32/64.
>
> - Thank you
>
> - Shobhit Mathur

- --
tabris
- -
	A master was explaining the nature of Tao to one of his novices.
"The Tao is embodied in all software -- regardless of how insignificant,"
said the master.
	"Is Tao in a hand-held calculator?" asked the novice.
	"It is," came the reply.
	"Is the Tao in a video game?" continued the novice.
	"It is even in a video game," said the master.
	"And is the Tao in the DOS for a personal computer?"
	The master coughed and shifted his position slightly.  "The lesson
is over for today," he said.
		-- Geoffrey James, "The Tao of Programming"
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAu76V1U5ZaPMbKQcRAh8MAJ4nXgcFr/AENZql4BDFIRL+HGGJzACeNqej
TPVXSEF6E0ud+MfA8g5tQqE=
=sgpU
-----END PGP SIGNATURE-----
