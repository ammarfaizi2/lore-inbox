Return-Path: <linux-kernel-owner+w=401wt.eu-S932538AbXAGN13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932538AbXAGN13 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 08:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbXAGN12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 08:27:28 -0500
Received: from gate.crashing.org ([63.228.1.57]:36550 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932538AbXAGN12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 08:27:28 -0500
In-Reply-To: <20070106221947.8e01d404.randy.dunlap@oracle.com>
References: <20070106221947.8e01d404.randy.dunlap@oracle.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <33e707f92df6b89a1c22f337f230cf32@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] math-emu/setcc: avoid gcc extension
Date: Sun, 7 Jan 2007 14:27:32 +0100
To: Randy Dunlap <randy.dunlap@oracle.com>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> setcc() in math-emu is written as a gcc extension statement expression
> macro that returns a value.  However, it's not used that way and it's
> not needed like that, so just make it a do-while non-extension macro
> so that we don't use an extension when it's not needed.

Looks fine, except

> -#define setcc(cc) ({ \
> +#define setcc(cc) do { \
>    partial_status &= ~(SW_C0|SW_C1|SW_C2|SW_C3); \
> -  partial_status |= (cc) & (SW_C0|SW_C1|SW_C2|SW_C3); })
> +  partial_status |= (cc) & (SW_C0|SW_C1|SW_C2|SW_C3); } \
> +	while (0)

closing brace on the "while" line, please.


Segher

