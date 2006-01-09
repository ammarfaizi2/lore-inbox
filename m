Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965045AbWAIAIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045AbWAIAIQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 19:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965356AbWAIAIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 19:08:16 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:51330
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965045AbWAIAIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 19:08:16 -0500
Date: Sun, 08 Jan 2006 16:08:02 -0800 (PST)
Message-Id: <20060108.160802.103497642.davem@davemloft.net>
To: davidel@xmailserver.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] POLLHUP tinkering ...
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.63.0601081528170.6925@localhost.localdomain>
References: <Pine.LNX.4.63.0601081528170.6925@localhost.localdomain>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davide Libenzi <davidel@xmailserver.org>
Date: Sun, 8 Jan 2006 16:02:10 -0800 (PST)

> But if and hangup happened with some data (data + FIN), they won't
> receive any more events for the Linux poll subsystem (and epoll,
> when using the event triggered interface), so they are forced to
> issue an extra read() after the loop to detect the EOF
> condition. Besides from the extra read() overhead, the code does not
> come exactly pretty.

The extra last read is always necessary, it's an error synchronization
barrier.  Did you know that?

If a partial read or write hits an error, the successful amount of
bytes read or written before the error occurred is returned.  Then any
subsequent read or write will report the error immediately.
