Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423811AbWJaTXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423811AbWJaTXK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 14:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423810AbWJaTXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 14:23:10 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:31139 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1423811AbWJaTXI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 14:23:08 -0500
Date: Tue, 31 Oct 2006 12:36:10 -0600
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: akpm@osdl.org
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] eCryptfs: Fix pointer deref
Message-ID: <20061031183610.GA3230@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20061030233209.GC3458@us.ibm.com> <20061030233637.GB21515@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061030233637.GB21515@us.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2006 at 05:36:37PM -0600, Michael Halcrow wrote:
> +	algified_name_len = (chaining_modifier_len + cipher_name_len + 3);
> +	(*algified_name) = kmalloc(algified_name_len, GFP_KERNEL);
> +	if (!(algified_name)) {
> +		rc = -ENOMEM;
> +		goto out;
> +	}

I missed a pointer dereference in this kmalloc result check.

Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 fs/ecryptfs/crypto.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

b30f5b01ff79d9250dbd9e39db1c1aae7719c815
diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 3f83613..9333fa3 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -134,7 +134,7 @@ int ecryptfs_crypto_api_algify_cipher_na
 
 	algified_name_len = (chaining_modifier_len + cipher_name_len + 3);
 	(*algified_name) = kmalloc(algified_name_len, GFP_KERNEL);
-	if (!(algified_name)) {
+	if (!(*algified_name)) {
 		rc = -ENOMEM;
 		goto out;
 	}
-- 
1.3.3

