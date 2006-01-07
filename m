Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbWAGA0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWAGA0Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 19:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965386AbWAGA0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 19:26:00 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:17335 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S965376AbWAGAZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 19:25:48 -0500
Subject: [git patch review 8/8] IB/uverbs: set ah_flags when creating address
	handle
From: Roland Dreier <rolandd@cisco.com>
Date: Sat, 07 Jan 2006 00:25:43 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1136593543000-e3ddf87c14250050@cisco.com>
In-Reply-To: <1136593543000-bf2926ca65fa9af8@cisco.com>
X-OriginalArrivalTime: 07 Jan 2006 00:25:46.0058 (UTC) FILETIME=[E6E97AA0:01C61320]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AH attribute's ah_flags need to be set according to the is_global flag
passed in from userspace.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/core/uverbs_cmd.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

ea5d4a6ad2bfd1006790666981645cab43d3afbd
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 6985a57..12d6cc0 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -1454,6 +1454,7 @@ ssize_t ib_uverbs_create_ah(struct ib_uv
 	attr.sl 	       = cmd.attr.sl;
 	attr.src_path_bits     = cmd.attr.src_path_bits;
 	attr.static_rate       = cmd.attr.static_rate;
+	attr.ah_flags          = cmd.attr.is_global ? IB_AH_GRH : 0;
 	attr.port_num 	       = cmd.attr.port_num;
 	attr.grh.flow_label    = cmd.attr.grh.flow_label;
 	attr.grh.sgid_index    = cmd.attr.grh.sgid_index;
-- 
0.99.9n
