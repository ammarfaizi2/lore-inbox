Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264280AbTKZSkO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 13:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264281AbTKZSkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 13:40:14 -0500
Received: from mailer2.psc.edu ([128.182.66.106]:55272 "EHLO mailer2.psc.edu")
	by vger.kernel.org with ESMTP id S264280AbTKZSkJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 13:40:09 -0500
Date: Wed, 26 Nov 2003 13:39:54 -0500 (EST)
From: John Heffner <jheffner@psc.edu>
To: Yogesh Swami <prem_yogesh@sbcglobal.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux TCP state machine is broken?
In-Reply-To: <20031126175304.42296.qmail@web80502.mail.yahoo.com>
Message-ID: <Pine.NEB.4.33.0311261337070.25115-100000@dexter.psc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Nov 2003, Yogesh Swami wrote:

> I think the reason the sender is always in TCP_CA_CWR
> and not in TCP_CA_Open is because in the function
> "tcp_transmit_skb" (tcp_out.c:190), after sending the
> packet to IP-layer, the sender call tcp_enter_cwr() if
> the IP layer did not return any non congestion error.
> I have put the code fragement at the end of the
> e-mail.
>
> I am not clear why a successfuly transmission should
> cause the sender to enter CWR (the only other places
> when tcp_enter_cwr is called are when there is a ICMP
> source quench or when there is ECE bit set for ECN).
>
> If someone could explain this to me, that would be
> great.

It reaches this point if there *is* congestion explicitly reported by the
interface.  It will be in CWR a lot of the time if your local interface is
the bottleneck.

  -John

