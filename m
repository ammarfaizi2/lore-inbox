Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932266AbWDYREn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbWDYREn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 13:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbWDYREn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 13:04:43 -0400
Received: from gate.crashing.org ([63.228.1.57]:25047 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932266AbWDYREm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 13:04:42 -0400
Date: Tue, 25 Apr 2006 11:58:55 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
X-X-Sender: galak@gate.crashing.org
To: Andrew Morton <akpm@osdl.org>, <khali@linux-fr.org>
cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       <lm-sensors@lm-sensors.org>
Subject: [PATCH] I2C PCA954x: Fix initial access to first mux/switch port
Message-ID: <Pine.LNX.4.44.0604251157350.31640-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The first mux/switch port would not get selected if it was the first port to be
accessed because the code believed it already had.  We now initialize the last
channel to a bogus value to ensure the first access will properly select the
channel.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit 9040559b19987489000a75a5f8b4957ecbb0fa7f
tree 63056d09c30f32b71bf0a2a3d57a42c2380a9dd8
parent c2f0d4dc88921bb6bed9e289fbda132f587a4306
author Kumar Gala <galak@kernel.crashing.org> Tue, 25 Apr 2006 11:58:51 -0500
committer Kumar Gala <galak@kernel.crashing.org> Tue, 25 Apr 2006 11:58:51 -0500

 drivers/i2c/chips/pca954x.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/chips/pca954x.c b/drivers/i2c/chips/pca954x.c
index f300493..4ee38bc 100644
--- a/drivers/i2c/chips/pca954x.c
+++ b/drivers/i2c/chips/pca954x.c
@@ -234,6 +234,10 @@ static int pca954x_detect(struct i2c_ada
 
 	data->chip_offset = i;
 
+	/* Set last_chan to an invalid channel to force an initial setting
+	 * of the mux/switch on the first select_chan */
+	data->last_chan = 0xff;
+
 	if ((ret = i2c_attach_client(client)))
 		goto exit_free;
 


