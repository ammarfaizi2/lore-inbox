Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265700AbTBTNBn>; Thu, 20 Feb 2003 08:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265725AbTBTNBm>; Thu, 20 Feb 2003 08:01:42 -0500
Received: from ns.suse.de ([213.95.15.193]:65287 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265700AbTBTNBl> convert rfc822-to-8bit;
	Thu, 20 Feb 2003 08:01:41 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Labs, SuSE Linux AG
To: Neil Brown <neilb@cse.unsw.edu.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: [RFC] ACLs over NFS: Handling of large buffers
Date: Thu, 20 Feb 2003 14:11:42 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, Olaf Kirch <okir@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200302201411.42714.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

in the current kernel nfsd, a buffer of (8+1)k is allocated for each 
kernel nfsd thread. Since the NFS ACL protocol requests arrive at the 
same transport endpoint, in the short term (i.e., for the NFS ACL 
protocol) I need a limit of (24+1)k for each nfsd thread. While this 
wastes memory that will not be used most of the time, the amount of 
wasted memory is still not totally crazy.

However, the NFS ACL protocol still does not support Extended Attributes 
in general, so somebody will have to implement one of the EA NFS 
protocols in addition. (I'm leaning towards the one protocol extension 
from  SGI OB1). This will require a buffer of 64k. So I'm wondering how 
we could solve the problem of buffer space more flexibly. Any ideas?


Thanks,
Andreas.

