Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030234AbWBAJhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030234AbWBAJhY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 04:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbWBAJhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 04:37:24 -0500
Received: from [85.8.13.51] ([85.8.13.51]:42726 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1030234AbWBAJhX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 04:37:23 -0500
Message-ID: <43E08148.3060003@drzeus.cx>
Date: Wed, 01 Feb 2006 10:37:12 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5 (X11/20060128)
MIME-Version: 1.0
To: Pierre Ossman <drzeus-list@drzeus.cx>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Purpose of MMC_DATA_MULTI?
References: <43E057DA.7000909@drzeus.cx> <20060201092934.GB27735@flint.arm.linux.org.uk>
In-Reply-To: <20060201092934.GB27735@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Wed, Feb 01, 2006 at 07:40:26AM +0100, Pierre Ossman wrote:
>   
>> I noticed that a new transfer flag was recently added to the MMC layer
>> without any immediate users, the MMC_DATA_MULTI flag. I'm guessing the
>> purpose of the flag is to indicate the difference between
>> MMC_READ_SINGLE_BLOCK and MMC_READ_MULTIPLE_BLOCKS with just one block.
>> If so, then that should probably be mentioned in a comment somewhere.
>>     
>
> There are hosts out there (Atmel AT91-based) which need to know if the
> transfer is going to be multiple block.  Rather than have them test
> the op-code (which is what they're already doing), we provide a flag
> instead.
>
>   

As far as the hardware is concerned there are two "multi-block" transfers:

 * Multiple, back-to-back blocks.
 * One or more blocks that need to be terminated by some form of stop
command.

The first can be identified by checking the number of blocks in the
request, the latter is harder to identify since it's a protocol semantic
(it could be just one block, but still need a stop). Does MMC_DATA_MULTI
indicate the latter, former or both?

Rgds
Pierre

