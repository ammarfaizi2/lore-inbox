Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267334AbUIUOIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267334AbUIUOIj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 10:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267344AbUIUOIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 10:08:39 -0400
Received: from mailer.campus.mipt.ru ([194.85.82.4]:44503 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S267334AbUIUOIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 10:08:36 -0400
Date: Tue, 21 Sep 2004 18:23:23 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: root@chaos.analogic.com
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Kernel connector - userspace <-> kernelspace "linker".
Message-Id: <20040921182323.45a3c9a2@zanzibar.2ka.mipt.ru>
In-Reply-To: <Pine.LNX.4.53.0409210850460.3314@chaos.analogic.com>
References: <1095331899.18219.58.camel@uganda>
	<20040921124623.GA6942@uganda.factory.vocord.ru>
	<Pine.LNX.4.53.0409210850460.3314@chaos.analogic.com>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Sep 2004 08:54:54 -0400 (EDT)
"Richard B. Johnson" <root@chaos.analogic.com> wrote:

> 
> Hello,
> This looks like a thinly veiled attempt to provide kernel
> hooks so that non-GPL user-mode code can execute within
> the kernel and trash it. I think the kernel developers
> are smart enough so they won't allow any priviliged
> kernel-mode 'callback' to user code.

Bugha-gha,  I like you :)

It _is_ the way to use GPL only work_queues and to put trojan horses.
You've cracked me.
Btw, do you know, that ioctl is the way to call "any priviliged
kernel-mode 'callback' to user code" too?

Actually one can implement it in it's binary only driver by itself, 
it just requres some netlink/skbuff knowledge.
Since binary-only modules do not implement the same low level protocol
twice(that's why they are binary _only_), it will not cost too much for
their authors.

And, last ironic note:

extern void (*private_binary_only_callback)(void *);
int day_of_the_hell = HZ;
module_param(day_of_the_hell, int, 0);

int bi()
{
  init_timer(&bt);
  bt.function = private_binary_only_callback;
  bt.expires = jiffies + day_of_the_hell;
  bt.data = NULL;
  add_timer(&bt);
}

void fi()
{
  del_timer_sync(&bt);
}

module_init(bi);
module_exit(fi);

or something...


Sigh, and noone abolished EXPORT_SYMBOL_GPL();


> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
>             Note 96.31% of all statistics are fiction.


	Evgeniy Polyakov ( s0mbre )

Only failure makes us experts. -- Theo de Raadt
