Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264833AbUEKR1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264833AbUEKR1p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 13:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbUEKR1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 13:27:25 -0400
Received: from mailgate1b.savvis.net ([216.91.182.6]:15249 "EHLO
	mailgate1b.savvis.net") by vger.kernel.org with ESMTP
	id S264873AbUEKRZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 13:25:53 -0400
From: "Dan A. Dickey" <dan.dickey@savvis.net>
Reply-To: dan.dickey@savvis.net
Organization: WAM!NET a Division of SAVVIS, Inc.
To: "Marc-Christian Petersen" <m.c.p@kernel.linux-systeme.com>
Subject: Re: Sock leak in net/ipv4/af_inet.c - 2.4.26
Date: Tue, 11 May 2004 12:25:37 -0500
User-Agent: KMail/1.6.2
Cc: <linux-kernel@vger.kernel.org>, <kuznet@ms2.inr.ac.ru>, <davem@redhat.com>
References: <200405111843.50048@WOLK>
In-Reply-To: <200405111843.50048@WOLK>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405111225.38072.dan.dickey@savvis.net>
X-ECS-MailScanner: No virus is found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 May 2004 11:43, Marc-Christian Petersen wrote:
> On Tuesday 11 May 2004 18:24, Dickey, Dan wrote:
>
> Hi Dan,
>
> > I've found a leak in af_inet.c, routine inet_create().
> > It allocates from the sock slab using sk_alloc(), but
> > sk_free() is never called on these sock structs.
> > I'm not that familiar with the af_inet code, but I'll
> > continue taking a look at it to try and determine where
> > the missing sk_free() is supposed to be.
> > If either of you or anyone else has an idea, please
> > let me know.  We have several 2GB mem systems that need
> > to be rebooted every few days because of this problem.
> > Oh - by the way, it looks like this is happening in
> > net/ipv4/tcp_minisocks.c as well.  Routine tcp_create_openreq_child().
> > There is no corresponding sk_free() call for the sk_alloc() in here.
> > In order to track these down, I've added some simple debug code
> > around the sk_alloc/sk_free calls to track allocations.  I know
> > where the leaky sock structs are being allocated from, but not
> > where they should be freed.
>
> am I silly or do I see lots of sk_free(sk); in there?
>
> ciao, Marc

Marc,
there are zero sk_free() calls in tcp_minisocks.c and
three in af_inet.c.  Go take another look.
Remember - 2.4.26 sources.
	-Dan

-- 
Dan A. Dickey
dan.dickey@savvis.net
