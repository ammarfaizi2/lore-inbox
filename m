Return-Path: <SRS0=KKPr=ZF=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDCBC432C3
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 21:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F72B206F0
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 21:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0a2mda0v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfKMVyd (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:54:33 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43892 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfKMVyd (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 13 Nov 2019 16:54:33 -0500
Received: by mail-pg1-f196.google.com with SMTP id l24so2198246pgh.10
        for <io-uring@vger.kernel.org>; Wed, 13 Nov 2019 13:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=9unNiExIi2tQ1XnIF2EKghq/xz12WBIbLWYJ/FLMCRg=;
        b=0a2mda0vKpzBdYZSw0gYdVTGzJ/HOhL1xyKxnLNcNtdd/Qlw95eRd+zls9sA5c+WM/
         L4D2aCz+vAqaOnK8dssc9qJly+E7uQiZGwnHzY8RI6h8JCMpNBIli3xoTKFUVxD9QV0F
         tR5IaFbJlO0YG1cMiugXGX5TjQC+ZkRdOtoHk4b3GqZrDlrO3cjb7Ra5hu5IY/WurVhz
         Py4OSZvnN3VbkSOxJicOIxzjTEc4gFy1QI9SFxRnHu1YLA85rARAOKc3t416P88Djtnn
         xDxZsWTIVzJjjQArytkHJrn2AF8/g1yzaHsutCadlOrd57NWSbPu9S3Xytl5QxMKd/ga
         DWmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=9unNiExIi2tQ1XnIF2EKghq/xz12WBIbLWYJ/FLMCRg=;
        b=gXauMckXusGg/V536m6MPulN3o7DK7kIxAOjNy+miU/WsKBYWkck8vzHaN8iWuisIu
         1dUbtyU+9RuMygU284VMvMev1gGhvAOhFtx/voyIaLplXoaKwG9HvCScJ36Sab7b2ljF
         p2Y52VgGd9SKz/NUF3BrCanh7CT808P/+aCiMeyV1SYd0A1AW9k5pWNT1SiJ1r+rBGwF
         952v145bX3vbI50vFsQYmLhxMEnuCAac8ncjqW6cwo6p/H+OnNFUkQqkRt6TIN6QIzHZ
         U33bfCuJDrQL1eea/jzyDgtfjsN+gNXJ+qtpbBjByP0CixBkJWbCdlvYeK5W1Dd32oqK
         rWaQ==
X-Gm-Message-State: APjAAAX1YMnnEKQgjmpQV5upU2DeSrpePKYza3qtsVxAz0R6onugfMZP
        pDIj5HL7orfHM35BYRpQBfQN3xSqMzo=
X-Google-Smtp-Source: APXvYqzp/bWePWetO8j0Vekg3+3NEzh9coPr+riGuZErRC/Qm0RC44DMHQXelzpaFis0QueOox5c9g==
X-Received: by 2002:aa7:9189:: with SMTP id x9mr7137394pfa.41.1573682072073;
        Wed, 13 Nov 2019 13:54:32 -0800 (PST)
Received: from ?IPv6:2600:380:4b46:8e06:188c:864b:aa3c:f7b? ([2600:380:4b46:8e06:188c:864b:aa3c:f7b])
        by smtp.gmail.com with ESMTPSA id o15sm3472271pjs.24.2019.11.13.13.54.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2019 13:54:31 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Jens Axboe <axboe@kernel.dk>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] io_uring: Fix getting file for timeout
Date:   Wed, 13 Nov 2019 14:54:29 -0700
Message-Id: <22C89598-0237-49ED-B020-9DD01D7EA31E@kernel.dk>
References: <5b145d14-59e8-041e-9b8a-21ec1d71e082@gmail.com>
Cc:     io-uring@vger.kernel.org
In-Reply-To: <5b145d14-59e8-041e-9b8a-21ec1d71e082@gmail.com>
To:     Pavel Begunkov <asml.silence@gmail.com>
X-Mailer: iPhone Mail (17C5038a)
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On Nov 13, 2019, at 2:48 PM, Pavel Begunkov <asml.silence@gmail.com> wrote:
>=20
> =EF=BB=BFOn 14/11/2019 00:37, Jens Axboe wrote:
>>> On 11/13/19 2:33 PM, Jens Axboe wrote:
>>> On 11/13/19 2:11 PM, Pavel Begunkov wrote:
>>>> For timeout requests and bunch of others io_uring tries to grab a file
>>>> with specified fd, which is usually stdin/fd=3D0.
>>>> Update io_op_needs_file()
>>>=20
>>> Good catch, thanks, applied.
>>=20
>> Care to send one asap for 5.4 as well? It'd just be TIMEOUT for that
>> one, but we need it fixed there, too.
>>=20
> Sure, I'll split this into 2 incremental patches then

Just one patch is fine, it=E2=80=99ll be a conflict anyway. So no point in d=
oing two patches for 5.5.=20

