Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265024AbUFMIg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265024AbUFMIg0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 04:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265027AbUFMIg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 04:36:26 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:60425 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S265024AbUFMIgX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 04:36:23 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: hch@infradead.org (Christoph Hellwig)
Subject: Re: [PATCH] IDE update for 2.6.7-rc3 [1/12]
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <20040612103453.GB26482@infradead.org>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.25-1-686-smp (i686))
Message-Id: <E1BZQSC-0006vd-00@gondolin.me.apana.org.au>
Date: Sun, 13 Jun 2004 18:35:00 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
> On Fri, Jun 11, 2004 at 05:50:30PM +0200, Bartlomiej Zolnierkiewicz wrote:
>> 
>> Probably some drivers are still missed because I changed only
>> these drivers that I knew that there are PCI cards using them.
>> 
>> If you know about PCI cards using other drivers please speak up.
> 
> IMHO the PCI ->probe methods should always be __devinit.  It's rather
> hard to make sure they're never every hotplugged in any way, especially
> with the dynamic id adding via sysfs thing.

Well the reason I made them all __devinit in my patch is because it
also tries to maintain the same PCI probing order as a builtin kernel
when IDE is built as a module.

To do that all the PCI driver modules are loaded before probing takes
place.  Therefore if any probing funciton is declared as __init then
this will not work.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
