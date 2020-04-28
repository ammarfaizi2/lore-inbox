Return-Path: <SRS0=aNMB=6M=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DDAC83000
	for <io-uring@archiver.kernel.org>; Tue, 28 Apr 2020 20:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C8F22070B
	for <io-uring@archiver.kernel.org>; Tue, 28 Apr 2020 20:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgD1UHe (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:07:34 -0400
Received: from static-213-198-238-194.adsl.eunet.rs ([213.198.238.194]:43876
        "EHLO fx.arvanta.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbgD1UHZ (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 28 Apr 2020 16:07:25 -0400
X-Greylist: delayed 2247 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Apr 2020 16:07:24 EDT
Received: from arya.arvanta.net (arya.arvanta.net [10.5.1.6])
        by fx.arvanta.net (Postfix) with ESMTP id 807AA5330
        for <io-uring@vger.kernel.org>; Tue, 28 Apr 2020 21:29:56 +0200 (CEST)
Date:   Tue, 28 Apr 2020 21:29:56 +0200
From:   Milan =?utf-8?Q?P=2E_Stani=C4=87?= <mps@arvanta.net>
To:     io-uring@vger.kernel.org
Subject: Build 0.6 version fail on musl libc
Message-ID: <20200428192956.GA32615@arya.arvanta.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Hello,

I'm liburing Alpine Linux maintainer
(https://git.alpinelinux.org/aports/tree/testing/liburing)

I tried to upgrade to 0.6 from 0.5 version but I got errors:
include/liburing/compat.h:6:2: error: unknown type name 'int64_t'
and
include/liburing.h:196:17: error: unknown type name 'loff_t'; did you mean 'off_t'?

musl libc have /usr/include/fcntl.h in which loff_t is defined with:
#define loff_t off_t
and I tried to include it in include/liburing.h but this didn't helped.

After this I created this patch:
------
--- a/src/include/liburing.h	2020-04-13 18:50:21.000000000 +0200
+++ b/src/include/liburing.h	2020-04-23 21:43:15.923487287 +0200
@@ -193,8 +193,8 @@
 }
 
 static inline void io_uring_prep_splice(struct io_uring_sqe *sqe,
-					int fd_in, loff_t off_in,
-					int fd_out, loff_t off_out,
+					int fd_in, off_t off_in,
+					int fd_out, off_t off_out,
 					unsigned int nbytes,
 					unsigned int splice_flags)
 {
------
with which version 0.6 builds fine but I suspect this is not proper fix.

Could you, please, give me advice what will be proper fix these changes?

-- 
regards
