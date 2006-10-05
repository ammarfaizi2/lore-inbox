Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751510AbWJEGmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbWJEGmT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 02:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbWJEGmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 02:42:19 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:32399 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1751510AbWJEGmS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 02:42:18 -0400
Message-ID: <4524A946.1040101@drzeus.cx>
Date: Thu, 05 Oct 2006 08:42:14 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MMC] Multi sector write transfers
References: <20061001124257.17012.78166.stgit@poseidon.drzeus.cx> <20061003151034.a7894df8.akpm@osdl.org>
In-Reply-To: <20061003151034.a7894df8.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Russell is moving away from mmc maintainership so we'll need to do
> something different here.
> 
> The patches look good to my untrained eye, except...
> 
> On Sun, 01 Oct 2006 14:42:57 +0200
> Pierre Ossman <drzeus@drzeus.cx> wrote:
> 
>> SD cards extend the protocol by allowing the host to query a card how many
>> blocks were successfully stored on the medium. This allows us to safely write
>> chunks of blocks at once.
> 
> I recall Russell nacked multisector mmc-writing when it came up six or
> twelve months ago.  I don't recall the exact details - lack of trust in
> manufacturers supporting it correctly?
> 
> Is that concern relevant to this patch?

The concern then was that we enabled multi-sector writes across the
board. Russell's concern was that some host controllers weren't properly
reporting back how far they had gotten when a failure occurred. We now
have two solutions to this:

 * Let the drivers set a flag, indicating that the controller properly
reports the number of sent blocks, even when a fault occurs. Russell put
together a patch for this and it is already in Linus' tree.

 * Ask the card, not the controller, how many blocks got there ok. This
is only supported by SD though, so MMC still use only one block per
write (except for the case above).

The only problem I see is if the card has decided to completely shut
down so it's impossible to query the number of blocks written. In this
case, reporting correctly to the upper layers might not be a big issue
(as they can't take any action on the card anyway), so I do not see it
as a problem in practice. I have yet to see any comments on the patch
though (other than end users that like the speed boost).

Rgds
Pierre
