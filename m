Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbWJ1Smc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbWJ1Smc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 14:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWJ1Smc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 14:42:32 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:52573 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751352AbWJ1Smb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 14:42:31 -0400
Date: Sat, 28 Oct 2006 19:42:27 +0100
From: Ken Moffat <zarniwhoop@ntlworld.com>
To: linux-kernel@vger.kernel.org
Subject: NFS problem (r/o filesystem) with 2.6.19-rc3
Message-ID: <20061028184226.GA1225@deepthought.linux.bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 yesterday I moved this desktop box to -rc3 from 2.6.18.  I have a
large amount of data on nfs mounts (r/w) and everything looks good.
But, for my backups I have cron jobs to mount a different nfs
filesystem and rsync to it.  That fails with 2.6.19-rc3, giving me
messages like

about to mount /nfs
Sat Oct 28 18:45:03 BST 2006 rsyncing
rsync: failed to set times on "/nfs/bluesbreaker/boot/.": Read-only
file system (30)
rsync: mkstemp "/nfs/bluesbreaker/boot/.map.c2Cj91" failed:
Read-only file system (30)
rsync: mkstemp
"/nfs/bluesbreaker/boot/.vmlinuz-2.6.19-rc3-sda8.pXKgH9" failed:
Read-only file system (30)
rsync: failed to set times on "/nfs/bluesbreaker/boot/.": Read-only
file system (30)
rsync error: some files could not be transferred (code 23) at
main.c(791)
rsync failed
umounting /nfs

 If I mount it manually, it seems to be ok -
root@bluesbreaker /home/ken #mount
/dev/sda8 on / type auto (rw)
[...]
deepthought:/data/staging on /nfs type nfs (rw,hard,intr,tcp,addr=192.168.0.10)
root@bluesbreaker /home/ken #

 But if I then try to touch a file I find the filesystem is r/o -
root@bluesbreaker /home/ken #touch /nfs/bluesbreaker/boot/vmlinuz-2.6.18-sda8 
touch: cannot touch `/nfs/bluesbreaker/boot/vmlinuz-2.6.18-sda8':
Read-only file system

 This filesystem is a 'staging' area where whichever of my desktop
machines are up can write.  From a different box using a 2.6.17.13
kernel the filesystem is r/w.  The system log on the machine running
rc3 only shows that rsync ended in error, there are no associated
kernel messages. 

 Suggestions, please ?

Ken
-- 
das eine Mal als Tragödie, das andere Mal als Farce
