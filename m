Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWGGJ3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWGGJ3U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 05:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbWGGJ3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 05:29:20 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:53444 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932081AbWGGJ3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 05:29:19 -0400
Subject: Re: linux-2.6.17-mm6: strange kobject message
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Drynoff <pauldrynoff@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060707022420.6f58b58c.akpm@osdl.org>
References: <20060707125942.fe3d467b.pauldrynoff@gmail.com>
	 <20060707022420.6f58b58c.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 11:29:12 +0200
Message-Id: <1152264552.3111.35.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-07 at 02:24 -0700, Andrew Morton wrote:

> hm. 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm6/broken-out/lockdep-annotate-8390c-disable_irq.patch
> didn't work.

-mm6 only had part 1; you also have part 2 now which should fix this one

> We've seen this reported a couple of times before.  It could be a race in
> the tty layer where a newly-added vc has the same index as a going-away
> one which still has its sysfs file.  Or it could be something else :(

that'd be a bug in the tty layer; the VC shouldn't be allowed to go away
until the sysfs file is gone (basic sysfs refcounting rules), and any
person keeping such a file open can delay that.
Now I can believe the tty layer having, ehm, suboptimal
refcounting/locking; I believe Alan is still trying to get it sane....

