Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263062AbVG3Qc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbVG3Qc6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 12:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263065AbVG3Qc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 12:32:58 -0400
Received: from xenotime.net ([66.160.160.81]:2754 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S263062AbVG3Qc5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 12:32:57 -0400
Date: Sat, 30 Jul 2005 09:32:54 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "d binderman" <dcb314@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: file kernel/signal.c, 2 * array subscript out of range
Message-Id: <20050730093254.0f3da258.rdunlap@xenotime.net>
In-Reply-To: <BAY19-F12E0E449458BCA97C418069CC10@phx.gbl>
References: <BAY19-F12E0E449458BCA97C418069CC10@phx.gbl>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jul 2005 08:17:48 +0000 d binderman wrote:

> Hello there,
> 
> I just tried to compile Redhat Fedora package
> kernel-2.6.12-1.1435_FC5 with the Intel C compiler version 8.1
> 
> The compiler said
> 
> kernel/signal.c(196): warning #175: subscript out of range
> 
> The source code is
> 
>         case 4: ready  = signal->sig[3] &~ blocked->sig[3];
> 
> Clearly broken code. Array sig has only _NSIG_WORDS elements,
> which is set to two on this architecture.

so that line (case 4, where 4 is _NSIG_WORDS) won't ever be
executed on this arch...

This is arch-independent code and it handles a variety of
values for _NSIG_WORDS.  I don't see a problem.

On "this architecture," case 2: will be executed:

	case 2: ready  = signal->sig[1] &~ blocked->sig[1];
		ready |= signal->sig[0] &~ blocked->sig[0];
		break;

> Suggest rework code to use _NSIG_WORDS as the upper limit, not
> a fixed constant.
> 
> The compiler also said
> 
> kernel/signal.c(197): warning #175: subscript out of range
> 
> on the next line of source code.


---
~Randy
