Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266217AbUHOReN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266217AbUHOReN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 13:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266004AbUHORdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 13:33:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:61652 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266248AbUHORdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 13:33:04 -0400
Date: Sun, 15 Aug 2004 10:31:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk,
       marcelo.tosatti@cyclades.com, torvalds@osdl.org
Subject: Re: Possible dcache BUG
Message-Id: <20040815103127.2faa5be3.akpm@osdl.org>
In-Reply-To: <200408150542.55953.gene.heskett@verizon.net>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org>
	<200408150009.45034.gene.heskett@verizon.net>
	<20040815084856.GD12308@parcelfarce.linux.theplanet.co.uk>
	<200408150542.55953.gene.heskett@verizon.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett <gene.heskett@verizon.net> wrote:
>
> ...
>
> Now, this mornings logwatch told me I should go look at the 
>  logs again, and I found this had occurred several hours earlier:
>  -----------
>  Aug 14 18:53:24 coyote kernel: Unable to handle kernel paging request at virtual address 0058af03

This oops is the _cause_ of the out-of-memory condition.  The oopsing
process exitted while holding shrinker_sem, so slab will never again be
shrunk.

Any observed behaviour after an oops is almost always uninteresting, and
usually misleading.
