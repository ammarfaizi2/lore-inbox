Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbVJCPbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbVJCPbF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 11:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbVJCPbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 11:31:05 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:20435 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S932287AbVJCPbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 11:31:03 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Andre Hedrick <andre@linux-ide.org>,
       "David S. Miller" <davem@davemloft.net>, willy@w.ods.org,
       patmans@us.ibm.com, ltuikov@yahoo.com, linux-kernel@vger.kernel.org,
       akpm@osdl.org, torvalds@osdl.org, linux-scsi@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <43414C06.2030501@adaptec.com>
References: dlang@dlang.diginsite.com <Pine.LNX.4.62.0510030721540.11541@qynat.qvtvafvgr.pbz> <43414C06.2030501@adaptec.com>
Date: Mon, 3 Oct 2005 08:30:33 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx
 intothekernel
In-Reply-To: <43414C06.2030501@adaptec.com>
Message-ID: <Pine.LNX.4.62.0510030824310.11541@qynat.qvtvafvgr.pbz>
References: dlang@dlang.diginsite.com <Pine.LNX.4.62.0510030721540.11541@qynat.qvtvafvgr.pbz>
 <43414C06.2030501@adaptec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Oct 2005, Luben Tuikov wrote:

> On 10/03/05 10:26, David Lang wrote:
>> in this case wouldn't it be trivial to write a 'null transport' driver
>> that just passed things down to the card to let the firmware deal with it?
>> (reformatting the data if needed)
>
> Hi David,
>
> I think it is trivial.
>
> Your LLDD would define the host template and register it
> with SCSI Core.  This way you _bypass_ the Transport Layer.
> (This is what you call null driver -- as is traditionally done
> in SCSI Core due to the legacy LLDDs (to which MPT caters
> for 100% backward software compatibility))
>
> Else if your LLDD is just an inteface to the interconnect:
> i.e. it only implements Execute SCSI RPC and TMFs, then
> you'd register with the Transport Layer (SBP or USB or SAS)
> which will do all Transport related tasks, and then that
> Transport Layer (USB, SBP or SAS) would register a scsi host
> with SCSI Core.

the advantage of actually having a null transport driver rather then 
bypassing the transport layer completely is that you avoid having to make 
the SCSI core know about details of the interface to the chips, and 
especially about any bugs that crop up and have to be worked around for 
different chips.

or worse yet, as the spec of the interface to the hardware changes over 
time the SCSI core would have to know about all the different variations 
and how to deal with them.

it's much cleaner to evict all that knowledge out of the SCSI core and let 
a very lightweight transport driver deal with that instead.

the drawback is that you may end up copying a little bit of data one time 
more then you absolutly have to, but that's probably a very small cost for 
the flexibility.

think of this as a problem similar to the network card interface, vendors 
want to implement TOE while the kernel folks are willing to do TSO, but 
not TOE (see the letters being exchange on lwn.net in the letters to the 
editor section the last few weeks for a good discussion on those issues)

David Lang
