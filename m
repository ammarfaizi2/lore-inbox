Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWBKX3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWBKX3p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 18:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWBKX3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 18:29:45 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:45907 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750830AbWBKX3p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 18:29:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=pOki3SgNLvl362cW1uW+Jcpom1J574Wv14TVgMp+nln1ZJe72UNmtw0f+dAP/dEprgQoFVJYELDSOQrmampagcLoB17Unxy+UuHvtWEePhRizH+Spm1unIICgNZoIVbH4fLLvYKlMYo6huFb6Z9ZeZvQqpBu8f0y35guIdKMPws=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: [PATCH] nfs: fix ICC Storage Class is not First warning
Date: Sun, 12 Feb 2006 00:29:52 +0100
User-Agent: KMail/1.9
Cc: Kendrick Smith <kmsmith@umich.edu>, Andy Adamson <andros@umich.edu>,
       Neil Brown <neilb@cse.unsw.edu.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>, nfs@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602120029.52954.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems my patch to change "const static" into "static const" in order to 
please ICC (commit: 3c6bee1d4037a5c569f30d40bd852a57ba250912) 
missed a single case.
This patch fixes the last instance.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

--- linux-2.6.16-rc2-git10/fs/nfs/nfs4proc.c~	2006-02-12 00:22:00.000000000 +0100
+++ linux-2.6.16-rc2-git10/fs/nfs/nfs4proc.c	2006-02-12 00:22:00.000000000 +0100
@@ -2958,7 +2958,7 @@ static void nfs4_delegreturn_release(voi
 	kfree(calldata);
 }
 
-const static struct rpc_call_ops nfs4_delegreturn_ops = {
+static const struct rpc_call_ops nfs4_delegreturn_ops = {
 	.rpc_call_prepare = nfs4_delegreturn_prepare,
 	.rpc_call_done = nfs4_delegreturn_done,
 	.rpc_release = nfs4_delegreturn_release,


