Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbVBZXxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVBZXxz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 18:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVBZXxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 18:53:55 -0500
Received: from hera.cwi.nl ([192.16.191.8]:2266 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261300AbVBZXxx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 18:53:53 -0500
Date: Sun, 27 Feb 2005 00:53:44 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] partitions/msdos.c
Message-ID: <20050226235344.GB14236@apps.cwi.nl>
References: <20050226213459.GA21137@apps.cwi.nl> <16928.62091.346922.744462@hertz.ikp.physik.tu-darmstadt.de> <Pine.LNX.4.58.0502261424430.25732@ppc970.osdl.org> <Pine.LNX.4.58.0502261433431.25732@ppc970.osdl.org> <16929.1350.119511.746325@hertz.ikp.physik.tu-darmstadt.de> <Pine.LNX.4.58.0502261543190.25732@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0502261543190.25732@ppc970.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2005 at 03:46:03PM -0800, Linus Torvalds wrote:

> We should probably do the same for the 
> extended partition case, just to be consistent.

True.

diff -uprN -X /linux/dontdiff a/fs/partitions/msdos.c b/fs/partitions/msdos.c
--- a/fs/partitions/msdos.c	2004-12-29 03:39:55.000000000 +0100
+++ b/fs/partitions/msdos.c	2005-02-27 01:10:06.000000000 +0100
@@ -114,6 +114,9 @@ parse_extended(struct parsed_partitions 
 		 */
 		for (i=0; i<4; i++, p++) {
 			u32 offs, size, next;
+
+			if (SYS_IND(p) == 0)
+				continue;
 			if (!NR_SECTS(p) || is_extended_partition(p))
 				continue;
 
@@ -430,6 +433,8 @@ int msdos_partition(struct parsed_partit
 	for (slot = 1 ; slot <= 4 ; slot++, p++) {
 		u32 start = START_SECT(p)*sector_size;
 		u32 size = NR_SECTS(p)*sector_size;
+		if (SYS_IND(p) == 0)
+			continue;
 		if (!size)
 			continue;
 		if (is_extended_partition(p)) {
