Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbQLOHiw>; Fri, 15 Dec 2000 02:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130026AbQLOHim>; Fri, 15 Dec 2000 02:38:42 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:60174 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S129267AbQLOHi3>;
	Fri, 15 Dec 2000 02:38:29 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200012150708.eBF782q290873@saturn.cs.uml.edu>
Subject: Re: PATCH: fix FAT32 filesystems on 64-bit platforms
To: notting@redhat.com (Bill Nottingham)
Date: Fri, 15 Dec 2000 02:08:02 -0500 (EST)
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        chaffee@cs.berkeley.edu
In-Reply-To: <20001214190930.C12088@nostromo.devel.redhat.com> from "Bill Nottingham" at Dec 14, 2000 07:09:30 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This fixes FAT32 on 64-bit platforms (notably, IA-64 and Alpha);
> without this you can't mount any FAT32 filesystems. A similar patch
> is already in 2.2.18.
...
> -		next = CF_LE_L(((unsigned long *) bh->b_data)[(first &
> +		next = CF_LE_L(((__u32 *) bh->b_data)[(first &
...
> -		next = CF_LE_W(((unsigned short *) bh->b_data)[(first &
> +		next = CF_LE_W(((__u16 *) bh->b_data)[(first &


These macros really ought to be replaced with the standard
le32_to_cpu() and le16_to_cpu() ones.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
