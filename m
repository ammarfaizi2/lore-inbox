Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWAaX22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWAaX22 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 18:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWAaX22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 18:28:28 -0500
Received: from uproxy.gmail.com ([66.249.92.201]:15176 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932124AbWAaX2Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 18:28:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=txXpjKzGzDQ9d2pdDXd6Xkd7B18yHYpsePsMJracdVaAu+g9Ojvo9cZJwr/G6wZn0gRoLESaXnKd8z1SFA6ipDCrYXjG6zsJgTBU6zem4ImhDKvOgjR8ghkIfolN0h5LVEJ6iuNpu/s1BA551WVj/4/A3sY7d0HyFEMUZEZJUeY=
Date: Wed, 1 Feb 2006 02:46:34 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] Mark CONFIG_UFS_FS_WRITE as BROKEN
Message-ID: <20060131234634.GA13773@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OpenBSD doesn't see "." correctly in directories created by Linux.
Copying files over several KB will buy you infinite loop in
__getblk_slow(). Copying files smaller than 1 KB seems to be OK.
Sometimes files will be filled with zeros. Sometimes incorrectly copied
file will reappear after next file with truncated size.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -1327,7 +1327,7 @@ config UFS_FS
 
 config UFS_FS_WRITE
 	bool "UFS file system write support (DANGEROUS)"
-	depends on UFS_FS && EXPERIMENTAL
+	depends on UFS_FS && EXPERIMENTAL && BROKEN
 	help
 	  Say Y here if you want to try writing to UFS partitions. This is
 	  experimental, so you should back up your UFS partitions beforehand.

