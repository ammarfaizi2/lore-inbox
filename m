Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267659AbUJGSZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267659AbUJGSZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 14:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267585AbUJGSW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 14:22:56 -0400
Received: from science.horizon.com ([192.35.100.1]:44844 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S267474AbUJGSQ7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 14:16:59 -0400
Date: 7 Oct 2004 18:16:58 -0000
Message-ID: <20041007181658.2469.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org, mark@mark.mielke.cc
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There is one claim I'd like to question - the claim that select()
> would be slowed down unnecessarily, even if the behaviour was changed
> for both O_NONBLOCK enabled. Isn't it more expensive to allow the
> application to be woken up, and poll using read(), than to just do a
> quick check in the kernel and not tell the application there is data,
> when there really isn't?

It depends on how often the second check fails.

The 99.9+% case is that the checksum is good, and in that case, you have
to pay the wakeup cost anyway.  (So sending bad-checksum packets isn't
even a useful DoS; good-checksum packets still steal more cycles.)

You only get the benefit of saving the wakeup if the check fails.
But every time it passes, you get the benefit of making the check cheaper.
You have to multiply by the relative probabilities to see the net effect.

For something like UDP checksums on packets which have already passed the
ethernet checksum, that's a pretty overwhelming ratio.
