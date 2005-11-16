Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161007AbVKPXUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161007AbVKPXUW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 18:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161011AbVKPXUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 18:20:22 -0500
Received: from amdext4.amd.com ([163.181.251.6]:11756 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S1161007AbVKPXUU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 18:20:20 -0500
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
Date: Wed, 16 Nov 2005 16:23:45 -0700
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: linux-kernel@vger.kernel.org
Subject: PATCH:  Fix poor pointer math in devinet_sysctl_register
Message-ID: <20051116232345.GA872@cosmic.amd.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.11
X-WSS-ID: 6F65612D1M4863754-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes pointer math that under certain circumstances, results
in really bad pointers. This was encountered on a system compiled for i486, so
other compilers may differ, but I don't think it hurts anyone.

Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
---

 net/ipv4/devinet.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 4ec4b2c..7585fce 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -1454,7 +1454,7 @@ static void devinet_sysctl_register(stru
 		return;
 	memcpy(t, &devinet_sysctl, sizeof(*t));
 	for (i = 0; i < ARRAY_SIZE(t->devinet_vars) - 1; i++) {
-		t->devinet_vars[i].data += (char *)p - (char *)&ipv4_devconf;
+		t->devinet_vars[i].data += (int)((char *)p - (char *)&ipv4_devconf);
 		t->devinet_vars[i].de = NULL;
 	}
 

