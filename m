Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261341AbSJYJqD>; Fri, 25 Oct 2002 05:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261344AbSJYJqC>; Fri, 25 Oct 2002 05:46:02 -0400
Received: from cmailm3.svr.pol.co.uk ([195.92.193.19]:63500 "EHLO
	cmailm3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S261341AbSJYJqC>; Fri, 25 Oct 2002 05:46:02 -0400
Date: Fri, 25 Oct 2002 10:52:11 +0100
To: Linux Mailing List <linux-kernel@vger.kernel.org>, linux-lvm@sistina.com,
       Alan Cox <alan@redhat.com>
Cc: christophe.varoqui@free.fr
Subject: Re: [Patch] Latest device-mapper snapshot
Message-ID: <20021025095211.GA1724@fib011235813.fsnet.co.uk>
References: <20021023102503.GA25925@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021023102503.GA25925@fib011235813.fsnet.co.uk>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doh !

# [Device-mapper]
# Forgot a bio_put()
# --------------------------------------------
#
diff -Nru a/drivers/md/dm.c b/drivers/md/dm.c
--- a/drivers/md/dm.c	Fri Oct 25 10:47:49 2002
+++ b/drivers/md/dm.c	Fri Oct 25 10:47:49 2002
@@ -270,8 +270,10 @@
 	 * finished.  If a partial io errors I'm assuming it won't
 	 * be requeued.  FIXME: check this.
 	 */
-	if (error || !bio->bi_size)
+	if (error || !bio->bi_size) {
 		dec_pending(io, error);
+		bio_put(bio);
+	}
 
 	return 0;
 }
