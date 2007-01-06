Return-Path: <linux-kernel-owner+w=401wt.eu-S1751381AbXAFNSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbXAFNSE (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 08:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbXAFNSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 08:18:03 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:21582 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbXAFNSA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 08:18:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent:from;
        b=jBhtZ55oLklnRwEZ4lKV97YsdcZEenr5kvj3Uul+Y9QiHKcDxy8odcvUBWmsKEl62C68PKu51042EQqgGsY057i6YHjxB/hI7bF9gGGotJnk7kEBN5MON/kgdpttpecKpv4ZBY5fCoN7TIAnU2M7R6vWOpY3y3h7mWYbgbGcQX0=
Date: Sat, 6 Jan 2007 15:17:44 +0200
To: sfrench@samba.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.20-rc3] CIFS: Remove 2 unneeded kzalloc casts
Message-ID: <20070106131744.GC19020@Ahmed>
Mail-Followup-To: sfrench@samba.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
A patch to remove two unnecessary kzalloc casts found

Signed-off-by: Ahmed Darwish <darwish.07@gmail.com>

diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index aedf683..90f95ed 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -71,9 +71,7 @@ sesInfoAlloc(void)
 {
 	struct cifsSesInfo *ret_buf;
 
-	ret_buf =
-	    (struct cifsSesInfo *) kzalloc(sizeof (struct cifsSesInfo),
-					   GFP_KERNEL);
+	ret_buf = kzalloc(sizeof (struct cifsSesInfo), GFP_KERNEL);
 	if (ret_buf) {
 		write_lock(&GlobalSMBSeslock);
 		atomic_inc(&sesInfoAllocCount);
@@ -109,9 +107,8 @@ struct cifsTconInfo *
 tconInfoAlloc(void)
 {
 	struct cifsTconInfo *ret_buf;
-	ret_buf =
-	    (struct cifsTconInfo *) kzalloc(sizeof (struct cifsTconInfo),
-					    GFP_KERNEL);
+	ret_buf = kzalloc(sizeof (struct cifsTconInfo),
+			  GFP_KERNEL);
 	if (ret_buf) {
 		write_lock(&GlobalSMBSeslock);
 		atomic_inc(&tconInfoAllocCount);

-- 
Ahmed S. Darwish
http://darwish-07.blogspot.com
