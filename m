Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267411AbUBSXc1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 18:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267419AbUBSXc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 18:32:27 -0500
Received: from q.bofh.de ([212.126.220.202]:2065 "EHLO q.bofh.de")
	by vger.kernel.org with ESMTP id S267411AbUBSXc0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 18:32:26 -0500
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: Linux 2.4.25-rc4
Mail-Copies-To: nobody
From: Hilko Bengen <bengen@hilluzination.de>
In-Reply-To: <Pine.LNX.4.58L.0402191639120.7378@logos.cnet> (Marcelo
 Tosatti's message of "Thu, 19 Feb 2004 16:39:39 -0300 (BRT)")
References: <Pine.LNX.4.58L.0402180207540.4852@logos.cnet>
	<8765e4rydf.fsf@hilluzination.de>
	<Pine.LNX.4.58L.0402191639120.7378@logos.cnet>
Date: Fri, 20 Feb 2004 00:28:23 +0100
Message-ID: <87vfm2ps2w.fsf@hilluzination.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> writes:

>> Ok, the bug has been there for ages and, being an ISA card, the
>> I-Surf is probably not used that much any more... Was there
>> anything wrong with the patch I sent?
>
> I dont think so. I will be in 2.4.26-pre1

Thanks.

There was also another patch which I posted earlier to this list. 

It fixes an issue with iomem being displayed wrong in /proc/isapnp
output. I found this when trying to debug the isurf issue.

Please include that also.

-Hilko

diff -uir orig/linux-2.4.23/drivers/pnp/isapnp_proc.c linux-2.4.24/drivers/pnp/isapnp_proc.c
--- orig/linux-2.4.23/drivers/pnp/isapnp_proc.c	2002-11-29 00:53:14.000000000 +0100
+++ linux-2.4.24/drivers/pnp/isapnp_proc.c	2004-02-06 14:56:45.000000000 +0100
@@ -649,7 +649,7 @@
 	if (next)
 		isapnp_printf(buffer, "\n");
 	for (i = next = 0; i < 4; i++) {
-		tmp = isapnp_read_dword(ISAPNP_CFG_MEM + (i << 3));
+		tmp = isapnp_read_word(ISAPNP_CFG_MEM + (i << 3)) << 8;
 		if (!tmp)
 			continue;
 		if (!next) {


