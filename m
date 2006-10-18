Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbWJRE0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWJRE0w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 00:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbWJRE0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 00:26:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10900 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932075AbWJRE0u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 00:26:50 -0400
Date: Wed, 18 Oct 2006 00:26:39 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: airlied@linux.ie
Subject: [DRM] fix return code in error case.
Message-ID: <20061018042639.GA7437@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, airlied@linux.ie
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The other failure returns in this function are negative, so make
this one do the same.

Signed-off-by: Dave Jones <davej@redhat.com>

diff --git a/drivers/char/drm/savage_state.c b/drivers/char/drm/savage_state.c
index ef2581d..1ca1e9c 100644
--- a/drivers/char/drm/savage_state.c
+++ b/drivers/char/drm/savage_state.c
@@ -994,7 +994,7 @@ int savage_bci_cmdbuf(DRM_IOCTL_ARGS)
 	if (cmdbuf.size) {
 		kcmd_addr = drm_alloc(cmdbuf.size * 8, DRM_MEM_DRIVER);
 		if (kcmd_addr == NULL)
-			return ENOMEM;
+			return DRM_ERR(ENOMEM);
 
 		if (DRM_COPY_FROM_USER(kcmd_addr, cmdbuf.cmd_addr,
 				       cmdbuf.size * 8))
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c

-- 
http://www.codemonkey.org.uk
