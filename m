Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030231AbWHCX55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030231AbWHCX55 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 19:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030232AbWHCX55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 19:57:57 -0400
Received: from sccrmhc14.comcast.net ([63.240.77.84]:23533 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1030231AbWHCX54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 19:57:56 -0400
Message-ID: <44D28E4B.20605@elegant-software.com>
Date: Thu, 03 Aug 2006 20:01:15 -0400
From: Russell Leighton <russ@elegant-software.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Checksumming blocks? [was Re: the " 'official' point of view"
 expressed by kernelnewbies.org regarding reiser4 inclusion]
References: <200607312314.37863.bernd-schubert@gmx.de> <200608011428.k71ESIuv007094@laptop13.inf.utfsm.cl> <20060801165234.9448cb6f.reiser4@blinkenlights.ch> <1154446189.15540.43.camel@localhost.localdomain> <44CF84F0.8080303@slaphack.com> <1154452770.15540.65.camel@localhost.localdomain> <44CF9217.6040609@slaphack.com> <20060803135811.GA7431@merlin.emma.line.org> <44D285DF.7060905@elegant-software.com> <20060803233503.GB25727@merlin.emma.line.org>
In-Reply-To: <20060803233503.GB25727@merlin.emma.line.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thx, for a db this seems natural...

I am very curious about ZFS as I think we will seem more protection in 
the FS layer as disks get larger...
If I have a very old file I am now half way throught reading and ZFS 
finds a bad block, I assume I would
get some kind of read() error...but then what? Does anyone know if there 
are tools with ZFS to inspect the file?

Matthias Andree wrote:

>(I've stripped the Cc: list down to the bones.
>No need to shout side topics from the rooftops.)
>
>On Thu, 03 Aug 2006, Russell Leighton wrote:
>
>  
>
>>If the software (filesystem like ZFS or database like Berkeley DB)  
>>finds a mismatch for a checksum on a block read, then what?
>>    
>>
>
>(Note that this assumes a Berkeley DB in transactional mode.) Complain,
>demand recovery, set the panic flag (refusing further transactions
>except close and open for recovery).
>
>  
>
>>Is there a recovery mechanism, or do you just be happy you know there is 
>>a problem (and go to backup)?
>>    
>>
>
>Recoverability depends on log retention policy (set by the user or
>administrator) and how recently the block was written. There is a
>recovery mechanism.
>
>For applications that don't need their own recovery methods (few do),
>db_recover can do the job.
>
>In typical cases of power loss or kernel panic during write, the broken
>page will probably either be in the log so it can be restored (recover
>towards commit), or, if the commit hadn't completed but pages had been
>written due to cache conflicts, the database will be rolled back to the
>state before the interrupted transaction, effectively aborting the
>transaction.
>
>The details are in the Berkeley DB documentation, which please see.
>
>  
>

