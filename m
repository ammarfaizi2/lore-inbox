Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136165AbREGO6b>; Mon, 7 May 2001 10:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136168AbREGO6W>; Mon, 7 May 2001 10:58:22 -0400
Received: from [64.64.109.142] ([64.64.109.142]:30476 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S136165AbREGO6K>; Mon, 7 May 2001 10:58:10 -0400
Message-ID: <3AF6B7D0.B63FD27C@didntduck.org>
Date: Mon, 07 May 2001 10:57:20 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 page fault handler not interrupt safe
In-Reply-To: <E14wiWH-0003KR-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> (The current -ac fix for the double vmalloc races is below. WP test makes it
> more complex than is nice)

WP test is easy to handle.  Just filter out protection violations and
only take the vmalloc path if the page was not found.

-       if (address >= TASK_SIZE && !(error_code & 4))
+       if (address >= TASK_SIZE && !(error_code & 5))

--

				Brian Gerst
