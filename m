Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264900AbUEKQ4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264900AbUEKQ4x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 12:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264883AbUEKQyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 12:54:19 -0400
Received: from lindsey.linux-systeme.com ([62.241.33.80]:8970 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S264835AbUEKQoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 12:44:44 -0400
From: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
Organization: Linux-Systeme GmbH
To: linux-kernel@vger.kernel.org
Subject: Re: Sock leak in net/ipv4/af_inet.c - 2.4.26
Date: Tue, 11 May 2004 18:43:50 +0200
User-Agent: KMail/1.6.2
Cc: "Dickey, Dan" <Dan.Dickey@savvis.net>, <kuznet@ms2.inr.ac.ru>,
       <davem@redhat.com>
References: <3B33FD3ADBD7054DB410CD9DA314133E037DDB9D@sl6exch4>
In-Reply-To: <3B33FD3ADBD7054DB410CD9DA314133E037DDB9D@sl6exch4>
X-Operating-System: Linux 2.6.5-wolk3.0 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200405111843.50048@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 May 2004 18:24, Dickey, Dan wrote:

Hi Dan,

> I've found a leak in af_inet.c, routine inet_create().
> It allocates from the sock slab using sk_alloc(), but
> sk_free() is never called on these sock structs.
> I'm not that familiar with the af_inet code, but I'll
> continue taking a look at it to try and determine where
> the missing sk_free() is supposed to be.
> If either of you or anyone else has an idea, please
> let me know.  We have several 2GB mem systems that need
> to be rebooted every few days because of this problem.
> Oh - by the way, it looks like this is happening in
> net/ipv4/tcp_minisocks.c as well.  Routine tcp_create_openreq_child().
> There is no corresponding sk_free() call for the sk_alloc() in here.
> In order to track these down, I've added some simple debug code
> around the sk_alloc/sk_free calls to track allocations.  I know
> where the leaky sock structs are being allocated from, but not
> where they should be freed.

am I silly or do I see lots of sk_free(sk); in there?

ciao, Marc
