Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290470AbSAQVQU>; Thu, 17 Jan 2002 16:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290467AbSAQVQO>; Thu, 17 Jan 2002 16:16:14 -0500
Received: from pat.uio.no ([129.240.130.16]:17906 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S290466AbSAQVPL>;
	Thu, 17 Jan 2002 16:15:11 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15431.16084.190369.177282@charged.uio.no>
Date: Thu, 17 Jan 2002 22:15:00 +0100
To: marcelo@conectiva.com.br
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18-pre4 bonding driver...
In-Reply-To: <200201162351.AAA24092@webserver.ithnet.com>
In-Reply-To: <15430.2169.508178.665820@charged.uio.no>
	<200201162351.AAA24092@webserver.ithnet.com>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Marcelo,

 Is this code from linux-2.4.18-pre4/drivers/net/bonding.c safe?

static int bond_close(struct net_device *master)
{
       write_lock_irqsave(&bond->lock, flags);
<snip>
       bond_release_all(master);

       write_unlock_irqrestore(&bond->lock, flags);

AFAICS 'bond_release_all()' calls a bunch of lower level networking
functions some of which do sleep. It does nothing to release the
bond->lock when this occurs.

Cheers,
  Trond
