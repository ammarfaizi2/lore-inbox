Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965606AbVKHAd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965606AbVKHAd0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 19:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965636AbVKHAd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 19:33:26 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:45293 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965606AbVKHAdZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 19:33:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s7ZsHEFjgFe2fJ4/1CCetBbiekQZ7TDSLp/hmKwdRxrnvP7K0I8KVCjv2c2X+a5jX0S1mIhYB62goVUm/aDTSVjWC6yIloLOl87DZH0w4GnMfrXnuelWYOXpFRQwA+l4WXdI4MLx/MCejkZWGP6CXT0WOztOCbQ1AlGUBznDrnE=
Message-ID: <7e77d27c0511071633k4a44b573o@mail.gmail.com>
Date: Tue, 8 Nov 2005 08:33:24 +0800
From: Yan Zheng <yzcorp@gmail.com>
Subject: Re: [PATCH][MCAST]Clear MAF_GSQUERY flag when process MLDv1 general query messages.
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <OF7136C7EC.A2BD07E5-ON882570B2.00768CF6-882570B2.0077AB0D@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <7e77d27c0511070646o7b8686aes@mail.gmail.com>
	 <OF7136C7EC.A2BD07E5-ON882570B2.00768CF6-882570B2.0077AB0D@us.ibm.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>         Do you have a test case that demonstrates this? It appears to
> me that an MLDv2 general query doesn't execute that code (short circuited
> above) and an MLDv1 general query (what that code is handling) will
> have a timer expiring before switching back to MLDv2 mode (so it'll send
> a v1 report, without any sources). Unless I'm missing something, I can't
> see any way for the scenario you've described to happen.
>         That said, I also can't see anything it would hurt, so I don't
> object,
> but it looks unnecessary to me.
>
>                                                         +-DLS
>
>

>MLDv2 general query doesn't execute that code
Yes, MLDv2 general query also leave that bit unchanged. In MLDv1
compatibility mode, igmp6_timer_handler(...) uses igmp6_send(...) to
send report, it leaves that bit unchanged too. So when switching back
to MLDv2 mode, MAF_GSQUERY flag set long time ago may have effect on
the report .

>That said, I also can't see anything it would hurt
I agree with you. it hurts nothing but a report.

By the way. May I ask a question.
Do you agree my change on is_in(...)?  That is check include/exclude
count when type is MLD2_MODE_IS_INCLUDE or MLD2_MODE_IS_EXCLUDE.
(especially for MLD2_MODE_IS_EXCLUDE)

Regards
