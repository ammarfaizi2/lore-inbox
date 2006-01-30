Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbWA3PBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWA3PBp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 10:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbWA3PBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 10:01:44 -0500
Received: from mail.dvmed.net ([216.237.124.58]:37085 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932301AbWA3PBn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 10:01:43 -0500
Message-ID: <43DE2A47.2030607@pobox.com>
Date: Mon, 30 Jan 2006 10:01:27 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH] libata queue updated
References: <20060128182522.GA31458@havoc.gtf.org> <200601291711.43426.ioe-lkml@rameria.de> <43DDBA71.6040402@gmail.com>
In-Reply-To: <43DDBA71.6040402@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Tejun Heo wrote: > Ingo Oeser wrote: > >> Hi Jeff, >>
	>> >> On Saturday 28 January 2006 19:25, Jeff Garzik wrote: >> >>>
	Testing and merge point in Tejun's flood of patches :) The patch >>>
	below is against current linux-2.6.git. >> >> >> These
	"function(unsigned int *classes)" style functions in >> "libata-core.c"
	worry me somewhat. Esp. that sometimes you have one >> class, >>
	sometimes two. >> This looks like a bug waiting to happen for me. >> >>
	Could we somehow get a >> struct ata_classes { >> unsigned int master;
	>> unsigned int slave; >> } >> >> here (or similiar), before this is in
	used everywhere? >> >> Usage would be function(struct ata_classes
	*classes) then. >> > > Hello, > > I object. Using array is intentional.
	Slave aware controllers (PATA / > ata_piix) will use [0..1], most SATA
	controllers will use only [0], and > PM aware ones will use [0..15].
	The intention was requiring low level > drivers of only what they know
	and normalize them in the core layer. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Ingo Oeser wrote:
> 
>> Hi Jeff,
>>
>>
>> On Saturday 28 January 2006 19:25, Jeff Garzik wrote:
>>
>>> Testing and merge point in Tejun's flood of patches :)  The patch
>>> below is against current linux-2.6.git.
>>
>>
>> These "function(unsigned int *classes)" style functions in 
>> "libata-core.c" worry me somewhat.  Esp. that sometimes you have one 
>> class,
>> sometimes two.
>> This looks like a bug waiting to happen for me.
>>
>> Could we somehow get a
>> struct ata_classes {
>>     unsigned int master;
>>     unsigned int slave;
>> }
>>
>> here (or similiar), before this is in used everywhere?
>>
>> Usage would be function(struct ata_classes *classes) then.
>>
> 
> Hello,
> 
> I object.  Using array is intentional.  Slave aware controllers (PATA / 
> ata_piix) will use [0..1], most SATA controllers will use only [0], and 
> PM aware ones will use [0..15].  The intention was requiring low level 
> drivers of only what they know and normalize them in the core layer.

Yep, that's fine.

We don't need to be writing code for the case where somebody doesn't 
know the C language.

	Jeff



