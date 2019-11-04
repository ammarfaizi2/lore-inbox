Return-Path: <SRS0=koBJ=Y4=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880B1CA9EC9
	for <io-uring@archiver.kernel.org>; Mon,  4 Nov 2019 21:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5509A20717
	for <io-uring@archiver.kernel.org>; Mon,  4 Nov 2019 21:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572902508;
	bh=PPNV6ZLzLJAVrCYAFcfdM1p8XpGtzJ1/IrjqU0K93hM=;
	h=Date:From:To:Subject:List-ID:From;
	b=B78i5ilrl1gnLYfsYwMkOYgwftxztbXtUGJyIQCtKmHyyAZH3r4n2h9mV6aSwyQFL
	 RFKrVcizkk78p4y7I928WUIMTfK9YlC0KuCFVHJ2DgW+TbLD1PHO2oZ4fvP+Qb45IH
	 eYv6bLPrhQaAcHyhcAZz6iegU8rZ8ZCdtz8oeXJw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbfKDVVs (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:21:48 -0500
Received: from mail-qk1-f174.google.com ([209.85.222.174]:44093 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbfKDVVs (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 4 Nov 2019 16:21:48 -0500
Received: by mail-qk1-f174.google.com with SMTP id m16so18768204qki.11
        for <io-uring@vger.kernel.org>; Mon, 04 Nov 2019 13:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=PPNV6ZLzLJAVrCYAFcfdM1p8XpGtzJ1/IrjqU0K93hM=;
        b=D+U8ify8UAMhTSVZGOnCn7tRW/suv0Bk35Q24/q44WtoX2sFoiyg04DRGfOxL8oKo8
         gnetcUVrfr1ujMjVr+geGy7js+h9cp3FCYYQahXmNAGiSICiqVJ5hrCdhNSlZMPlci5P
         V/ue8gW61+GscMj2cKmaR92AQb9WbaoHMafmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=PPNV6ZLzLJAVrCYAFcfdM1p8XpGtzJ1/IrjqU0K93hM=;
        b=Rnwbn8nzZIC7PKYyB6FOc6Rj2/Emm01SdFZo4fPUaYFXgy1HFlHAVNrc1Vl2IAM4G2
         hdbnSGlXCCqDFojpXMemcYkQKeWzNEp1F5ChpNYLqyxphRmO0BEMS3FQDDLThzRHQUIH
         84PBXqnss8WNDXyjehAyC8sOXxdAreLSLD6cu7MnUbGFYSjQ2upswh46fyjijvA1VKSR
         tmXqyNwnt7N9FCBN3O+LCH7h13Owi7ilxI9Brh+uxu6PW57EjtRP5BLhlyQ1/u8nokgP
         QdC096iBPGX6BDv3PkaPsOD4TfG2e7A7oYTuRsfjbqDkRRae/Nu6IRSA2AILdAAlo1VN
         vuLw==
X-Gm-Message-State: APjAAAWzu9tJY9IpRnS/HmryufpweZl5c9SNf/Vgf/jKlVbor38xEXur
        2nowBN89BaAHGRivR+fbHTKkVSSheoM=
X-Google-Smtp-Source: APXvYqwdN0s0zz3e9l8rSOreuWf96ItWRTUm0q3TFAD48RIE/ronb0eORItmHhMOm4B2Gc1S1bCpVw==
X-Received: by 2002:a37:4e03:: with SMTP id c3mr3859848qkb.222.1572902506754;
        Mon, 04 Nov 2019 13:21:46 -0800 (PST)
Received: from chatter.i7.local (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id u9sm9802441qke.50.2019.11.04.13.21.46
        for <io-uring@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 13:21:46 -0800 (PST)
Date:   Mon, 4 Nov 2019 16:21:44 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     io-uring@vger.kernel.org
Subject: This list is now archived on lore.kernel.org
Message-ID: <20191104212144.sszfmbbxdddxt765@chatter.i7.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Hello:

This list is now archived on lore.kernel.org:
https://lore.kernel.org/io-uring/

Best regards,
-K
