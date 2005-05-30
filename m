Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbVE3U66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbVE3U66 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 16:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbVE3U55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 16:57:57 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:25102 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261752AbVE3U4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 16:56:48 -0400
Date: Mon, 30 May 2005 22:56:45 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: sri@us.ibm.com, lksctp-developers@lists.sourceforge.net,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] net/sctp/: make two functions static
Message-ID: <20050530205645.GV10441@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes two needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked-by: Sridhar Samudrala <sri@us.ibm.com>

---

This patch was already sent on:
- 7 May 2005

 include/net/sctp/sm.h   |    3 ---
 net/sctp/sm_statefuns.c |   13 +++++++++++--
 2 files changed, 11 insertions(+), 5 deletions(-)

--- linux-2.6.12-rc3-mm3-full/include/net/sctp/sm.h.old	2005-05-05 22:59:54.000000000 +0200
+++ linux-2.6.12-rc3-mm3-full/include/net/sctp/sm.h	2005-05-06 00:17:40.000000000 +0200
@@ -130,7 +130,6 @@
 sctp_state_fn_t sctp_sf_ootb;
 sctp_state_fn_t sctp_sf_pdiscard;
 sctp_state_fn_t sctp_sf_violation;
-sctp_state_fn_t sctp_sf_violation_chunklen;
 sctp_state_fn_t sctp_sf_discard_chunk;
 sctp_state_fn_t sctp_sf_do_5_2_1_siminit;
 sctp_state_fn_t sctp_sf_do_5_2_2_dupinit;
@@ -258,8 +257,6 @@
 void sctp_chunk_assign_tsn(struct sctp_chunk *);
 void sctp_chunk_assign_ssn(struct sctp_chunk *);
 
-void sctp_stop_t1_and_abort(sctp_cmd_seq_t *commands, __u16 error);
-
 /* Prototypes for statetable processing. */
 
 int sctp_do_sm(sctp_event_t event_type, sctp_subtype_t subtype,
--- linux-2.6.12-rc3-mm3-full/net/sctp/sm_statefuns.c.old	2005-05-05 23:00:12.000000000 +0200
+++ linux-2.6.12-rc3-mm3-full/net/sctp/sm_statefuns.c	2005-05-06 00:19:11.000000000 +0200
@@ -92,6 +92,14 @@
 					     sctp_cmd_seq_t *commands);
 static struct sctp_sackhdr *sctp_sm_pull_sack(struct sctp_chunk *chunk);
 
+static void sctp_stop_t1_and_abort(sctp_cmd_seq_t *commands, __u16 error);
+
+static sctp_disposition_t sctp_sf_violation_chunklen(
+				     const struct sctp_endpoint *ep,
+				     const struct sctp_association *asoc,
+				     const sctp_subtype_t type,
+				     void *arg,
+				     sctp_cmd_seq_t *commands);
 
 /* Small helper function that checks if the chunk length
  * is of the appropriate length.  The 'required_length' argument
@@ -2318,7 +2326,7 @@
  *
  * This is common code called by several sctp_sf_*_abort() functions above.
  */
-void sctp_stop_t1_and_abort(sctp_cmd_seq_t *commands, __u16 error)
+static void sctp_stop_t1_and_abort(sctp_cmd_seq_t *commands, __u16 error)
 {
 	sctp_add_cmd_sf(commands, SCTP_CMD_NEW_STATE,
 			SCTP_STATE(SCTP_STATE_CLOSED));
@@ -3672,7 +3680,8 @@
  *
  * Generate an  ABORT chunk and terminate the association.
  */
-sctp_disposition_t sctp_sf_violation_chunklen(const struct sctp_endpoint *ep,
+static sctp_disposition_t sctp_sf_violation_chunklen(
+				     const struct sctp_endpoint *ep,
 				     const struct sctp_association *asoc,
 				     const sctp_subtype_t type,
 				     void *arg,

