Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269224AbUISL4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269224AbUISL4J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 07:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269225AbUISL4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 07:56:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:46981 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S269224AbUISLz5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 07:55:57 -0400
X-Authenticated: #1725425
Date: Sun, 19 Sep 2004 14:00:34 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
Cc: benh@kernel.crashing.org, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: udev is too slow creating devices
Message-Id: <20040919140034.2257b342.Ballarin.Marc@gmx.de>
In-Reply-To: <414D42F6.5010609@softhome.net>
References: <414C9003.9070707@softhome.net>
	<1095568704.6545.17.camel@gaston>
	<414D42F6.5010609@softhome.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Sep 2004 10:27:34 +0200
Ihar 'Philips' Filipau <filia@softhome.net> wrote:

>    Okay, okay. Let's spread delays and polling all over numerous init 
> scripts.

Just use /etc/dev.d. No delays, no polling. Everything is event based.

> 
>    You might be ten thousands time right. It is asynchronous process.
> 
>    But please listen to me: you are not going to handle that in _every_ 
> system application which deals with modules.

It  would not be necessary if the module provides some pseudo-device
without device nodes and loading will *always* succeed.
If this is not the case (ie. always), your script is even unsuitable for a
static /dev.
(I know that many scripts make that assumption, including my own.
Nevertheless it is wrong, and has always been wrong.)

> 
>    If there is problem, it doesn't mean we just pass it over. Probably 
> we need to solve it?

How do you want to solve it? We cannot look into the future, so how should
we know which device nodes "modprobe xyz" will or should create?
dev.d is a nice solution. If any device node is created, your script is
called. If it is the node you want, you perform your actions.

Regards
