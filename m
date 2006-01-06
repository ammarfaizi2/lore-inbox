Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbWAFPRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWAFPRM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 10:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbWAFPQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 10:16:49 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:2714 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1751497AbWAFPQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 10:16:46 -0500
Date: Fri, 6 Jan 2006 13:07:29 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: akpm <akpm@osdl.org>
Cc: axboe@suse.de, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] bio: gcc warning fix.
Message-Id: <20060106130729.31561730.lcapitulino@mandriva.com.br>
Organization: Mandriva
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Fixes the following gcc 4.0.2 warning:

fs/bio.c: In function 'bio_alloc_bioset':
fs/bio.c:167: warning: 'idx' may be used uninitialized in this function

Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>

 fs/bio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bio.c b/fs/bio.c
index 38d3e80..55a5688 100644
--- a/fs/bio.c
+++ b/fs/bio.c
@@ -164,7 +164,7 @@ struct bio *bio_alloc_bioset(gfp_t gfp_m
 
 		bio_init(bio);
 		if (likely(nr_iovecs)) {
-			unsigned long idx;
+			unsigned long idx = 0;
 
 			bvl = bvec_alloc_bs(gfp_mask, nr_iovecs, &idx, bs);
 			if (unlikely(!bvl)) {


-- 
Luiz Fernando N. Capitulino
