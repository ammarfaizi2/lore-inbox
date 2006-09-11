Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964775AbWIKFDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbWIKFDm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 01:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWIKFDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 01:03:42 -0400
Received: from mms1.broadcom.com ([216.31.210.17]:25102 "EHLO
	mms1.broadcom.com") by vger.kernel.org with ESMTP id S932149AbWIKFDl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 01:03:41 -0400
X-Server-Uuid: F962EFE0-448C-40EE-8100-87DF498ED0EA
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: Re: Opinion on ordering of writel vs. stores to RAM
Date: Sun, 10 Sep 2006 22:03:25 -0700
Message-ID: <1551EAE59135BE47B544934E30FC4FC093FB2A@NT-IRVA-0751.brcm.ad.broadcom.com>
Thread-Topic: Re: Opinion on ordering of writel vs. stores to RAM
thread-index: AcbVX5sdygu6lNsBRk6mhX/0pW5lOw==
From: "Michael Chan" <mchan@broadcom.com>
To: benh@kernel.crashing.org
cc: linux-kernel@vger.kernel.org
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006091101; IFV=NA; RPD=4.00.0004;
 RPDID=303030312E30413031303230332E34353034454338362E303030332D422D45654473416A4B5134542B55364649444832454F6B773D3D;
 ENG=RPD; TS=20060911050331; CAT=BROADCAST; CON=HIGH;
X-MMS-Spam-Filter-ID: A2006091101_4.00.0004
X-MMS-Spam-Confidence: high
X-MMS-Content-Rating: broadcast
X-WSS-ID: 691A31953CC6195510-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> > The tg3 bug actually seems not to be because of the missing wmb()'s,
> > [the driver and all net traffic survive just fine in the case of
non- 
> > TSO],
> > but just because of a plain-and-simple programming bug in the
driver.
> > I'll run some tests tomorrow to confirm.  If I'm right, this fix
should
> > go into .18 and into .17-stable at least.
> 
> Interesting :) I didn't actually verify the barrier problem theory
> (though the driver does indeed seem to lack them, so there _is_ a
> problem there too), I trusted Michael Chan who seemed to know about
the
> bug :) 

It definitely is caused by lack of memory barriers before the writel().
IBM, Anton, and all of us know about this.  TSO probably makes it more
susceptible because you write to many buffer descriptors before you
issue one writel() to DMA all the descriptors.  The large number of
TSO descriptors makes re-ordering more likely.

