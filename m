Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132358AbRBRBL2>; Sat, 17 Feb 2001 20:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132399AbRBRBLJ>; Sat, 17 Feb 2001 20:11:09 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:38922 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S132358AbRBRBLB>;
	Sat, 17 Feb 2001 20:11:01 -0500
Date: Sun, 18 Feb 2001 02:10:50 +0100
From: Frank de Lange <frank@unternet.org>
To: linux-kernel@vger.kernel.org
Cc: reiser@namesys.com, mason@suse.com
Subject: Re: reiserfs on 2.4.1,2.4.2-pre (with null bytes patch) breaks mozilla compile
Message-ID: <20010218021050.A13823@unternet.org>
In-Reply-To: <20010218015715.A13043@unternet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010218015715.A13043@unternet.org>; from frank@unternet.org on Sun, Feb 18, 2001 at 01:57:15AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  At least the patch didn't make it worse. Would anyone care to comment on
>  how the elf-dynstr-gc option changes the file access patterns for the
>  compile?

It does not change the file access patterns, it adds an extra step. A separate
binary (dist/bin/elf-dynstr-gc, a convoluted version of strip) is run over the
final (linked) library/executable to remove some symbol info. The elf-dynstr-gc
program is compiled as part of the mozilla build. There's nothing wrong with
elf-dynstr-gc on the reiserfs filesystem, it is identical to the one on the
ext2 partition. Running the 'reiserfs' version on the ext2 tree works as it
should, running the ext2 version on the reiserfs tree crashes (seems the
program is not very robust, as it does not detect garbled input files). As
said, running objdump on the corrupted (reiserfs compiled) library also
produces errors.

Cheers//Frank

-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \    frank@unternet.org    /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]
