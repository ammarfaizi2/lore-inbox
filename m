Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264853AbTAJKnJ>; Fri, 10 Jan 2003 05:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264867AbTAJKnJ>; Fri, 10 Jan 2003 05:43:09 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:19089
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264853AbTAJKnH>; Fri, 10 Jan 2003 05:43:07 -0500
Subject: Re: Problem in IDE Disks cache handling in kernel 2.4.XX
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: fverscheure@wanadoo.fr
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Andre Hedrick <andre@linux-ide.org>
In-Reply-To: <20030110095558.E144CFF11@postfix4-1.free.fr>
References: <20030110095558.E144CFF11@postfix4-1.free.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042198670.28469.45.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 10 Jan 2003 11:37:52 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-10 at 09:54, Francis Verscheure wrote:
> In fact for ATA/ATAPI 5 cfs_enable_2  has no meaning.  The fields to test are 
> write cache bits in command_set_1 and cfs_enable_1.
> And in both cases the FLUSH CACHE command ALWAYS EXISTS !
> The test of cfs_enable_2 must only be used for ATA/ATAPI 6 drives to use 
> FLUSH CACHE or FLUSH CACHE EXT in case of 48 bit addressing mode.

Thanks for the report. I need to go reread the spec before I can
definitively comemnt on this.

> And it seems to me that when an IDE drive has a cache enabled wcache must be 
> initialized to say so ? Or you have to do a STANDY or SLEEP before APM 
> suspend or power off to be sure that the cache has been written to the disk.

Technically - no. In the real world its a very very good idea

> I had a look at patch 2.4.21pre3 and the code looks the same.
> 
> And by the way how are powered off the IDE drives ?
> Because a FLUSH CACHE or STANDY or SLEEP is MANDATORY before powering off the 
> drive with cache enabled or you will enjoy lost data

IDE disagrees with itself over this but when we get a controlled power
off we do this. The same ATA5/ATA6 problem may well be present there
too. I will review both


Any specific opinion Andre ?

