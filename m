Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270726AbRHPDww>; Wed, 15 Aug 2001 23:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270727AbRHPDwn>; Wed, 15 Aug 2001 23:52:43 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:41992 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S270726AbRHPDwe>;
	Wed, 15 Aug 2001 23:52:34 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200108160352.f7G3qbw236026@saturn.cs.uml.edu>
Subject: Re: daddr_t is inconsistent and barely used
To: hch@ns.caldera.de (Christoph Hellwig)
Date: Wed, 15 Aug 2001 23:52:37 -0400 (EDT)
Cc: kaos@ocs.com.au (Keith Owens), linux-kernel@vger.kernel.org
In-Reply-To: <20010816052119.A28800@caldera.de> from "Christoph Hellwig" at Aug 16, 2001 05:21:19 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:
>>> In article <9980.997929632@kao2.melbourne.sgi.com> you wrote:

>>>> The use of daddr_t in freevxfs may give different in core
>>>> and disk layouts on different machines.  Is that intended?.
...
> vx_daddr_t is for disk structures, daddr_t for core.

This is asking for trouble. The disk structures aren't about
to change. See include/linux/ext2_fs.h for a safe way to do
the on-disk structure. For the in-core stuff, "unsigned long"
is a perfectly fine data type -- and yes I know it gets wider
with a 64-bit system.

To save you the trouble of looking up my example:

/*
 * Structure of a blocks group descriptor
 */
struct ext2_group_desc
{
        __u32   bg_block_bitmap;                /* Blocks bitmap block */
        __u32   bg_inode_bitmap;                /* Inodes bitmap block */
        __u32   bg_inode_table;         /* Inodes table block */
        __u16   bg_free_blocks_count;   /* Free blocks count */
        __u16   bg_free_inodes_count;   /* Free inodes count */
        __u16   bg_used_dirs_count;     /* Directories count */
        __u16   bg_pad;
        __u32   bg_reserved[3];
};

Don't forget to add explicit padding as needed to give natural alignment.

