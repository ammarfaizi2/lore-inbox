Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D78EC2D0E4
	for <io-uring@archiver.kernel.org>; Mon, 23 Nov 2020 15:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DFCC20719
	for <io-uring@archiver.kernel.org>; Mon, 23 Nov 2020 15:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nametag.social header.i=@nametag.social header.b="spMf9gBb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731420AbgKWPfn (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 23 Nov 2020 10:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbgKWPfn (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 23 Nov 2020 10:35:43 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E1DC0613CF
        for <io-uring@vger.kernel.org>; Mon, 23 Nov 2020 07:35:41 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id k1so4605108eds.13
        for <io-uring@vger.kernel.org>; Mon, 23 Nov 2020 07:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nametag.social; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=OUai5nsHuWU8oSzWTOqMoLn2cLr9hydsuASWL4vzSA0=;
        b=spMf9gBbKG9RX8rMbACINXpl0mlxHKIupMt2RULHrvw/qSYxzr7BON8ZBqUnBjCpqn
         CXhPAaJ5fEQdFHmwYJOLKxbiuar1X1qfcvEVJsBhBnok1/5PHLCfsuULsdZ68sgAH26e
         rjWCJc+IvAJaCQpJXLqd+pK5wxKrdNLro1XHvIFeEpN0iGHbSwC7EyIzW5coMU2Yt/4A
         r4NtDPQMNqgqbKN03ha+cEr12FGxArdrWwEbEPfPGvKya/DX7d4eBPalt274rOf+ipFD
         /c2IIK1Z8qWoUQiS2t56ljeTDvaZ29P+a9ounzKFAV/Kn5aAN31RbdHC0OdCE1unvw02
         ZuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=OUai5nsHuWU8oSzWTOqMoLn2cLr9hydsuASWL4vzSA0=;
        b=KlXTF144Aw19UwHjUJF/qlPOACKfUjalUV0XiX5kk8TWVkQoLVyHHDZLoUR9CQgcek
         JqCrf/ANQ/82/PojiTOOWJ942UweIuhZIvKeL3rbqI4dKXc/lyWSYA+UqjEdmTEEB67/
         DHXqwrNh61VcwStqvKejhDWpd4dGg3RLHS2cLEM+gWYsD7m3V2YHX2oHHZDgaBdbPG5F
         9MpJCVT1NtsaMVkT79gdtpXbLquveCyV3hW3Xonzo2G/86cnWWluPfh6ujclsiHEp/1H
         k3/qgO742AmXBt7UGQ/pn5Qt6Zbmda+fu2gegL2WMbfrx/OJu3r9AXz04Q3tVF8uFw0N
         sHFw==
X-Gm-Message-State: AOAM533dB28fy4woKDCgP37bMe5V09o0JmlCLfWz3KQNrzBicjIeFU1d
        1HGf6Rl+P3tCAWpCYuEseZf5wIwnrCrUnXFRkexuURx324vGpU7/
X-Google-Smtp-Source: ABdhPJzf4HiyMbyhlSggN+96I3WDvzvwjHbKNTu3/WrPBx7i2u/3v74dyI+nuk2SedeO/lQjAMWFzx80H0zVzGijyYQ=
X-Received: by 2002:aa7:c049:: with SMTP id k9mr5698311edo.49.1606145739422;
 Mon, 23 Nov 2020 07:35:39 -0800 (PST)
MIME-Version: 1.0
From:   Victor Stewart <v@nametag.social>
Date:   Mon, 23 Nov 2020 15:35:28 +0000
Message-ID: <CAM1kxwjmGd8=992NjY6TjgsbMoxFS5j2_71bgaYUOUT0vG-19A@mail.gmail.com>
Subject: [RFC 1/1] whitelisting UDP GSO and GRO cmsgs
To:     io-uring <io-uring@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

add __sys_whitelisted_cmsghdrs() and configure __sys_recvmsg_sock and
__sys_sendmsg_sock to use it.

Signed-off by: Victor Stewart <v@nametag.social>
---
 net/socket.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index 6e6cccc2104f..44e28bb08bbe 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2416,9 +2416,9 @@ static int ___sys_sendmsg(struct socket *sock,
struct user_msghdr __user *msg,
 long __sys_sendmsg_sock(struct socket *sock, struct msghdr *msg,
                        unsigned int flags)
 {
-       /* disallow ancillary data requests from this path */
        if (msg->msg_control || msg->msg_controllen)
-               return -EINVAL;
+               if (!__sys_whitelisted_cmsghdrs(msr))
+                       return -EINVAL;

        return ____sys_sendmsg(sock, msg, flags, NULL, 0);
 }
@@ -2620,6 +2620,15 @@ static int ___sys_recvmsg(struct socket *sock,
struct user_msghdr __user *msg,
        return err;
 }

+static bool __sys_whitelisted_cmsghdrs(struct msghdr *msg)
+{
+       for (struct cmsghdr *cmsg = CMSG_FIRSTHDR(msg); cmsg != NULL;
cmsg = CMSG_NXTHDR(message, cmsg))
+               if (cmsg->cmsg_level != SOL_UDP || (cmsg->cmsg_type !=
UDP_GRO && cmsg->cmsg_type != UDP_SEGMENT))
+                       return false;
+
+       return true;
+}
+
 /*
  *     BSD recvmsg interface
  */
@@ -2630,7 +2639,7 @@ long __sys_recvmsg_sock(struct socket *sock,
struct msghdr *msg,
 {
        if (msg->msg_control || msg->msg_controllen) {
                /* disallow ancillary data reqs unless cmsg is plain data */
-               if (!(sock->ops->flags & PROTO_CMSG_DATA_ONLY))
+               if (!( sock->ops->flags & PROTO_CMSG_DATA_ONLY ||
__sys_whitelisted_cmsghdrs(msr) ))
                        return -EINVAL;
        }
