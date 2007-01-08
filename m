Return-Path: <linux-kernel-owner+w=401wt.eu-S1751510AbXAHNEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbXAHNEa (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 08:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbXAHNE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 08:04:29 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:54449 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751510AbXAHNE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 08:04:29 -0500
Message-ID: <45A24159.7060001@pobox.com>
Date: Mon, 08 Jan 2007 08:04:25 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sata_via: PATA support, resubmit
References: <20070108122659.00c22754@localhost.localdomain>
In-Reply-To: <20070108122659.00c22754@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
> This is a clean version of the PATA support for the sata_via hardware.
> I'm resubmitting it since nothing has happened since the last submission
> despite promises of libata core changes. Given users actually need to use
> this stuff today and the code is clean it should get merged irrespective
> of any longer term plans for per channel operations structs and the like.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

Re-explanation since you missed it the first time:

Per-channel operations structs work /today/.

The problem you need to fix or work around is ata_probe_ent, which 
doesn't properly fill in ata_port info for this situation.  Tejun has 
posted patches that kill ata_probe_ent, which you were pointed to. 
Mikael Pettersson just posted a sata_promise example that uses 
->port_start to work around this problem, setting the cable type and 
ata_port::ops properly at runtime, based on SATA or PATA.  See "[RFC] 
sata_promise: handle TX2plus PATA locally", I believe you were CC'd on 
my response.

So, working code for both the short term workaround and long term fix 
exist /today/.

If you get the setup right, you don't bloat each hook with "is this port 
PATA?" tests.  At present, your sata_via patch introduces these needless 
tests.

	Jeff


