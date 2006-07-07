Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWGGKJD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWGGKJD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 06:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbWGGKJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 06:09:03 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:45753 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932099AbWGGKJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 06:09:01 -0400
Subject: Re: Enabling message queue in 2.6.10 kernel
From: Arjan van de Ven <arjan@infradead.org>
To: chinmaya@innomedia.soft.net
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <44AE3188.6000304@innomedia.soft.net>
References: <44AE3188.6000304@innomedia.soft.net>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 12:08:58 +0200
Message-Id: <1152266938.3111.45.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> 
> But the out put messages in # dmesg <enter> is like this
> 
> Start send message
> Send ret = -14
> Err: sys_msgsnd
> Start recv message
> Recv ret = -42
> Err: sys_msgrcv
> Stop Kernel Thread
> 
> Is there any thing I am missing. Please help soon.

you're missing that you're calling functions which expect a userspace
pointer, but with a kernel space pointer. You really shouldn't do that,
and in fact it doesn't work the way you did it. (you'd need to call
set_fs() and friends first, but if you're not really careful you open
security holes that way)

Can you explain why you'd want to do this from kernel space in the first
place? It's not unlikely that it's the wrong approach....

Greetings,
   Arjan van de Ven

