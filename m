Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbQLFW4C>; Wed, 6 Dec 2000 17:56:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129765AbQLFWzm>; Wed, 6 Dec 2000 17:55:42 -0500
Received: from dryline-fw.wireless-sys.com ([216.126.67.45]:32636 "EHLO
	dryline-fw.wireless-sys.com") by vger.kernel.org with ESMTP
	id <S129406AbQLFWzj>; Wed, 6 Dec 2000 17:55:39 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14894.48314.363938.770481@somanetworks.com>
Date: Wed, 6 Dec 2000 17:24:58 -0500 (EST)
From: "Georg Nikodym" <georgn@somanetworks.com>
To: linux-kernel@vger.kernel.org
CC: georgn@somanetworks.com, greg@wind.enjellic.com, sct@dcs.ed.ac.uk
Subject: linux-2.4.0-test11 and sysklogd-1.3-31
X-Mailer: VM 6.75 under 21.2  (beta37) "Pan" XEmacs Lucid
Reply-To: georgn@somanetworks.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


sysklogd 1.3-31 no longer compiles using the latest headers in test11.

Strictly speaking this isn't a kernel bug...

sysklogd's ksym_mod.c includes <linux/module.h>

In test11, <linux/module.h> added struct inter_module_entry.  Its
first member is "struct list_head list;".  This necessitates the
inclusion of <linux/list.h>.

The trouble is that <linux/list.h> is almost completely protected by
#ifdef __KERNEL__.

sysklogd, obviously, doesn't compile with __KERNEL__ so the struct
inter_module_entry declaration is impossible and the compilation
fails.

It's not clear to me who's code needs changing so I'm sending both to
linux-kernel and to some of the people that have the misfortune of
being listed on the sysklogd man page.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
