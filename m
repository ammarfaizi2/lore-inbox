Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbVHOHV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbVHOHV5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 03:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbVHOHV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 03:21:56 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:2284 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932144AbVHOHV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 03:21:56 -0400
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
From: Arjan van de Ven <arjan@infradead.org>
To: pomac@vapor.com
Cc: linux-kernel@vger.kernel.org, hch@infradead.org, arian@infradead.org,
       lkml.hyoshiok@gmail.com
In-Reply-To: <1124054660.10376.15.camel@localhost>
References: <1124054660.10376.15.camel@localhost>
Content-Type: text/plain
Date: Mon, 15 Aug 2005 09:21:51 +0200
Message-Id: <1124090511.3228.12.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-08-14 at 23:24 +0200, Ian Kumlien wrote:
> Hi, all
> 
> I might be missunderstanding things but...
> 
> First of all, machines with long pipelines will suffer from cache misses
> (p4 in this case).
> 
> Depending on the size copied, (i don't know how large they are so..)
> can't one run out of cachelines and/or evict more useful cache data?

CPU caches are really big nowadays

> 
> Ie, if it's cached from begining to end, we generally only need 'some
> of' the begining, the cpu's prefetch should manage the rest.

cpu prefetch isn't going to be fast enough. It helps some, but in the
end the cpu prefetch also has to wait for the ram, it doesn't make the
ram faster or free, it just takes a jumpstart on getting to it.


> I might, as i said, not know all about things like this and i also
> suffer from a fever but i still find Hiro's data interesting.

It is. It's good proof that you can make a big gain already by
converting a few key places to his excellent code. And neither me nor
Christoph are suggesting to ditch his effort! Instead we suggest that
what he is doing is useful for some cases and harmful for others, and
that it is quite easy to identify those cases and separate them from
eachother, and that thus as a result it is more optimal to have 2 apis,
one for each of the cases.



