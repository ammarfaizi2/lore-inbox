Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261966AbVBPJ2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbVBPJ2Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 04:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbVBPJ2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 04:28:16 -0500
Received: from mx3.mail.ru ([194.67.23.23]:23333 "EHLO mx3.mail.ru")
	by vger.kernel.org with ESMTP id S261966AbVBPJ2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 04:28:12 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: "__be32 s_addr" ? (was Re: [PATCH] procfs: Fix sparse warnings)
Date: Wed, 16 Feb 2005 12:28:09 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200502151455.55711.adobriyan@mail.ru> <20050215192618.GL8859@parcelfarce.linux.theplanet.co.uk> <20050216083550.GO8859@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050216083550.GO8859@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200502161228.09900.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 February 2005 10:35, Al Viro wrote:

> Most of the mess is in drivers/*, arch/* and (for endianness patches) net/*...

Yes, net/*. Many do X.s_addr = htonl(blah). Is this correct?

--- a/include/linux/in.h
+++ b/include/linux/in.h
@@ -51,7 +51,7 @@ enum {
 
 /* Internet address. */
 struct in_addr {
-	__u32	s_addr;
+	__be32	s_addr;
 };
 
 #define IP_TOS		1

It gives approximately "486 insertions(+), 183 deletions(-)" between two
logs without and with this change (adds more then removes as is).

	Alexey
