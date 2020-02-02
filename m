Return-Path: <SRS0=nwdj=3W=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45D4C35240
	for <io-uring@archiver.kernel.org>; Sun,  2 Feb 2020 07:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA13206D3
	for <io-uring@archiver.kernel.org>; Sun,  2 Feb 2020 07:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=anarazel.de header.i=@anarazel.de header.b="DtWbIW/M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q7M5phg+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgBBHgo (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 2 Feb 2020 02:36:44 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:42667 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726483AbgBBHgo (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sun, 2 Feb 2020 02:36:44 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 262A421B8C;
        Sun,  2 Feb 2020 02:36:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 02 Feb 2020 02:36:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=WG7Xi3nFcxRtHMKdxrLZsh+SwUJ
        o7XMhmUxL+AnVWB4=; b=DtWbIW/MRMqeS/7AD1OO7OdTZ/fn049hdh1FwaXTQuQ
        L58iE0LzcQ0jDwHjGMeYARGFmMEtYILJotxozqAzDZVCJB3fTO8OTGRYz2VfvzgI
        Ey1fJsYgkttFzNP6QFnhSuHct2rRIo1AJ2SXtk5hwcFwJQmOlA2Y459CDN9Gt4hY
        y936efRsba3OuCyph6r5BuMWRFED1VAWvvBka9LkLT5BWEO0LFdDWezwHDP9vtrw
        NMiqI4ixTLwY7speN3LLYrpo6bgB/JtzaXsuQ4EJDDZQEHAbyv4SbuclyCVrt2S/
        IMH+Kxu0KMxhNzm/I2cnKN0BkFIpVHXyeBRnXYPaHzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=WG7Xi3
        nFcxRtHMKdxrLZsh+SwUJo7XMhmUxL+AnVWB4=; b=q7M5phg+mL/mlu0OXQJuSB
        A1PPDo1AOoC98lHWCiXcLcy9EYgetYXUdRZLdrchz0stq43Yxc0839Nu+nbUVjKa
        MctOUe0+tfMe/pcXcCs8lCR89PlVuYqHWWZP6JJRXgIgTIPMYJk6afEhWo+f/qe9
        o5L8SuCfn9qYM8htaVu+Y+8cEAJhjPnbkM5VowSaTieQyQZXp795cRfnqOnYqI/I
        zxORm06zOwAigFVPVX4R0ENggwTc9VvZ2q4DsnwPJva43J7vgp7JM1q/DWqa8Uwy
        damY3uJx7Ug5HYSXAvuylP8sN+bJssNeTUFSUzQIOa1JapXvAKsSBdJk0wYp1fYw
        ==
X-ME-Sender: <xms:Cnw2XnbfLQ4cUraxhnEe7Af6dontb_zMY2a5kLPUVPFEv5hKLZUW4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrgeeggdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehnughrvghs
    ucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecukfhppedvud
    dvrdejiedrvdehfedrudejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegrnhgurhgvshesrghnrghrrgiivghlrdguvg
X-ME-Proxy: <xmx:Cnw2XnoKwpLafqSwkHzWqJz9Gt0HxOIsgW2Us1Ia040Im0hDIjz4yA>
    <xmx:Cnw2Xi1lo4OFUv99OUbPCM83pQfpc9Us_73q0xrgDgbRVkcJbSCU4g>
    <xmx:Cnw2Xkpsrwl7-CQlQ5u0TENA_vxpaX3clT5ELa_8IMscY7JXs-qhLg>
    <xmx:C3w2XoL2VyuCJTAHbIcyIdLYYOuzfEJQrX-vzU1qbPTDjz-8MKjxVw>
Received: from intern.anarazel.de (unknown [212.76.253.171])
        by mail.messagingengine.com (Postfix) with ESMTPA id 98ABF328005A;
        Sun,  2 Feb 2020 02:36:42 -0500 (EST)
Date:   Sat, 1 Feb 2020 23:36:41 -0800
From:   Andres Freund <andres@anarazel.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org
Subject: Re: What does IOSQE_IO_[HARD]LINK actually mean?
Message-ID: <20200202073641.ewjf6yhykrfjde76@alap3.anarazel.de>
References: <20200201091839.eji7fwudvozr3deb@alap3.anarazel.de>
 <8df72d47-f3ef-d7b8-d1f7-da58b2d58a7e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8df72d47-f3ef-d7b8-d1f7-da58b2d58a7e@kernel.dk>
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 2020-02-01 11:06:28 -0700, Jens Axboe wrote:
> I won't touch on the rest since Pavel already did, but I did expand the
> explanation of when a normal link will sever, and how:

Awesome.
