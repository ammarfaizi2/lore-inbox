Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbTKNNtv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 08:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbTKNNtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 08:49:51 -0500
Received: from pat.uio.no ([129.240.130.16]:51864 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262598AbTKNNtn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 08:49:43 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16308.56683.38537.801595@charged.uio.no>
Date: Fri, 14 Nov 2003 08:49:31 -0500
To: Martin.Knoblauch@mscsoftware.com
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: nfs_statfs: statfs error = 116
In-Reply-To: <OFC480E5CC.3BE734ED-ONC1256DDE.002F74B5-C1256DDE.002FF160@mscsoftware.com>
References: <shsislof1n4.fsf@charged.uio.no>
	<OFC480E5CC.3BE734ED-ONC1256DDE.002F74B5-C1256DDE.002FF160@mscsoftware.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Martin Knoblauch <Martin.Knoblauch@mscsoftware.com> writes:

     > I accidentally run iozone on two clients with the output file
     > being the same and residing on the NFS Server. Pure luser
     > error, but it produced ESTALE pretty much reproducibly.

Sure. This is a prime example of where ESTALE *is* appropriate. One
NFS client is deleting a file on the server while the other is still
using it.

In the NFSv2/v3 protocols, the assumption is that filehandles are
valid for the entire lifetime of the file on the server. IOW only
"unlink()" can cause a valid filehandle to become stale. This is
mainly because there is no notion of open()/close(), so the server
would never be capable of determining when your client has stopped
using the filehandle.

If your 2 processes were running on the same machine, you would have
seen the kernel temporarily rename your file to .nfsXXXXXX in order to
work around the above problem. Delete that file, and you will generate
ESTALE reproducibly too....

Cheers,
  Trond
