Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbVILUUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbVILUUo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 16:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbVILUUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 16:20:44 -0400
Received: from magic.adaptec.com ([216.52.22.17]:21385 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S932066AbVILUUm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 16:20:42 -0400
Message-ID: <4325E312.10108@adaptec.com>
Date: Mon, 12 Sep 2005 16:20:34 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: Patrick Mansfield <patmans@us.ibm.com>, Douglas Gilbert <dougg@torque.net>,
       Christoph Hellwig <hch@infradead.org>, Luben Tuikov <ltuikov@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process
 (end devices)
References: <1126308304.4799.45.camel@mulgrave>	 <20050910024454.20602.qmail@web51613.mail.yahoo.com>	 <20050911094656.GC5429@infradead.org> <43251D8C.7020409@torque.net>	 <1126537041.4825.28.camel@mulgrave>  <20050912164548.GB11455@us.ibm.com> <1126545680.4825.40.camel@mulgrave>
In-Reply-To: <1126545680.4825.40.camel@mulgrave>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Sep 2005 20:20:40.0431 (UTC) FILETIME=[71C1DFF0:01C5B7D7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/05 13:21, James Bottomley wrote:
>>So some storage devices that want to use addressing methods other than 00b
>>don't because we do not have 8 byte LUN support in linux, and then we have
>>other problems because of this.
> 
> Well, as long as we represent the u32 (or u64) as
> 
> scsilun[1] | (scsilun[0] << 8) | (scsilun[3] << 16) | (scsilun[2] << 24)
> 
> I think we cover all 2 level lun bases, don't we (obviously we ignore
> levels 3 and 4 [and 6 and 8 byte extended luns])?

I fail to see why do you want to interpret LUNs?  If you want
to be "future-proof", SCSI Core should use it transparently,
a la, memcpy().

If you want to print it you can use "%016llx", be64_to_cpu(*(u64 *)...),
just like WWN.  _That_ will have a meaning to the application client/user,
but SCSI Core should treat it as a transparent token.

> That representation works transparently for type 00b which is what SPI
> and other legacy expects, since our lun variable is equal to the actual
> numeric lun.  Although SAM allows type 01b for arrays with < 256 LUNs it
> does strongly suggest you use type 00b which hopefully will cover us for
> a while longer...

Why do you care about any of this if you support 64 bit luns?

	Luben


> fc already uses int_to_scsilun and 8 byte LUN addressing, so it will
> work even in the 01b case (the numbers that the mid-layer prints will
> look odd, but at least the driver will work).

