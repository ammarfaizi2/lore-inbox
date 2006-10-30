Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030526AbWJ3Jes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030526AbWJ3Jes (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 04:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965499AbWJ3Jes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 04:34:48 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:11651 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S965488AbWJ3Jer (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 04:34:47 -0500
Date: Mon, 30 Oct 2006 10:33:18 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Compile-time check re world-writeable module params
In-Reply-To: <20061029225804.GB9197@martell.zuzino.mipt.ru>
Message-ID: <Pine.LNX.4.61.0610301030550.8678@yvahk01.tjqt.qr>
References: <20061029225804.GB9197@martell.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>One of mistakes module_param() user can make is to supply default value
>of module parameter as the last argument. module_param() accepts
>permissions instead. If default value is, say, 3 (-------wx), parameter
>becomes world-writeable.
>
>First version of this check (only "& 2" part) directly caught 4 out of 7
>places during my last grep.

It could probably do "& 0013" or "& ~664", because -x seems quite 
useless in module parameters. That would also catch perm<0 and 
perm>0777.

> #define __module_param_call(prefix, name, set, get, arg, perm)		\
>+	/* Default value instead of permissions? */			\
>+	static int __param_perm_check_##name __attribute__((unused)) =	\
>+	BUILD_BUG_ON_ZERO((perm) < 0 || (perm) > 0777 || ((perm) & 2));	\
> 	static char __param_str_##name[] = prefix #name;		\
> 	static struct kernel_param const __param_##name			\
> 	__attribute_used__						\


	-`J'
-- 
