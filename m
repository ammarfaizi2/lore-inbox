Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030233AbVIAQbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030233AbVIAQbX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 12:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030234AbVIAQbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 12:31:23 -0400
Received: from orb.pobox.com ([207.8.226.5]:7135 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S1030233AbVIAQbX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 12:31:23 -0400
Message-ID: <43172CD4.3010308@rtr.ca>
Date: Thu, 01 Sep 2005 12:31:16 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050728
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: DervishD <lkml@dervishd.net>
Cc: Brice Goglin <Brice.Goglin@ens-lyon.org>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [SOLVED] USB Storage speed regression since 2.6.12
References: <20050901113614.GA63@DervishD> <4316EAD1.70300@ens-lyon.org> <20050901162353.GA67@DervishD>
In-Reply-To: <20050901162353.GA67@DervishD>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DervishD wrote:
..
> the new implementation seems to rewrite the fat on every single write
> (that's the reason of the slowdown, probably), and since I'm not sure
> about the quality of the flash memory present in the device, it is
> very probable that it would wear the first sectors :( So I have to
> mount it 'async' under 2.6.13; I didn't have to do that on older

Nearly all flashcard devices (CompactFlash, SD, MMC, ..)
have built-in wear-leveling in the on-card controller logic.
So continuously rewriting the FAT will NOT rewrite the same
on-card physical pages over and over, but rather it will
try to spread those writes out over the entire (available)
span of physical sectors on the device.

So no worries about "wearing out the FAT sectors",
but I'd still use "async" just to reduce the overall
wear and tear regardless.

Cheers
