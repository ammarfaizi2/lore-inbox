Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129121AbQJaKGR>; Tue, 31 Oct 2000 05:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129831AbQJaKGH>; Tue, 31 Oct 2000 05:06:07 -0500
Received: from north.net.CSUChico.EDU ([132.241.66.18]:32774 "EHLO
	north.net.csuchico.edu") by vger.kernel.org with ESMTP
	id <S129121AbQJaKFz>; Tue, 31 Oct 2000 05:05:55 -0500
Date: Tue, 31 Oct 2000 02:05:49 -0800
From: John Kennedy <jk@csuchico.edu>
To: Alexander Viro <viro@math.psu.edu>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: test10-pre7
Message-ID: <20001031020549.A9250@north.csuchico.edu>
In-Reply-To: <Pine.LNX.4.10.10010301128380.5551-100000@penguin.transmeta.com> <Pine.GSO.4.21.0010301505590.1177-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7JfCtLOvnd9MIVvH"
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.GSO.4.21.0010301505590.1177-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Mon, Oct 30, 2000 at 03:34:44PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii

On Mon, Oct 30, 2000 at 03:34:44PM -0500, Alexander Viro wrote:
> Unfortunately, it doesn't fix the thing. ->sync_page() is called ...
> Minimal patch (against -pre7) follows. It still leaves sync_page() problem
> open - any suggestions on that one are very welcome. ...

  I needed to patch your patch to get it to compile.


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=PATCH

--- ./mm/filemap.c.OLD	Mon Oct 30 23:00:35 2000
+++ ./mm/filemap.c	Mon Oct 30 23:11:26 2000
@@ -2313,9 +2313,9 @@
 				void *data)
 {
 	struct page *page;
+	int err;
 retry:
 	page = __read_cache_page(mapping, index, filler, data);
-	int err;
 
 	if (IS_ERR(page) || Page_Uptodate(page))
 		goto out;

--7JfCtLOvnd9MIVvH--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
