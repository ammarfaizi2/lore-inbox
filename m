Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285288AbRLSNt4>; Wed, 19 Dec 2001 08:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285291AbRLSNth>; Wed, 19 Dec 2001 08:49:37 -0500
Received: from sushi.toad.net ([162.33.130.105]:4740 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S285288AbRLSNtQ>;
	Wed, 19 Dec 2001 08:49:16 -0500
Subject: Re: APM driver patch summary
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <1008737165.1155.0.camel@thanatos>
In-Reply-To: <1008737165.1155.0.camel@thanatos>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 19 Dec 2001 08:49:20 -0500
Message-Id: <1008769762.1156.18.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I'm not having any problems with the latest "notify
listeners before drivers" patch, and it does fix the problems
I was having.

I'm not sure that this is an appropriate change for 2.4,
but the decision about whether to put it in is up to Stephen.
In the meantime I will try to keep the patch up to date as
2.4 kernels are released.  Definitely it should go into 2.5
though. (The idle fixes, on the other hand, should go into
2.4.)

I've just spent a couple of hours auditing the code and I
haven't found any other problems ( ... not that that proves
anything).  One little worry: apm_event_handler() seems to
assume that it is called once per second, and that it will
therefore set APM_STATE_BUSY once every four seconds, as the
spec says it should.  In fact it gets called a lot more often
than that, as this bit of syslog shows:
------------------------------------------------------
Dec 18 18:00:20 thanatos apmd[266]: apmd_call_proxy: executing:
'/etc/apm/apmd_proxy' 'suspend'
Dec 18 18:00:20 thanatos kernel: apm: setting state busy
Dec 18 18:00:21 thanatos last message repeated 7 times
------------------------------------------------------
However, the APM spec does not put a ceiling on how often
the state is set to BUSY, so it should be okay.

--
Thomas

