Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267715AbTAMPcv>; Mon, 13 Jan 2003 10:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267762AbTAMPcv>; Mon, 13 Jan 2003 10:32:51 -0500
Received: from main.gmane.org ([80.91.224.249]:5052 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S267715AbTAMPcu>;
	Mon, 13 Jan 2003 10:32:50 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Lars Magne Ingebrigtsen <larsi@gnus.org>
Subject: Performance problems with NFS under 2.4.20
Date: Mon, 13 Jan 2003 16:35:42 +0100
Organization: Programmerer Ingebrigtsen
Message-ID: <m3y95pkqpd.fsf@quimbies.gnus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@main.gmane.org
Mail-Copies-To: never
X-Now-Playing: Cocteau Twins's _Four-Calendar =?iso-8859-1?q?Caf=E9=5F:?=
 "Pur"
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2.50
 (i686-pc-linux-gnu)
Cancel-Lock: sha1:tRvdx9R556VQsiaT1Yc+VdmPQso=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Upgrading from 2.2.20, I'm seeing vastly increased network traffic,
and after poking around a bit, I find that all calls to open() on
files on NFS-mounted partitions generates one UDP packet.  Switching
on NFS debugging, and then saying

$ cat file
$ cat file

shows me this:

Jan 13 16:27:23 litos kernel: NFS: refresh_inode(b/876609548 ct=1 info=0x2)
Jan 13 16:27:23 litos kernel: nfs: read(//file, 4096@0)
Jan 13 16:27:23 litos kernel: nfs: read(//file, 4096@17)
Jan 13 16:27:23 litos kernel: nfs: flush(b/876609548)
Jan 13 16:27:23 litos kernel: NFS: dentry_delete(//file, 0)
Jan 13 16:27:24 litos kernel: NFS: refresh_inode(b/876609548 ct=1 info=0x2)
Jan 13 16:27:24 litos kernel: nfs: read(//file, 4096@0)
Jan 13 16:27:24 litos kernel: nfs: read(//file, 4096@17)
Jan 13 16:27:24 litos kernel: nfs: flush(b/876609548)
Jan 13 16:27:24 litos kernel: NFS: dentry_delete(//file, 0)

The partition is mounted with just

$ mount server:/db /db

Adding a "-o actimeo=100" makes no difference.

Is this supposed 1) to be this way, or 2) a bug, or 3) a
misconfiguration on my part?

-- 
(domestic pets only, the antidote for overdose, milk.)
   larsi@gnus.org * Lars Magne Ingebrigtsen

