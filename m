Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131309AbRCNFWK>; Wed, 14 Mar 2001 00:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131308AbRCNFWA>; Wed, 14 Mar 2001 00:22:00 -0500
Received: from odin.sinectis.com.ar ([216.244.192.158]:35602 "EHLO
	mail.sinectis.com.ar") by vger.kernel.org with ESMTP
	id <S131305AbRCNFVv> convert rfc822-to-8bit; Wed, 14 Mar 2001 00:21:51 -0500
Date: Wed, 14 Mar 2001 02:22:36 -0300
From: John R Lenton <john@grulic.org.ar>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ln -l says symlink has size 281474976710666
Message-ID: <20010314022236.D18554@grulic.org.ar>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20010313033526.A633@grulic.org.ar> <200103132147.f2DLlGb05518@webber.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.3.15i
In-Reply-To: <200103132147.f2DLlGb05518@webber.adilger.int>; from adilger@turbolinux.com on Tue, Mar 13, 2001 at 02:47:16PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2001 at 02:47:16PM -0700, Andreas Dilger wrote:
> ls -i (path)/imlib1; ls -i (path)/fd         # record inode numbers
> debugfs /dev/hdX
> stat <inode_number>                          # '<' and '>' are required

burocracia:~# ls -i /usr/share/doc/|grep \ imlib1$
 404176 imlib1
burocracia:~# ls -i /dev/|grep fd$
 404192 fd
burocracia:~# debugfs /dev/hda2
debugfs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
debugfs:  stat <404176>
Inode: 404176   Type: symlink    Mode:  0777   Flags: 0x0   Generation: 2457884131
User:     0   Group:     0   Size: 281474976710666
File ACL: 0    Directory ACL: 0
Links: 1   Blockcount: 0
Fragment:  Address: 0    Number: 0    Size: 0
ctime: 0x3a735ed8 -- Sat Jan 27 20:50:48 2001
atime: 0x3aaef4cd -- Wed Mar 14 01:34:21 2001
mtime: 0x3a735ed8 -- Sat Jan 27 20:50:48 2001
Fast_link_dest: imlib-base
debugfs:  stat <404192>
Inode: 404192   Type: symlink    Mode:  0777   Flags: 0x0   Generation: 1796859698
User:     0   Group:     0   Size: 281474976710669
File ACL: 0    Directory ACL: 0
Links: 1   Blockcount: 0
Fragment:  Address: 0    Number: 0    Size: 0
ctime: 0x3a7308d5 -- Sat Jan 27 14:43:49 2001
atime: 0x3aaef4cd -- Wed Mar 14 01:34:21 2001
mtime: 0x3a7308d5 -- Sat Jan 27 14:43:49 2001
Fast_link_dest: /proc/self/fd

> send output.  This should tell us if the badness is stored on disk or in
> memory.  Of course e2fsck would help as well.  Were these newly created
> inodes, or existing ones?  If you shutdown and restart, does it go away?
> Anything in syslog about ext2 warnings or errors?

this is after an e2fsck, after a reboot, after restart. Nothing
in the logs. The inodes are as old as the system, which isn't all
that old (circa the first release with reiserfs).

I did a find on the whole filesystem and I seem to have stumbled
on the only two files with this problem by accident.

-- 
John Lenton (john@grulic.org.ar) -- Random fortune:
Acepto que sientas odio, pero no que actúes con él...
acepto que ames, aplaudo que actúes siempre con él.
   -- Montesino.
