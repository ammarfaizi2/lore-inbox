Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132831AbRDXGvf>; Tue, 24 Apr 2001 02:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132834AbRDXGvZ>; Tue, 24 Apr 2001 02:51:25 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:59878 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S132831AbRDXGvR>; Tue, 24 Apr 2001 02:51:17 -0400
From: Christoph Rohland <cr@sap.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        "David L. Parsley" <parsley@linuxjedi.org>,
        linux-kernel@vger.kernel.org
Subject: Re: hundreds of mount --bind mountpoints?
In-Reply-To: <Pine.GSO.4.21.0104231133120.3617-100000@weyl.math.psu.edu>
Organisation: SAP LinuxLab
In-Reply-To: <Pine.GSO.4.21.0104231133120.3617-100000@weyl.math.psu.edu>
Message-ID: <m33dazqr86.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 24 Apr 2001 08:33:12 +0200
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

On Mon, 23 Apr 2001, Alexander Viro wrote:
>> I like it. ext2fs does the same, so there should be no VFS
>> hassles involved. Al?
> 
> We should get ext2 and friends to move the sucker _out_ of struct
> inode.  As it is, sizeof(struct inode) is way too large. This is 2.5
> stuff, but it really has to be done. More filesystems adding stuff
> into the union is a Bad Thing(tm). If you want to allocates space -
> allocate if yourself; ->clear_inode() is the right place for freeing
> it.

Yes, I agree that the union is way too large and I did not plan to
extend it but simply use the size it has.

if (strlen(path) < sizeof(inode->u))
        inline the symlink;
else
        put it into the page cache;

So if somebody really cleans up the private inode structures it will
not trigger that often any more and we perhaps have to rethink the
idea.

But also if we use struct shmem_inode_info which is 92 bytes right now
we would inline all symlinks on my machine.

If we reduced its size to 32 (which could be easily done) we would
still inline 6642 out of 9317 symlinks on my machine. That's not bad.

Greetings
		Christoph


