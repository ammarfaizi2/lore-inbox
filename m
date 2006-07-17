Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbWGQHzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWGQHzT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 03:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbWGQHzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 03:55:19 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:177 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932156AbWGQHzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 03:55:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WhsEA0sCDoMxWxs99nsoHHU4vhpXAxC/P1RIjh3YiRS0suh/FhvoEUU9/AKmbt1d+NdO9BTmm3ZGxWiXQSDcpHUF8dsMK1Yh3vxmdcyNGENr8Ds7EPESq7f3LofK2PgYM1XA/csiAZAIChkAxV2tgJoj4Gkje84CBQRhiCNl4Yo=
Message-ID: <fbe022af0607170055x7fefdf9bg63ea77768480935a@mail.gmail.com>
Date: Mon, 17 Jul 2006 00:55:16 -0700
From: "Vikas Kedia" <kedia.vikas@gmail.com>
To: "Andreas Mohr" <andi@rhlx01.fht-esslingen.de>
Subject: Re: kernel panic at load average of 24 is it acceptable ?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060717072457.GA12215@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <fbe022af0607170008w5efb489fjd3df63f1795805c2@mail.gmail.com>
	 <20060717072457.GA12215@rhlx01.fht-esslingen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Read up on MCE debugging methods on Linux or so, that should hopefully help.

Here is the output of mcelog:
root@srv1:~# less /var/log/mcelog
MCE 0
CPU 0 0 data cache TSC 6988ae18046
ADDR f87f5ec0
  Data cache ECC error (syndrome ce)
       bit46 = corrected ecc error
  bus error 'local node origin, request didn't time out
      data read mem transaction
      memory access, level generic'
STATUS 9467400000000833 MCGSTATUS 0
MCE 0
CPU 0 0 data cache TSC 723b38a3633
ADDR 3d9fc0
  Data cache ECC error (syndrome ce)
       bit46 = corrected ecc error
       bit62 = error overflow (multiple errors)
  bus error 'local node origin, request didn't time out
      data read mem transaction
      memory access, level generic'
STATUS d467400000000833 MCGSTATUS 0

Since it shows ECC error is the hypothesis correct that its the RAM
problem and replacing it should solve the problem.

Regards,

Vikas

On 7/17/06, Andreas Mohr <andi@rhlx01.fht-esslingen.de> wrote:
> Hi,
>
> On Mon, Jul 17, 2006 at 12:08:41AM -0700, Vikas Kedia wrote:
> > The memtest ran fine for 8 hours:
> > http://www.visitlab.com/styles/basic/images/memtest.JPG
> >
> > My questions are:
> > 1. Kernel panic at load average of 24 is it acceptable ?
>
> Kernel panic is _NEVER_ acceptable.
> I've seen loads in the couple hundreds with no problem.
>
> However you actually have a mce_panic() crash here.
> Make sure to figure out why this Machine Check Exception got raised,
> otherwise you might hose the box if you continue without investigation.
> It could easily be due to mal-working CPU fan etc.pp., especially since it
> happened exactly while you stress-tested the machine.
>
> > 2. If not how do I go about debugging this kernel panic ?
>
> Read up on MCE debugging methods on Linux or so, that should hopefully help.
>
> Good luck!
>
> Andreas Mohr
>
