Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751055AbVHVWQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbVHVWQy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbVHVWQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:16:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40074 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751055AbVHVWQw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:16:52 -0400
Date: Mon, 22 Aug 2005 15:09:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: luben_tuikov@adaptec.com, jim.houston@ccur.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       davej@redhat.com, jgarzik@pobox.com
Subject: Re: [PATCH 2.6.12.5 1/2] lib: allow idr to be used in irq context
Message-Id: <20050822150942.4f0c46df.akpm@osdl.org>
In-Reply-To: <1124747615.5211.34.camel@mulgrave>
References: <20050822003325.33507.qmail@web51613.mail.yahoo.com>
	<1124680540.5068.37.camel@mulgrave>
	<20050821205214.2a75b3cf.akpm@osdl.org>
	<1124720938.5211.13.camel@mulgrave>
	<1124747615.5211.34.camel@mulgrave>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@SteelEye.com> wrote:
>
> Of course, if we're going to go to all this trouble, the next question
>  that arises naturally is why not just reuse the radix-tree code to
>  implement idr anyway ... ?

Yes, we could probably have gone that way.  radix-tree would need some
enhancements for the find-next-above thing.

radix-tree has some features (tags, gang-lookup, gang-lookup-by-tag) which
idr doesn't.  Fitting them all into the one storage API would be nice, I
guess.  radix-tree does potentially use more memory, although that'll only
be significant for collections which are both large and sparse.

Still, people can use either facility at present.  The person who does any
such consolidation would do the kernel-wide migration at the same time.
