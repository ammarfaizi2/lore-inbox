Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbVHQLfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbVHQLfo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 07:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbVHQLfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 07:35:44 -0400
Received: from [85.8.12.41] ([85.8.12.41]:27027 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1751089AbVHQLfo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 07:35:44 -0400
Message-ID: <430320EF.3070907@drzeus.cx>
Date: Wed, 17 Aug 2005 13:35:11 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.6-3 (X11/20050806)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "=?ISO-8859-1?Q?J=F6rn_Engel?=" <joern@wohnheim.fh-wedel.de>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Flash erase groups and filesystems
References: <4300F963.5040905@drzeus.cx> <20050816162735.GB21462@wohnheim.fh-wedel.de> <43021DB8.70909@drzeus.cx> <20050816181336.GA2014@wohnheim.fh-wedel.de> <20050816185230.GA2931@wohnheim.fh-wedel.de>
In-Reply-To: <20050816185230.GA2931@wohnheim.fh-wedel.de>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:

>On Tue, 16 August 2005 20:13:36 +0200, Jörn Engel wrote:
>  
>
>>Yes.  Most filesystems expect to find either 1) old data or 2) new
>>data.  Blocks full of 0xff are non-expected.
>>    
>>
>
>Maybe this isn't obvious.  Because of this expectation, it is
>absolutely not safe to pre-erase blocks, just because the fs will
>write them anyway.  Unless you can guarantee that the write will
>always succeed, even in case of power outage, you just broke the
>expectation.
>
>  
>

Darn. I suspected as much. I'll guess the erase function will have to be
scrapped for now...

Whilst we're on the subject, do the filesystems assume that the device
can tell them exactly where the write failed? I.e. if the driver knows
that 5 sectors were written correctly, but that it failed somewhere
beyond that. It might have failed at sector 6, but it might also have
failed at sector 10. The assumption that sectors contain either old or
new data is still true, we're just unsure which. This can be the case
when you feed a controller a lot of data and it can only report back
success or failure.

>Fixing all filesystem is also not an option, even ignoring the
>question whether such a change would be a fix, a change of behaviour
>or a plain bug.
>
>So the only remaining option is to add a new interface that lets
>filesystems decide to support pre-erase in some form.  And one such
>interface would be the "forget" operation.  Nice attribute of forget
>is the fact that it would also help some FTL layers in the kernel.
>There is nothing MMC-specific about it.
>
>  
>

A bit too much work for me right now. But I'll be there with my erase
patch when someone implements it. :)

Rgds
Pierre


