Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbWEXUg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbWEXUg4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 16:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbWEXUg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 16:36:56 -0400
Received: from hera.kernel.org ([140.211.167.34]:39057 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932370AbWEXUg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 16:36:56 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH (take #2)] i386: kill CONFIG_REGPARM completely
Date: Wed, 24 May 2006 13:36:50 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e52g52$v80$1@terminus.zytor.com>
References: <20060520025353.GE9486@taniwha.stupidest.org> <20060520212049.GA11180@taniwha.stupidest.org> <305c16960605201500s6153e1doad87e4b85f15b53f@mail.gmail.com> <Pine.LNX.4.61.0605220739580.26623@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1148503010 32001 127.0.0.1 (24 May 2006 20:36:50 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Wed, 24 May 2006 20:36:50 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.61.0605220739580.26623@chaos.analogic.com>
By author:    "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
In newsgroup: linux.dev.kernel
> 
> On ix86 there are not enough registers to pass a significant parameter
> list all in registers! Like when you are printk()ing a dotted-quad IP
> address, etc. Registers ESI, EDI, and EBX are precious, that leaves
> EAX, ECX, EDX and possibly EBP for only 4 parameters. You need 5
> for the dotted quad IP address. If the compiler were to use the
> precious registers, the contents need to be saved on the stack.
> That negates any advantage to passing parameters in registers.
> 
> This means that REGPARM will always remain a "hint" to the compiler,
> not some absolute order.
> 

Bullshit.

-mregparm=N is an absolute order.  On i386 it has the semantics of
passing the first N dword-sized non-varadic arguments in registers
%eax, %edx, and %ecx (in that order).  The rest are passed on the
stack; that is true for any ABI.

printk() is varadic; the only argument which will be put in a register
is the formatting string (which goes into %eax).

	-hpa


