Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261769AbUKLTl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbUKLTl7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 14:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbUKLTl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 14:41:59 -0500
Received: from brown.brainfood.com ([146.82.138.61]:11946 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S261769AbUKLTlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 14:41:45 -0500
Date: Fri, 12 Nov 2004 13:41:23 -0600 (CST)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: yiding_wang@agilent.com
cc: rddunlap@osdl.org, arjan@infradead.org, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au, akpm@osdl.org
Subject: RE: [PATCH] handle quoted module parameters
In-Reply-To: <08A354A3A9CCA24F9EE9BE13600CFBC50F3AF0@wcosmb07.cos.agilent.com>
Message-ID: <Pine.LNX.4.58.0411121339280.1276@gradall.private.brainfood.com>
References: <08A354A3A9CCA24F9EE9BE13600CFBC50F3AF0@wcosmb07.cos.agilent.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Nov 2004,  wrote:

> Hello Randy,
>
> Thanks for your two responses!
>
> Based on your patch, the format of argument will be changed from standard format before:
> Used to be:
> modprm1=first,ext modprm2=second,ext modprm3="third1,ext third2,ext"
> where the quotation in modprm3 represents the whole string, including space, to be the value of third parameter modprm3.
>
> Now the patch changes modprm3 to "modprm3=third1,ext third2,ext" which equivalent to putting quotation mark on normal parameter define "modprm1=first,ext". Do you think linux community will take that change?
>
> Another question is the parameter length is not limited in 2.4.x kernel. Why this is restricted under 2.6.x. (param_set_charp())?

Er, no, that's a wrong assumption.

Quoting like this is handled by the shell.  It tells it how to parse the
single cmdline string, into separate parts.

There is *no* difference between:

foo="111 222 333"\ 444' 555'

and

foo='111 222 333 444 555'

and

foo="111 222 333 444 555'

