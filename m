Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbVHNJle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbVHNJle (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 05:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbVHNJle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 05:41:34 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:16614 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932462AbVHNJld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 05:41:33 -0400
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
From: Arjan van de Ven <arjan@infradead.org>
To: hyoshiok@miraclelinux.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <98df96d305081402164ce52f8@mail.gmail.com>
References: <98df96d305081402164ce52f8@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 14 Aug 2005 11:41:28 +0200
Message-Id: <1124012489.3222.13.camel@laptopd505.fenrus.org>
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

On Sun, 2005-08-14 at 18:16 +0900, Hiro Yoshioka wrote:
> Hi,
> 
> The following is a patch to reduce a cache pollution
> of __copy_from_user_ll().
> 
> When I run simple iozone benchmark to find a performance bottleneck of
> the linux kernel, I found that __copy_from_user_ll() spent CPU cycle
> most and it did many cache misses.


however... you copy something from userspace... aren't you going to USE
it? The non-termoral versions actually throw the data out of the
cache... so while this part might be nice, you pay BIG elsewhere....


