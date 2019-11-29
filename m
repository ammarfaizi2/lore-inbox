Return-Path: <SRS0=UBdq=ZV=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BDBC432C3
	for <io-uring@archiver.kernel.org>; Fri, 29 Nov 2019 08:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97A62176D
	for <io-uring@archiver.kernel.org>; Fri, 29 Nov 2019 08:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqNtCkAM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfK2IUI (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 29 Nov 2019 03:20:08 -0500
Received: from mail-vk1-f170.google.com ([209.85.221.170]:38582 "EHLO
        mail-vk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfK2IUI (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 29 Nov 2019 03:20:08 -0500
Received: by mail-vk1-f170.google.com with SMTP id m128so5403287vkb.5
        for <io-uring@vger.kernel.org>; Fri, 29 Nov 2019 00:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=srxBBxE8UZtdxTd4u3PoFHZ+ZnOGBdJ9n5WrZgrYDtQ=;
        b=SqNtCkAMEs5+D5UsK0wb20254IR5cyh3mkjrtu/0ztIBvE863Xu/2ox3IZlB1Tkj/o
         iwEstwGNt8oz8zzTySZhm7IvEKKWI/baCPdq4Q+72BTu9xTVrrmJ7IFNb6Y/zoYEzfGo
         iWuNErqJ9I2IHpHyaMe0k4cxYOcMhCmAfokGQ1Ubb2d7wVJJUNafNzs0EFfbhk7SmRso
         goI9vfG74ltkZx0PRXY/FrD84T4cwHT5oopnhgPm9t0ucFjJ4dx4Qc61mwkLVbKp7q+O
         G2ilNjB9OqHTorkyjKcNywtdFXdfn2Fcl6ZZxYZjCrj4+Dj9ISLjmKCBjOafP6BSeH4r
         DvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=srxBBxE8UZtdxTd4u3PoFHZ+ZnOGBdJ9n5WrZgrYDtQ=;
        b=iGIdFFNLpzsUPPrqZ/WxVRRVhZyskLFL8MHMQLkKQDPGv2cxJJOU5/O1llf2xqp9R7
         vcwtnVo2RffQa2fF19CEtKsAE8NKBG3IwuTM6BADKO4PO9ClwytBARYyc13mgaIxnVc9
         SFRJtSXbbXjOsh94TSYT/wsjg8E/vZOPGbn+KegxBMHJmLDzXkzQmn9cjPFB0PfY0YBT
         rM7iB126zqG8sub74S+9VZPdFT8egHo1suqccqkoEkMZnoXhQOkrrzoPypHjNhFpK1/U
         2jynr9OclZyxz4e/60TVEqwsf3SJFqzJg6YsqQKu5/voqZBLeQ6B2HDgMfJ+JtTx2dzf
         9gJQ==
X-Gm-Message-State: APjAAAV8jH/0r9rcVa/ltIHUlOO7L3rY04svw0w3We0MiunlwK1pbInQ
        9r+v1I0qd4iunvD/H7nv806DKm/yY2+Vzoab/M3XCdsFRGk=
X-Google-Smtp-Source: APXvYqwIs6vWiaGRryt8pg8zwv4khthRQ8FICgpmleAn69bav9CmWcTX4NtU/GjgIaJVnEH/qEeZ0s9lzepLlMix1hk=
X-Received: by 2002:a1f:938c:: with SMTP id v134mr8969926vkd.85.1575015607187;
 Fri, 29 Nov 2019 00:20:07 -0800 (PST)
MIME-Version: 1.0
From:   liming wu <wu860403@gmail.com>
Date:   Fri, 29 Nov 2019 16:19:55 +0800
Message-ID: <CAPnMXWW=cV_H2xs=r21DOuhfKWcCaxgG2iXR9LaExuRMNGUvpA@mail.gmail.com>
Subject: delete unneeded int-type
To:     io-uring@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000c88a09059877e59b"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

--000000000000c88a09059877e59b
Content-Type: text/plain; charset="UTF-8"

Hi

It can't buid successfully except use c99.


Subject: [PATCH] delete unneede int-type

---
 test/accept-link.c | 2 +-
 test/poll-link.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/accept-link.c b/test/accept-link.c
index 2fbc12e..91dbc2b 100644
--- a/test/accept-link.c
+++ b/test/accept-link.c
@@ -131,7 +131,7 @@ void *recv_thread(void *arg)

        assert(io_uring_submit(&ring) == 2);

-       for (int i = 0; i < 2; i++) {
+       for (i = 0; i < 2; i++) {
                struct io_uring_cqe *cqe;
                int idx;

diff --git a/test/poll-link.c b/test/poll-link.c
index 3cc2ca7..abddb71 100644
--- a/test/poll-link.c
+++ b/test/poll-link.c
@@ -127,7 +127,7 @@ void *recv_thread(void *arg)

        assert(io_uring_submit(&ring) == 2);

-       for (int i = 0; i < 2; i++) {
+       for (i = 0; i < 2; i++) {
                struct io_uring_cqe *cqe;
                int idx;

--

--000000000000c88a09059877e59b
Content-Type: application/octet-stream; name="delete-unneede-int-type.patch"
Content-Disposition: attachment; filename="delete-unneede-int-type.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k3jvddab0>
X-Attachment-Id: f_k3jvddab0

RnJvbSA4MzAxNGU3MTNlMDdkMzRkMDY3NGU3NzEwNzkxNzQxNGZjNWU3OGQ2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW1pbmdXdSA8MTkwOTIyMDVAc3VuaW5nLmNvbT4KRGF0ZTog
RnJpLCAyOSBOb3YgMjAxOSAxNTo0OToxNSArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGRlbGV0ZSB1
bm5lZWRlIGludC10eXBlCgotLS0KIHRlc3QvYWNjZXB0LWxpbmsuYyB8IDIgKy0KIHRlc3QvcG9s
bC1saW5rLmMgICB8IDIgKy0KIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rlc3QvYWNjZXB0LWxpbmsuYyBiL3Rlc3QvYWNjZXB0
LWxpbmsuYwppbmRleCAyZmJjMTJlLi45MWRiYzJiIDEwMDY0NAotLS0gYS90ZXN0L2FjY2VwdC1s
aW5rLmMKKysrIGIvdGVzdC9hY2NlcHQtbGluay5jCkBAIC0xMzEsNyArMTMxLDcgQEAgdm9pZCAq
cmVjdl90aHJlYWQodm9pZCAqYXJnKQogCiAJYXNzZXJ0KGlvX3VyaW5nX3N1Ym1pdCgmcmluZykg
PT0gMik7CiAKLQlmb3IgKGludCBpID0gMDsgaSA8IDI7IGkrKykgeworCWZvciAoaSA9IDA7IGkg
PCAyOyBpKyspIHsKIAkJc3RydWN0IGlvX3VyaW5nX2NxZSAqY3FlOwogCQlpbnQgaWR4OwogCmRp
ZmYgLS1naXQgYS90ZXN0L3BvbGwtbGluay5jIGIvdGVzdC9wb2xsLWxpbmsuYwppbmRleCAzY2My
Y2E3Li5hYmRkYjcxIDEwMDY0NAotLS0gYS90ZXN0L3BvbGwtbGluay5jCisrKyBiL3Rlc3QvcG9s
bC1saW5rLmMKQEAgLTEyNyw3ICsxMjcsNyBAQCB2b2lkICpyZWN2X3RocmVhZCh2b2lkICphcmcp
CiAKIAlhc3NlcnQoaW9fdXJpbmdfc3VibWl0KCZyaW5nKSA9PSAyKTsKIAotCWZvciAoaW50IGkg
PSAwOyBpIDwgMjsgaSsrKSB7CisJZm9yIChpID0gMDsgaSA8IDI7IGkrKykgewogCQlzdHJ1Y3Qg
aW9fdXJpbmdfY3FlICpjcWU7CiAJCWludCBpZHg7CiAKLS0gCjEuOC4zLjEKCg==
--000000000000c88a09059877e59b--
