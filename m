Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265282AbSJaR7y>; Thu, 31 Oct 2002 12:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265287AbSJaR7x>; Thu, 31 Oct 2002 12:59:53 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:23476 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265282AbSJaR7i>;
	Thu, 31 Oct 2002 12:59:38 -0500
Subject: Proposal for new lock ownership scheme to support NFS over distributed
 filesystems
To: linux-kernel@vger.kernel.org
Cc: nfs@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.2a (Intl) 23 November 1999
Message-ID: <OF322A6213.F82904FF-ON87256C63.00620AD8@us.ibm.com>
From: Juan Gomez <juang@us.ibm.com>
Date: Thu, 31 Oct 2002 10:05:51 -0800
X-MIMETrack: Serialize by Router on D03NM694/03/M/IBM(Release 6.0|September 26, 2002) at
 10/31/2002 11:05:51
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Hello all,

As a prelude to adding support in kNFS(lockd) to pass lock information via
the VFS interface I want to firsr propose some minor changes that will
enable us to have a single lock ownership space that is shared and enforced
at all nodes.

Currently lockd identified range locks with two fields fl_owner and fl_pid.
NFS code places a memory pointer (pointer to host structure representing
NFS client holding the lock) in fl_owner which works great in single node
NFS but breaks when we attempt to pass lock requests to an the underlying
distributed filesystem in the context of a clustered NAS head. This can be
easily fixed by filling fl_owner field with the IP address of the NFS
client requesting the lock, which is just a minor patch.

The patch above, however, does not fix all our problems as locks acquired
locally in the NFS server nodes could collide with NFS locks. Currently,
the fl_owner field for locks acquired via the local file system is filled
with another memory pointer (i.e. current->files). This also breaks appart
when using a distributed file system. My proposal for this would be use a
local IP address to put in the fl_owner field of locks acquired locally in
a node.

These two patches cause no problem for current single node NFS servers and
enable Linux as a platform to support distributed filesystems and NFS
serving simultaneously and correctly.

I would like to get your feedback on this proposal and if accepted as it is
I will later follow with patches for current versions of the kernel NFS.


Regards, Juan

