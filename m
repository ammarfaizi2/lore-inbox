Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262613AbTJPVCq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 17:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263050AbTJPVCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 17:02:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26829 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262613AbTJPVCo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 17:02:44 -0400
Message-ID: <3F8F0766.30405@pobox.com>
Date: Thu, 16 Oct 2003 17:02:30 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Val Henson <val@nmt.edu>
CC: Larry McVoy <lm@work.bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl> <3F8D6417.8050409@pobox.com> <20031016162926.GF1663@velociraptor.random> <20031016172930.GA5653@work.bitmover.com> <20031016174927.GB25836@speare5-1-14>
In-Reply-To: <20031016174927.GB25836@speare5-1-14>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Val Henson wrote:
> Abstract:
> 
>  "Recent research has produced a new and perhaps dangerous technique
>   for uniquely identifying blocks that I will call
>   compare-by-hash. Using this technique, we decide whether two blocks
>   are identical to each other by comparing their hash values, using a
>   collision-resistant hash such as SHA-1. If the hash values match,
>   we assume the blocks are identical without further ado. Users of
>   compare-by-hash argue that this assumption is warranted because the
>   chance of a hash collision between any two randomly generated blocks
>   is estimated to be many orders of magnitude smaller than the chance
>   of many kinds of hardware errors. Further analysis shows that this
>   approach is not as risk-free as it seems at first glance."


I'm curious if anyone has done any work on using multiple different 
checksums?  For example, the cost of checksumming a single block with 
multiple algorithms (sha1+md5+crc32 for a crazy example), and storing 
each checksum (instead of just one sha1 sum), may be faster than reading 
the block off of disk to compare it with the incoming block.  OTOH, 
there is still a mathematical possibility (however-more-remote) of a 
collission...

With these sorts of schemes, from basic compare-by-hash to one that 
actually checks the data for a collission, you take a hit no matter what 
when writing, but reading is still full-speed-ahead.  (if anyone is 
curious, Plan9's venti uses a multi-GB "write buffer", to mitigate the 
effect of the checksumming on throughput)

So it's easy to tweak the writing algorithms pretty much any which way, 
as long as the outcome is a unique tag for each block.  Hash collisions 
between two files, for example, could be resolved easily by making each 
unique tag "$sha1_hash $n", where $n is the unique number 
differentiating two blocks with the same SHA1 hash.

	Jeff



