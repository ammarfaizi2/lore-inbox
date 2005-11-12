Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbVKLVAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbVKLVAv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 16:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbVKLVAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 16:00:50 -0500
Received: from mail.isurf.ca ([66.154.97.68]:9416 "EHLO columbo.isurf.ca")
	by vger.kernel.org with ESMTP id S964807AbVKLVAt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 16:00:49 -0500
From: "Gabriel A. Devenyi" <ace@staticwave.ca>
To: hermes@gibson.dropbear.id.au
Subject: [PATCH] drivers/net/wireless/hermes.c unsigned int comparision
Date: Sat, 12 Nov 2005 16:00:46 -0500
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, orinoco-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511121600.46758.ace@staticwave.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hermas_bap_pread,  hermes_bap_pwrite, and hermes_bap_pwrite_pad all have a parameter "len" that is declared unsigned,
but checked for a value less than zero. Auditing the callers, it is possible for len to be passed a negative value, so len should be an int.

Thanks to LinuxICC (http://linuxicc.sf.net)

Signed-off-by: Gabriel A. Devenyi <ace@staticwave.ca>

diff --git a/drivers/net/wireless/hermes.c b/drivers/net/wireless/hermes.c
index 579480d..346c6fe 100644
--- a/drivers/net/wireless/hermes.c
+++ b/drivers/net/wireless/hermes.c
@@ -398,7 +398,7 @@ static int hermes_bap_seek(hermes_t *hw,
  *
  * Returns: < 0 on internal failure (errno), 0 on success, > 0 on error from firmware
  */
-int hermes_bap_pread(hermes_t *hw, int bap, void *buf, unsigned len,
+int hermes_bap_pread(hermes_t *hw, int bap, void *buf, int len,
 		     u16 id, u16 offset)
 {
 	int dreg = bap ? HERMES_DATA1 : HERMES_DATA0;
@@ -424,7 +424,7 @@ int hermes_bap_pread(hermes_t *hw, int b
  *
  * Returns: < 0 on internal failure (errno), 0 on success, > 0 on error from firmware
  */
-int hermes_bap_pwrite(hermes_t *hw, int bap, const void *buf, unsigned len,
+int hermes_bap_pwrite(hermes_t *hw, int bap, const void *buf, int len,
 		      u16 id, u16 offset)
 {
 	int dreg = bap ? HERMES_DATA1 : HERMES_DATA0;
@@ -450,7 +450,7 @@ int hermes_bap_pwrite(hermes_t *hw, int 
  *
  * Returns: < 0 on internal failure (errno), 0 on success, > 0 on error from firmware
  */
-int hermes_bap_pwrite_pad(hermes_t *hw, int bap, const void *buf, unsigned data_len, unsigned len,
+int hermes_bap_pwrite_pad(hermes_t *hw, int bap, const void *buf, unsigned data_len, int len,
 		      u16 id, u16 offset)
 {
 	int dreg = bap ? HERMES_DATA1 : HERMES_DATA0;

-- 
Gabriel A. Devenyi
ace@staticwave.ca
