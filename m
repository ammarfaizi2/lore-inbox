Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261895AbVGWWDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbVGWWDL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 18:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbVGWWDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 18:03:11 -0400
Received: from imf22aec.mail.bellsouth.net ([205.152.59.70]:57335 "EHLO
	imf22aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261895AbVGWWDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 18:03:09 -0400
Message-ID: <00d501c58fd2$50d11130$2800000a@pc365dualp2>
From: <cutaway@bellsouth.net>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Adrian Bunk" <bunk@stusta.de>, <linux-kernel@vger.kernel.org>
References: <42E14134.1040804@yahoo.co.uk> <20050722201416.GM3160@stusta.de> <01bd01c58f50$0998c650$2800000a@pc365dualp2> <1122148237.27629.1.camel@localhost.localdomain>
Subject: Re: kernel optimization
Date: Sat, 23 Jul 2005 18:03:02 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1478
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I submit that sparse switch jump table's are not an "unusual" construct in
the Linux kernel/drivers.  GCC only creates a table large enough to cover
the largest of the sparse values - it doesn't have to be 0...255.  0...60
with 10 values sparsely scattered would generate a 61 element jump table.

There's many K of locked memory in these sparse jump tables.  About 2K worth
in the VT102 code alone.

----- Original Message ----- 
From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
To: <cutaway@bellsouth.net>
Cc: "Adrian Bunk" <bunk@stusta.de>; <linux-kernel@vger.kernel.org>
Sent: Saturday, July 23, 2005 15:50
Subject: Re: kernel optimization


> On Sad, 2005-07-23 at 02:30 -0400, cutaway@bellsouth.net wrote:
> > Larger does not always mean slower.  If it did, nobody would implement a
> > loop unrolling optimization.
>
> Generally speaking nowdays it does. Almost all loop unrolls are a loss
> on PIV.
>
> > ex. Look at how GCC generates jump tables for switch() when there's
about
> > 10-12 (or more) case's sparsely scattered in the rage from 0 through
255.
>
> You are comparing with very expensive jump operations its an unusual
> case. For the majority of situations the TLB/cache overhead of misses
> vastly outweighs the odd clock cycle gained by verbose output.
>
>

