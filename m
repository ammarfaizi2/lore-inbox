Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262016AbVGEXmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbVGEXmG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 19:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbVGEXmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 19:42:06 -0400
Received: from dvhart.com ([64.146.134.43]:49844 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S262016AbVGEXj6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 19:39:58 -0400
Message-ID: <42CB1A4A.7000501@dvhart.com>
Date: Tue, 05 Jul 2005 16:39:54 -0700
From: Darren Hart <darren@dvhart.com>
Reply-To: dvhltc@us.ibm.com
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: Robert Love <rml@novell.com>,
       Samuel Thibault <samuel.thibault@ens-lyon.org>,
       Andy Isaacson <adi@hexapodia.org>, linux-kernel@vger.kernel.org
Subject: Re: wrong madvise(MADV_DONTNEED) semantic
References: <20050628134316.GS5044@implementation.labri.fr> <20050628181620.GA1423@hexapodia.org> <1119983300.6745.1.camel@betsy> <20050628185300.GB30079@hexapodia.org> <1119986623.6745.10.camel@betsy> <20050628194128.GM4645@bouh.labri.fr> <20050628200330.GB4453@wohnheim.fh-wedel.de> <1119989111.6745.21.camel@betsy> <20050628201704.GC4453@wohnheim.fh-wedel.de>
In-Reply-To: <20050628201704.GC4453@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:
> On Tue, 28 June 2005 16:05:11 -0400, Robert Love wrote:
> 
>>I like the idea (I think someone suggested this early on) of renaming
>>the current MADV_DONTNEED to MADV_FREE and then adding a correct
>>MADV_DONTNEED.
> 
> 
> Imo, that's still a crime against common sense.  Madvice should give
> the kernel some advice about which data to keep or not to keep in
> memory, hence the name.  It should *not* tell the kernel to corrupt
> data, which currently appears to be the case.
> 
> If the application knows 100% that it is the _only_ possible user of
> this data and will never again use it, dropping dirty pages might be a
> sane option.  Effectively that translates to anonymous memory only.
> In all other cases, dirty pages should be written back.

There is also the case of shmget/shmat memory segments.  Some 
applications will use these in order to map a very large amount of 
memory and then madvise(MADV_DONTNEED) in order to play nice with the 
rest of the system should memory pressure / system load / etc require 
it.  Obviously if other tasks have these segments mapped, the pages 
cannot be discarded.  If a task is the sole "mapper" of the region and 
doesn't need that memory (ever again) it would be good to avoid the i/o 
overhead of swapping it out and just discarding it.  Perhaps 
MADV_DONTNEED isn't the right place for this, but there is demand for 
this behavior.

--Darren Hart

> 
> 
>>And, as I said, the man page needs clarification.
> 
> 
> Definitely.
> 
> Jörn
> 

