Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWAIMpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWAIMpT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 07:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbWAIMpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 07:45:19 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:46476 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S932071AbWAIMpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 07:45:18 -0500
Date: Mon, 9 Jan 2006 10:44:45 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: arjan@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slab: Adds missing kmalloc() checks.
Message-Id: <20060109104445.22dde5d5.lcapitulino@mandriva.com.br>
In-Reply-To: <1136599971.7163.3.camel@localhost>
References: <20060106131246.0b9fde8c.lcapitulino@mandriva.com.br>
	<1136561087.2940.39.camel@laptopd505.fenrus.org>
	<20060106133051.367f2d9b.lcapitulino@mandriva.com.br>
	<1136599971.7163.3.camel@localhost>
Organization: Mandriva
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.9; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi Pekka,

On Sat, 07 Jan 2006 04:12:50 +0200
Pekka Enberg <penberg@cs.helsinki.fi> wrote:

| Hi,
| 
| On Fri, 2006-01-06 at 13:12 -0200, Luiz Fernando Capitulino wrote:
| > | >  Adds two missing kmalloc() checks in kmem_cache_init(). Note that if the
| > | > allocation fails, there is nothing to do, so we panic();
| 
| On Fri, 06 Jan 2006 16:24:47 +0100
| Arjan van de Ven <arjan@infradead.org> wrote:
| > | ok so what good does this do? if you die this early.. you are in deeper
| > | problems, and can't boot. while this makes the code bigger...
| 
| On Fri, 2006-01-06 at 13:30 -0200, Luiz Fernando Capitulino wrote:
| >  Well, you'll get a panic with a message saying you have no memory to
| > boot, instead of a OOPS with a kernel NULL pointer derefecence, which
| > will make you look for a bug.
| 
| The code is in init section so I don't think size is an issue. A plain
| BUG_ON would be better though as it can be disabled by the embedded
| folk.

 Okay, but a quick look at the initialization functions called from
'init/main.c' shows that some of them does the same thing (test an
error condition, and panic() if necessary).

 Should they be changed to call BUG_ON() instead?

PS: I'm asking becuase I also found several untested returns, I'll
send patches for they too.

-- 
Luiz Fernando N. Capitulino
