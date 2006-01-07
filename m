Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030536AbWAGSns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030536AbWAGSns (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 13:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030539AbWAGSns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 13:43:48 -0500
Received: from wasp.net.au ([203.190.192.17]:19332 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S1030536AbWAGSnr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 13:43:47 -0500
Message-ID: <43C00C32.9050002@wasp.net.au>
Date: Sat, 07 Jan 2006 22:45:06 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Sebastian <sebastian_ml@gmx.net>, axboe@suse.de
Subject: Re: Digital Audio Extraction with ATAPI drives far from perfect
References: <20060107103901.GA17833@section_eight.mops.rwth-aachen.de> <20060107105649.GT3389@suse.de> <20060107112443.GA18749@section_eight.mops.rwth-aachen.de> <20060107115340.GW3389@suse.de> <20060107115449.GB20748@section_eight.mops.rwth-aachen.de> <20060107115947.GY3389@suse.de> <20060107140843.GA23699@section_eight.mops.rwth-aachen.de> <20060107142201.GC3389@suse.de> <20060107160622.GA25918@section_eight.mops.rwth-aachen.de> <43BFFE08.70808@wasp.net.au> <20060107180211.GA12209@section_eight.mops.rwth-aachen.de>
In-Reply-To: <20060107180211.GA12209@section_eight.mops.rwth-aachen.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian wrote:
> (please, don't forget to me and axboe@suse.de)

Did I? I'm sorry, I was *sure* I hit reply-to-all.

>> Yes, but now we need to find out why one interface fails while another 
>> works.. I have the same problem here using cdrdao when ripping entire disk 
>> images. I'd love to fix the real issue rather than work around it by having 
>> userspace use another interface.
>> I would have thought that both interfaces should return the same data..
>>
>> Brad
> 
> I think cdrdao can use SG_IO if you tell it to. Check their documentation. Or did I misunderstand what you're saying?

Slightly.. If I'm not mistaken, we have a piece of software (for arguments sake let's call it 
cdparanoia). The stock software uses the ATA or ATAPI interface and produces bodged reads, the 
modified version you have uses SG_IO and produces accurate reads.

What I'm wondering is why the difference, and is there a problem with the ATA/ATAPI interface that 
leads to this that needs looking into.

*or* is it a userspace problem with the way cdparanoia is using that interface

*or* is it an inherent problem/limitation with that particular interface

I can reproduce this with cdrdao by reading a cd 10 times with all combinations of paranoia mode 
attempted. I get 10 x ~550 meg data.bin files that all differ.

I'm thinking I need to work up a script that diffs them by audio sector size chunks to see if there 
is a pattern there somewhere, but you would think that somewhere 2 reads in 10 would be identical.

Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
