Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318859AbSHNPbE>; Wed, 14 Aug 2002 11:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318900AbSHNPbE>; Wed, 14 Aug 2002 11:31:04 -0400
Received: from zeke.inet.com ([199.171.211.198]:32641 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id <S318859AbSHNPbE>;
	Wed, 14 Aug 2002 11:31:04 -0400
Message-ID: <3D5A7896.7020407@inet.com>
Date: Wed, 14 Aug 2002 10:34:46 -0500
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: of dentries and inodes
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

Ok, I'm puzzled... I have not yet found an answer from groups.google or 
my oreilly tomes. :/

(I'm looking at a 2.2 kernel, but I doubt this has changed.) In ext2, as 
well as many other fs's, there appears a line much like this in their 
'struct file_system_type.read_super()' function:

sb->s_root = d_alloc_root(iget(sb, EXT2_ROOT_INO), NULL);

Now, I was under the impression that for each iget(), you need to have 
an iput() when you're done with the inode... which in this case would 
mean an iput() in 'struct super_operations.put_super()'... but I don't 
see one there.

So I would expect the root inode might hang around in the filesystem 
cache(s) after a umount.  But I would expect that to cause filesystem 
corruption on a regular basis.  ('mount, umount, mkfs' for example, 
would yield an inconsistancy between disk and filesystem cache.)

I'm missing something, or misunderstand something, or both... can anyone 
point me in the right direction?

TIA,

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

