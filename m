Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWDZX3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWDZX3T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 19:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWDZX3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 19:29:19 -0400
Received: from rtr.ca ([64.26.128.89]:20167 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751117AbWDZX3S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 19:29:18 -0400
Message-ID: <4450023B.4040802@rtr.ca>
Date: Wed, 26 Apr 2006 19:28:59 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] drivers/scsi/sd.c: fix uninitialized variable	in	handling
 medium errors
References: <200604261627.29419.lkml@rtr.ca>	 <1146092161.12914.3.camel@mulgrave.il.steeleye.com>	 <444FFC9B.4090603@rtr.ca> <1146093496.12914.11.camel@mulgrave.il.steeleye.com>
In-Reply-To: <1146093496.12914.11.camel@mulgrave.il.steeleye.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Wed, 2006-04-26 at 19:04 -0400, Mark Lord wrote:
>> Yes, but the difficulty there is that all of the convoluted logic
>> seems to still be wanted to set a correct "block_sectors" value,
>> needed as a parameter on the final call:
>>
>>     scsi_io_completion(SCpnt, good_bytes, block_sectors << 9);
> 
> Erm, but that's only used for volume overflow (or other single sector
> errors), which this isn't ... Actually, as far as I can tell, the whole
> block_sectors calculation can be killed as well.

I wonder if it can be done away with as a parameter for scsi_io_completion() ?
If not, then we'll need some nice big comments in that function to warn
against relying on a valid value for that parameter in specific cases.

Cheers
