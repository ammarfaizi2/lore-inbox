Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262049AbVEXKIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbVEXKIJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 06:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbVEXJmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 05:42:00 -0400
Received: from smtp.nexlab.net ([213.173.188.110]:11465 "EHLO smtp.nexlab.net")
	by vger.kernel.org with ESMTP id S262021AbVEXJVw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 05:21:52 -0400
X-Postfix-Filter: PDFilter By Nexlab, Version 0.1 on mail01.nexlab.net
X-Virus-Checker-Version: clamassassin 1.2.1 with ClamAV 0.83/893/Tue May 24
	08:27:20 2005 signatures 31.893
Message-Id: <20050524092149.22645FA7D@smtp.nexlab.net>
Date: Tue, 24 May 2005 11:21:49 +0200 (CEST)
From: root@smtp.nexlab.net
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	by smtp.nexlab.net (Postfix) with ESMTP id D9E1AFA5A

	for <chiakotay@nexlab.it>; Tue, 24 May 2005 06:39:35 +0200 (CEST)

Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand

	id S261346AbVEXDUv (ORCPT <rfc822;chiakotay@nexlab.it>);

	Mon, 23 May 2005 23:20:51 -0400

Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVEXDUv

	(ORCPT <rfc822;linux-kernel-outgoing>);

	Mon, 23 May 2005 23:20:51 -0400

Received: from mx1.redhat.com ([66.187.233.31]:12499 "EHLO mx1.redhat.com")

	by vger.kernel.org with ESMTP id S261324AbVEXDUi (ORCPT

	<rfc822;linux-kernel@vger.kernel.org>);

	Mon, 23 May 2005 23:20:38 -0400

Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])

	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j4O3KR8X000397;

	Mon, 23 May 2005 23:20:27 -0400

Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])

	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j4O3KRO05468;

	Mon, 23 May 2005 23:20:27 -0400

Received: from thoron.boston.redhat.com (thoron.boston.redhat.com [172.16.80.63])

	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id j4O3KQpW029577;

	Mon, 23 May 2005 23:20:26 -0400

Date:	Mon, 23 May 2005 23:20:26 -0400 (EDT)

From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com

To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <davem@davemloft.net>
Subject: Re: [CRYPTO]: Only reschedule if !in_atomic()

In-Reply-To: <20050524024318.GB29242@gondor.apana.org.au>

Message-ID: <Xine.LNX.4.44.0505232319450.1507-100000@thoron.boston.redhat.com>

MIME-Version: 1.0

Content-Type: TEXT/PLAIN; charset=US-ASCII

Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk

X-Mailing-List:	linux-kernel@vger.kernel.org



On Tue, 24 May 2005, Herbert Xu wrote:

> On Mon, May 23, 2005 at 07:31:16PM -0700, Andrew Morton wrote:
> > 
> > Are you sure it's actually needed? Have significant scheduling latencies
> > actually been observed?
> 
> I certainly don't have any problems with removing the yield altogether.
> 
> > Bear in mind that anyone who cares a lot about latency will be running
> > CONFIG_PREEMPT kernels, in which case the whole thing is redundant anyway. 
> > I generally take the position that if we're going to put a scheduling point
> > into a non-premept kernel then it'd better be for a pretty bad latency
> > point - more than 10 milliseconds, say.
> 
> The crypt() function can easily take more than 10 milliseconds with
> a large enough buffer.
> 
> James & Dave, do you have any opinions on this?

a) remove the scheudling point and see if anyone complains
b) if so, add a flag



- James
-- 
James Morris
<jmorris@redhat.com>


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

