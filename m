Return-Path: <linux-kernel-owner+willy=40w.ods.org-S319486AbUKBEti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S319486AbUKBEti (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 23:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S378121AbUKAWnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 17:43:09 -0500
Received: from twinlark.arctic.org ([168.75.98.6]:30102 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S263501AbUKAUog
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 15:44:36 -0500
Date: Mon, 1 Nov 2004 12:44:35 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Marc Bevand <bevand_m@epita.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: [rc4-amd64] RC4 optimized for AMD64
In-Reply-To: <cm4moc$c7t$1@sea.gmane.org>
Message-ID: <Pine.LNX.4.61.0411011233203.8483@twinlark.arctic.org>
References: <cm4moc$c7t$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Nov 2004, Marc Bevand wrote:

> I have just published a small paper about optimizing RC4 for
> AMD64 (x86-64). A working implementation is also provided:
> 
>   http://epita.fr/~bevand_m/papers/rc4-amd64.html
> 
> Kernel people may be interested given the fact that Linux
> already implements RC4.

you've made a non-portable flags assumption:

>       dec     %r11b
>       ror     $8,             %r8             # (ror does not change ZF)
>       jnz 1b

the contents of ZF are undefined after a rotation... most importantly they 
differ between p4 (ZF is set according to result) and k8 (ZF unchanged).

do you really measure a perf improvement from this assumption?  note that 
p4 would prefer "sub $1, %r11b" here instead of dec... but the difference 
is likely minimal.

-dean
