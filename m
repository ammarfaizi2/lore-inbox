Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWA3HE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWA3HE0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 02:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbWA3HEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 02:04:25 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:53062 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932118AbWA3HEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 02:04:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=SxZR58OP0rmR9zU3uHzFet4NGoO62MdGIxaKr9+7ZKB70SfFha/BSA6uQxVWCBJwfqu2w0mCgY9WC4ainfpcvw4/dop+te/1xZqLDHDK1Min7mi1tizzvl81yzy71wO9q0DUB4AHgV1Wu9j6kxEqSDQheP4OJVt+5E991Z2iaLQ=
Message-ID: <43DDBA71.6040402@gmail.com>
Date: Mon, 30 Jan 2006 16:04:17 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Ingo Oeser <ioe-lkml@rameria.de>
CC: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH] libata queue updated
References: <20060128182522.GA31458@havoc.gtf.org> <200601291711.43426.ioe-lkml@rameria.de>
In-Reply-To: <200601291711.43426.ioe-lkml@rameria.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:
> Hi Jeff,
> 
> 
> On Saturday 28 January 2006 19:25, Jeff Garzik wrote:
>> Testing and merge point in Tejun's flood of patches :)  The patch
>> below is against current linux-2.6.git.
> 
> These "function(unsigned int *classes)" style functions in 
> "libata-core.c" worry me somewhat.  Esp. that sometimes you have one class,
> sometimes two.
> This looks like a bug waiting to happen for me.
> 
> Could we somehow get a 
> 
> struct ata_classes {
> 	unsigned int master;
> 	unsigned int slave;
> }
> 
> here (or similiar), before this is in used everywhere?
> 
> Usage would be function(struct ata_classes *classes) then.
> 

Hello,

I object.  Using array is intentional.  Slave aware controllers (PATA / 
ata_piix) will use [0..1], most SATA controllers will use only [0], and 
PM aware ones will use [0..15].  The intention was requiring low level 
drivers of only what they know and normalize them in the core layer.

eg. Current std SATA reset routines consider the argument as *class (a 
single class value) and it's intentional.  As long as a lldd is aware of 
only one device per port, it's allowed/recommeded to consider the passed 
classes argument as a pointer to single class value.  The rest is upto 
the core libata layer.

-- 
tejun
