Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbVJCPTm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbVJCPTm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 11:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbVJCPTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 11:19:42 -0400
Received: from magic.adaptec.com ([216.52.22.17]:5079 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1751101AbVJCPTl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 11:19:41 -0400
Message-ID: <43414C06.2030501@adaptec.com>
Date: Mon, 03 Oct 2005 11:19:34 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>
CC: Jeff Garzik <jgarzik@pobox.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Andre Hedrick <andre@linux-ide.org>,
       "David S. Miller" <davem@davemloft.net>, willy@w.ods.org,
       patmans@us.ibm.com, ltuikov@yahoo.com, linux-kernel@vger.kernel.org,
       akpm@osdl.org, torvalds@osdl.org, linux-scsi@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx intothe
 kernel
References: dlang@dlang.diginsite.com <Pine.LNX.4.62.0510030721540.11541@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.62.0510030721540.11541@qynat.qvtvafvgr.pbz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Oct 2005 15:19:35.0069 (UTC) FILETIME=[DCA324D0:01C5C82D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/05 10:26, David Lang wrote:
> in this case wouldn't it be trivial to write a 'null transport' driver 
> that just passed things down to the card to let the firmware deal with it?
> (reformatting the data if needed)

Hi David,

I think it is trivial.

Your LLDD would define the host template and register it
with SCSI Core.  This way you _bypass_ the Transport Layer.
(This is what you call null driver -- as is traditionally done
in SCSI Core due to the legacy LLDDs (to which MPT caters
for 100% backward software compatibility))

Else if your LLDD is just an inteface to the interconnect:
i.e. it only implements Execute SCSI RPC and TMFs, then
you'd register with the Transport Layer (SBP or USB or SAS)
which will do all Transport related tasks, and then that
Transport Layer (USB, SBP or SAS) would register a scsi host
with SCSI Core.

	Luben

> having a null driver for a layer for some hardware, and a much more 
> complex driver for the same layer for other hardware is fairly common in 
> Linux. I believe ti was Linus that said in an interview that Linux is now 
> largely designed for an ideal abstracted CPU, with code put in on the 
> architectures that don't have a feature to simulate that feature in 
> software.
> 
> David Lang
> 

