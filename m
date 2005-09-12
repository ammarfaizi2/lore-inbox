Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbVILWAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbVILWAX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 18:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbVILWAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 18:00:23 -0400
Received: from magic.adaptec.com ([216.52.22.17]:53920 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S932277AbVILWAW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 18:00:22 -0400
Message-ID: <4325FA6F.3060102@adaptec.com>
Date: Mon, 12 Sep 2005 18:00:15 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Luben Tuikov <ltuikov@yahoo.com>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 14/14] sas-class: SCSI Host glue
References: <1126308949.4799.54.camel@mulgrave> <20050910041218.29183.qmail@web51612.mail.yahoo.com> <20050911093847.GA5429@infradead.org>
In-Reply-To: <20050911093847.GA5429@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Sep 2005 22:00:20.0928 (UTC) FILETIME=[5E694C00:01C5B7E5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/05 05:38, Christoph Hellwig wrote:
>>Hmm, lets see:
>>I posted today, a _complete_ solution, 1000 years ahead of this
>>"embryonic SAS class" you speak of.
> 
> 
> They're actually serving different needs.  The host-bases SAS code you
> wrote should be layering below my SAS transport class.

Yes, they are completely orthogonal and can co-exist.

> What SPEC do you think a representation of SAS domains in the linux driver
> model just adhere to?

See figure 10, SAS Domain class diagram, in SAS1r09e.  It cross-links
you to SAM-3 (you can also use SAM-4).

> There will be more SAS LLDDs that either do more things in firmware like
> LSI Fusion and ones that do things in the Host like the Adaptec one.  And
> we need to support both.  The best way to do that is to have a small top
> layer that just unifies the SAS domain presentation, and a 'libsas' layer
> below it for host-bases SAS implementations.

It is a _layer_ just like it is in SAM and SPC and SAS.
It is a _layer_ by SCSI design, if you look in SAM.

SAS is not libsas, but a transport _layer_ sitting between
the interconnect (hardware) and SCSI Core (SAM/SPC).

I wish I could do something to convince you, but you have
to convince yourself of this reading SAM and trying
to draw it out (literally) yourself.  Try it for
an SPI domain, FC domain and SAS domain, and then you'll
see it.

The sysfs representation is just a perk of the transport
layer, it is owned and operated by the transport layer.

"transport attribute class" is just an _attribute_ class, Christoph.
"transport layer" is a lot more involved.  I sincerely hope
you can see this.  E.g. domain discovery belongs in the transport
layer.  In SPI, LLDDs did it; in MPT the firmware does it.

With SAS, the domain is passive, and the protocol has evolved
enough (due to SAM) to yield to a common transport layer,
where common routines are done, as the SAS code shows.

The _next_ new protocol after SAS, will also adhere to SAM.
It will not happen tomorrow, but it will come around.

The less we invent our own stuff, and the more we adhere
to a spec, the easier we'd support new techonologies, since
they will adhere to SAM.

	Luben

P.S. You know when I mentioned "SCSI" above, I did _not_ mean
SCSI-2 or SCSI (Parallel SCSI).  I meant SCSI-3 (SAM).




