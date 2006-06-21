Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751901AbWFUBEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901AbWFUBEJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 21:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751900AbWFUBEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 21:04:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44172 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751901AbWFUBEH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 21:04:07 -0400
Date: Tue, 20 Jun 2006 18:03:51 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: David Miller <davem@davemloft.net>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org, dwmw2@infradead.org
Subject: Re: cfq-iosched.c:RB_CLEAR_COLOR
In-Reply-To: <20060620.173434.35660839.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0606201800320.5498@g5.osdl.org>
References: <20060620.173434.35660839.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Jun 2006, David Miller wrote:
> 
> That got removed in Linus's tree today, yet cfq-iosched.c
> still contains a reference to it.
> 
> The culprit changeset seems to be 3db3a44.
> 
> There were two explicit calls in the cfq-iosched.c file
> to RB_CLEAR_COLOR, only the one in cfq_del_crq_rb() got
> removed so the build fails.

I think the right fix is to just remove the RB_CLEAR_COLOR() call, since 
the memset will set everything to 0/NULL, which should be the correct 
initialization these days anyway.

David (the other one - dwmw2), pls confirm?

		Linus	
