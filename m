Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312511AbSC0OJw>; Wed, 27 Mar 2002 09:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313016AbSC0OJm>; Wed, 27 Mar 2002 09:09:42 -0500
Received: from ns.suse.de ([213.95.15.193]:2834 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S312511AbSC0OJV>;
	Wed, 27 Mar 2002 09:09:21 -0500
To: Matthew Kirkwood <matthew@hairy.beasts.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Filesystem benchmarks: ext2 vs ext3 vs jfs vs minix
In-Reply-To: <Pine.LNX.4.33.0203271323330.24894-100000@sphinx.mythic-beasts.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 27 Mar 2002 15:09:19 +0100
Message-ID: <p73y9ge3xww.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Kirkwood <matthew@hairy.beasts.org> writes:

> 		PostgreSQL
> 	tuning?	single	ir	mx-ir	oltp	mixed-oltp
> 		(sec)	(tps)	(sec)	(tps)	(sec)
> ext2	dd	1304.72	66.64	214.25	188.50	230.55
> 	dn	1288.31	65.93	209.57	234.08	213.75
> 	bn	1283.50	77.90	1867.71	192.43	226.77
> 
> ext3	dd	1303.84	66.87	212.49	66.06	361.04
> 	dn	1288.03	64.62	209.27	111.41	278.54
> 	bn	1285.32	65.98	1996.41	90.05	307.79

This is ext3 with ordered data? 

> minix	dd	1305.26	67.38	207.74	193.90	228.81
> 	dn	1331.27	67.14	210.07	223.70	214.33
> 	bn	1299.24	89.58	1988.31	231.17	231.17

Wow minix is faster than ext2 @)  That certainly looks strange. 

Any chance to test XFS too?

> 3. The journalled filesystems do have measurable overhead
>    for this workload.

Normally (non data journaling, noatime) journaling fs shouldn't have any
overhead for database load, because database files should be preallocated
and the database should do direct IO in/out the preallocated buffers
with the FS never doing any metadata writes, except for occassional inode
updates for mtime depending on what sync mode that DB uses (hmm, I guess a 
nomtime or verylazymtime or alwaysasyncmtime mount option could be helpful 
for that) 
 
That's the theory, but doesn't seem to be the case in your test. I guess
your test is not very realistic then. 

> 2. What does jfs do in the way of data journalling?  Is it
>    "ordered" or "writeback", in ext3-speak?  (I assume
>    fully journalled data would give much worse performance.)

Kind of ordered I believe.

-Andi
