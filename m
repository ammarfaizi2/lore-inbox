Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315734AbSFFIFg>; Thu, 6 Jun 2002 04:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316883AbSFFIFf>; Thu, 6 Jun 2002 04:05:35 -0400
Received: from relay.muni.cz ([147.251.4.35]:62363 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S315734AbSFFIFd>;
	Thu, 6 Jun 2002 04:05:33 -0400
Date: Thu, 6 Jun 2002 10:05:32 +0200
From: Jan Kasprzak <kas@informatics.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: Oops in fs/inode.c:
Message-ID: <20020606100532.A28260@informatics.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

b
find_inode()
Reply-To: 
In-Reply-To: <20020605084131.GD10536@informatics.muni.cz>; from kas@fi.muni.cz on Wed, Jun 05, 2002 at 10:41:31AM +0200

Jan Kasprzak wrote:
: 	I've got the following Oops today. The server is K7 850,
: 1.1GB RAM (so highmem is enabled), 3c985B (Tigon II) Gigabit NIC,
: IDE drives. The system has one ext2 and one ext3 volume, the ext2 one
: is located on LVM logical volume. Server runs variety of tasks, but
: the most intensive one is FTP server (ProFTPd using sendfile()).
: Both ext2 and ext3 volume has been forced fsck'd during the last boot.
: The HW problem is unlikely (this server worked more-on-less reliably
: during at least a year).  More details available on request.

	I have downgraded to 2.4.19-pre8, and got the same Oops
in few hours. It occured inside the "find" process (probably some
indexing of my FTP tree or a part of updatedb.  So it is probably
related to a directory-intensive code. It was again in find_inode()
function of fs/inode.c:

Unable to handle kernel paging request at virtual address 82c20c3b
 printing eip:
c014257a
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[find_inode+26/80]    Not tainted
EFLAGS: 00010297
eax: f7d00000   ebx: 82c20c13   ecx: 00000011   edx: 0001f367
esi: 82c20c13   edi: 006a0a1d   ebp: f7df9b38   esp: c79b5e98
ds: 0018   es: 0018   ss: 0018
Process find (pid: 17528, stackpage=c79b5000)
Stack: e6803740 f7df9b38 006a0a1d f6f9ca00 c0142981 f6f9ca00 006a0a1d f7df9b38
       00000000 00000000 c0161d66 f4bb8b40 e6803740 c0161da3 e6803740 f4bb8b40
       f4bb8b40 e6803240 c0164732 f6f9ca00 006a0a1d 00000000 00000000 22c81604
Call Trace: [iget4+65/192] [ext2_inode_by_name+22/96] [ext2_inode_by_name+83/96] [ext2_lookup+66/112] [real_lookup+77/192]
   [link_path_walk+1553/2192] [getname+93/160] [__user_walk+51/80] [sys_lstat64+20/112] [system_call+51/56]
Jun  6 06:50:28 odysseus kernel:
Code: 39 7e 28 75 f1 8b 44 24 14 39 86 98 00 00 00 75 e5 8b 44 24

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
|----------- If you want the holes in your knowledge showing up -----------|
|----------- try teaching someone.                  -- Alan Cox -----------|
