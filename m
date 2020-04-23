Return-Path: <SRS0=cUGF=6H=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2AA7C54FD0
	for <io-uring@archiver.kernel.org>; Thu, 23 Apr 2020 14:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BA75214AF
	for <io-uring@archiver.kernel.org>; Thu, 23 Apr 2020 14:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqC7+rUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgDWOil (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 23 Apr 2020 10:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726450AbgDWOil (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 23 Apr 2020 10:38:41 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655C2C08E934
        for <io-uring@vger.kernel.org>; Thu, 23 Apr 2020 07:38:40 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id q2so2974394qvd.1
        for <io-uring@vger.kernel.org>; Thu, 23 Apr 2020 07:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=ShE9h45lB7qfdOC7MevQYHFi5dz14rq19nurv6tlsgo=;
        b=OqC7+rUU9a8M1sgD3fkosCs+FPcCWWrYGAd9iajTKvODmXUa3a5ackFGc1WK8EG5/g
         CehUAeOmwyPqFFQOMJ8rSzzyBp0A5lMm+/T4mHOru1psxetCoEfZlHbWKnCJ7cFFCK0b
         WuStVHK80vKZDyXI03vwVLXCErzECgGXmg2lJ/Drilz2Ao5jNCNHNgdz9BkX25TaXG3S
         paieYb7vzGFBmFirHNqs2+3A1Qy9Ck8f+ZEcKgmJNx5rXtLWuf5qlj4hHT2/PX5w/2j3
         qPYb1YbYRW+dA084BHIrc0DBcirbKNEKn4hhlmOvmBFSOmungJOofK8iDya9Ho5TOm5W
         8R1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ShE9h45lB7qfdOC7MevQYHFi5dz14rq19nurv6tlsgo=;
        b=FSZRNmfCwfzBUN4SJVsZQwLUJNJHAclCmnaFNY9L3Thw2z2mw6HqHkOxka18ySDdAj
         NCaFMF4Y1reHZ/UWqxnz58+pSpQdGfowCN83yUloEYVEHXoWcyYEbHVkhpAogB1wQ1o0
         o1oUioEcLbiCOrhozj2LTCbCGnP9wL9QYvvKvJKNL96/Rt510ks0tJHE8IUqvEF1JLi1
         GohiEQys6PbKSbjOeRazb757+g5CnnTyJiSVUoOCLj002ShJiwS0mvraL2t3q7y+bSV0
         SEM89j6l/wQPYgJ1tNYq3HVDic+Z60h+TnqkQGRbMpN/4/aiwLKFF7k6bQ0GLEaleWdf
         eKWg==
X-Gm-Message-State: AGi0Pub1nJVnHLqUModmUeASrX3PfiskPne2mtWmIGqSm5CdwB8pIxrd
        RfBdlgRG0yXgKiQ380LrJw7kVJvi3sWQAbCo0ZNfn04nFaY=
X-Google-Smtp-Source: APiQypJahCJxj+W1pKL8Nz6BOiVgBLIG4cm/CP5TYNHSit/UlO0mi8JGALtL5mESguAoxXRR29VgQwobf0/z8OJwRx0=
X-Received: by 2002:ad4:45f0:: with SMTP id q16mr4533331qvu.89.1587652719368;
 Thu, 23 Apr 2020 07:38:39 -0700 (PDT)
MIME-Version: 1.0
From:   Daniel H <hodges.daniel.scott@gmail.com>
Date:   Thu, 23 Apr 2020 10:38:28 -0400
Message-ID: <CAAUBs7+nziOz02XPaBsP_6-4wgT3fV+VzAzgwOGAkui3K=czRQ@mail.gmail.com>
Subject: Ring Setup Question
To:     io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

I'm working on a implementation of for the Go language and I've been running
into a failed test case that I can't understand. The test is setup in the
following manner; first write some data into a file and then read the data
back using the io_uring. The simple test case of reading back all the bytes
passes. However, when using two reads to read half the amount of data what I
observe is the second time the ring is entered (after the first read completes
successfully) is that the resulting CQE doesn't match the UserData. The test
uses a monotonically increasing value for UserData and the following debug
messages show that each entry has a unique UserData field. I'm guessing
the ring is setup properly, however I'm not sure how to proceed.

=== RUN   TestRingFileReadWriterRead
pre enter
sq head: 0 tail: 1
sq entries: [{Opcode:22 Flags:2 Ioprio:0 Fd:8 Offset:0
Addr:824634362160 Len:7 UFlags:0 UserData:1 Anon0:[0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0]} {Opcode:0 Flags:0 Ioprio:0 Fd:0 Offset:0
Addr:0 Len:0 UFlags:0 UserData:0 Anon0:[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0]}]
cq head: 0 tail: 0
cq entries: [{UserData:0 Res:0 Flags:0} {UserData:0 Res:0 Flags:0}]
enter complete
sq head: 1 tail: 1
sq entries: [{Opcode:22 Flags:2 Ioprio:0 Fd:8 Offset:0
Addr:824634362160 Len:7 UFlags:0 UserData:1 Anon0:[0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0]} {Opcode:0 Flags:0 Ioprio:0 Fd:0 Offset:0
Addr:0 Len:0 UFlags:0 UserData:0 Anon0:[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0]}]
cq head: 1 tail: 1
cq entries: [{UserData:1 Res:7 Flags:0} {UserData:0 Res:0 Flags:0}]
pre enter
sq head: 1 tail: 2
sq entries: [{Opcode:22 Flags:2 Ioprio:0 Fd:8 Offset:0
Addr:824634362160 Len:7 UFlags:0 UserData:1 Anon0:[0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0]} {Opcode:22 Flags:2 Ioprio:0 Fd:8
Offset:7 Addr:824634363240 Len:7 UFlags:0 UserData:2 Anon0:[0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]}]
cq head: 1 tail: 1
cq entries: [{UserData:1 Res:7 Flags:0} {UserData:0 Res:0 Flags:0}]
enter complete
sq head: 2 tail: 2
sq entries: [{Opcode:22 Flags:2 Ioprio:0 Fd:8 Offset:0
Addr:824634362160 Len:7 UFlags:0 UserData:1 Anon0:[0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0]} {Opcode:22 Flags:2 Ioprio:0 Fd:8
Offset:7 Addr:824634363240 Len:7 UFlags:0 UserData
:2 Anon0:[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]}]
cq head: 1 tail: 2
cq entries: [{UserData:1 Res:7 Flags:0} {UserData:1 Res:7 Flags:0}]
