Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbTFCU4E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 16:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbTFCU4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 16:56:04 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:56812 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261182AbTFCU4C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 16:56:02 -0400
Message-ID: <3EDD0DFC.4080806@us.ibm.com>
Date: Tue, 03 Jun 2003 16:07:08 -0500
From: Jon Grimm <jgrimm2@us.ibm.com>
Organization: IBM
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: Margit Schubert-While <margitsw@t-online.de>,
       lksctp-developers@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [Lksctp-developers] Re: SCTP config 2.5.70(-bk)
References: <5.1.0.14.2.20030602094232.00aeda18@pop.t-online.de> <20030603130308.GC27168@fs.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

	Sorry for a bit of delay... We are away at an SCTP Interoperability 
event.

Adrian Bunk wrote:
> On Mon, Jun 02, 2003 at 09:53:04AM +0200, Margit Schubert-While wrote:
> 
> 
>>CONFIG_IPV6_SCTP__   is always being set to "y" even though
>>not selected (CONFIG_IPV6 not set)
> 
> 
> First, this doesn't do any harm since CONFIG_IPV6_SCTP__ alone doensn't 
> result in anything getting compiled.
> 
> But besides, it seems a bit broken.
> 
> From net/sctp/Kconfig:
> 
> <--  snip  -->
> 
> ...
> 
> config IPV6_SCTP__
>         tristate
>         default y if IPV6=n
>         default IPV6 if IPV6
> 
> config IP_SCTP
>         tristate "The SCTP Protocol (EXPERIMENTAL)"
>         depends on IPV6_SCTP__
> ...
> 
> <--  snip  -->
> 
> 
> Semantically equivalent is the following for IPV6_SCTP__:
> 
> config IPV6_SCTP__
>         tristate
>         default y if IPV6=n || IPV6=y
> 	default m if IPV6=m
> 
> 
> If it was intended to disallow a static IP_SCTP with a modular IPV6 it 
> doesn't work: It's perfectly allowed to set IPV6=n and IP_SCTP=y and 
> later compile and install a modular IPV6 for the same kernel.
> 

Are you sure?  I vaguely remember one of the network structs having 
#ifdef'd fields for v6.   Consequently, if one compiles first without, 
but the tries later compiles/loads ipv6... bad things happen as the 
kernel has a different concept of what the sock is.

> 
> Could someone from the SCTP developers comment on the intentions behind 
> IPV6_SCTP__ ?
> 

Yes.  The intent was to at least discourage a configuration that will 
segfault.

Thanks,
jon

> 
> 
>>Margit
> 
> 
> cu
> Adrian
> 


