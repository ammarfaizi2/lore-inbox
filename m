Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131674AbQLRKdm>; Mon, 18 Dec 2000 05:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131692AbQLRKdc>; Mon, 18 Dec 2000 05:33:32 -0500
Received: from pat.uio.no ([129.240.130.16]:37115 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S131690AbQLRKdS>;
	Mon, 18 Dec 2000 05:33:18 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14909.57536.917716.473278@charged.uio.no>
Date: Mon, 18 Dec 2000 11:02:40 +0100 (CET)
To: "M.H.VanLeeuwen" <vanl@megsinet.net>
Cc: neilb@cse.unsw.edu.au, linux-kernel@vger.kernel.org
Subject: kernel BUG at /usr/src/linux/include/linux/nfs_fs.h:167! - reproducible
In-Reply-To: <3A3BE424.4A7FB8D9@megsinet.net>
In-Reply-To: <3A3BE424.4A7FB8D9@megsinet.net>
X-Mailer: VM 6.72 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == M H VanLeeuwen <vanl@megsinet.net> writes:

     > Trond, Neil I don't know if this is a loopback bug or an NFS
     > bug but since nfs_fs.h was implicated so I thought one of you
     > may be interested.
 
     > Could you let me know if you know this problem has already been
     > fixed or if you need more info.

Hi,
 
As far as I'm concerned, it's a loopback bug.

Somebody appears to be trying to copy a 'struct file' in the routine
'loop_set_fd'. This will cause havoc in any and all filesystems that
rely on f_ops->open() , f_ops->release() to maintain internal data.
In this case, it's the file's RPC authorizations, that are getting
garbage-collected from beneath you once the original struct file gets
fput() at the end of the routine.

Cheers,
  Trond
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
