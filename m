Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318300AbSHPLJy>; Fri, 16 Aug 2002 07:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318304AbSHPLJy>; Fri, 16 Aug 2002 07:09:54 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:59120 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318300AbSHPLJx>; Fri, 16 Aug 2002 07:09:53 -0400
Subject: Re: PCI MMIO flushing, write-combining etc
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m3d6sjele5.fsf@defiant.pm.waw.pl>
References: <m3d6sjele5.fsf@defiant.pm.waw.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 16 Aug 2002 12:12:35 +0100
Message-Id: <1029496355.31514.44.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-16 at 00:45, Krzysztof Halasa wrote:
> I understand writes to PR1 can be reordered, merged, and delayed.
> What should I do to flush the write buffers? I understand reading from
> PR1 would do. Would reading from NPR2 flush PR1 write buffers?
> Would writing to NPR2 flush them?

That one I can't actually remember. 

> Now NPR2, the non-prefetchable MMIO region.
> Is it possible that the writes there are reordered, merged and/or
> delayed (delayed = not making it to the PCI device when the writel()
> completes)?

All PCI writes are posted. Think of PCI as messages otherwise you'll go
slowly insane debugging code. If you want to know your write completed
you need to read, when the read returns both have completed

> We have ioremap() and ioremap_nocache(). What is the exact difference
> between them? Would the ioremap_nocache() disable all A) read- and
> B) write-caching on a) prefetchable MMIO b) non-prefetchable MMIO ?

They make no difference

