Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265841AbRFYTnh>; Mon, 25 Jun 2001 15:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265815AbRFYTn1>; Mon, 25 Jun 2001 15:43:27 -0400
Received: from energy.pdb.sbs.de ([192.109.2.19]:22799 "EHLO energy.pdb.sbs.de")
	by vger.kernel.org with ESMTP id <S265837AbRFYTnX>;
	Mon, 25 Jun 2001 15:43:23 -0400
Date: Mon, 25 Jun 2001 21:46:27 +0200 (CEST)
From: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
cc: <Paul.Russell@rustcorp.com.au>
Subject: proc_file_read() question
Message-ID: <Pine.LNX.4.30.0106252141181.13052-100000@biker.pdb.fsc.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

the "hack" below in proc_file_read() fs/proc/generic.c (2.4.5)
irritates me:

If I do use "start" for a pointer into a memory area
allocated in read_proc, will it be always guaranteed
that (start > page)?

If no, this will IMO lead to spuriously wrong output.
If yes, I'd like to understand why.

Regards & thanks,
Martin

		/* This is a hack to allow mangling of file pos independent
 		 * of actual bytes read.  Simply place the data at page,
 		 * return the bytes, and set `start' to the desired offset
 		 * as an unsigned int. - Paul.Russell@rustcorp.com.au
		 */
 		n -= copy_to_user(buf, start < page ? page : start, n);
		if (n == 0) {
			if (retval == 0)
				retval = -EFAULT;
			break;
		}

		*ppos += start < page ? (long)start : n; /* Move down the file */

-- 
Martin Wilck     <Martin.Wilck@fujitsu-siemens.com>
FSC EP PS DS1, Paderborn      Tel. +49 5251 8 15113



