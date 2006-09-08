Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWIHH4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWIHH4k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 03:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbWIHH4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 03:56:40 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:56744 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750765AbWIHH4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 03:56:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=WDSMse4Okt450VWsSelpauK+B7aHOTOKM8V0o8wKUF5TpNjM0i+pSmQNqRXyfyhqyHTMkrM87hVGkzk9ZEJhzpi5x5f7gp5It74FIzTgT6XgACfwPwZrMdFfw4YyEau1FKQX0Dul79p0wD/K2sFka16fh8BeS5ZCBhUe2L5xDoE=
Message-ID: <45012222.20205@gmail.com>
Date: Fri, 08 Sep 2006 09:56:18 +0200
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "J.A. Magallon" <jamagallon@ono.com>
Subject: Re: [PATCH libata-dev#upstream-fixes] libata: ignore CFA signature
 while sanity-checking an ATAPI device
References: <20060901015818.42767813.akpm@osdl.org>	<20060904013443.797ba40b@werewolf.auna.net>	<20060903181226.58f9ea80.akpm@osdl.org>	<44FB929B.7080405@gmail.com>	<20060905002600.51c5e73b@werewolf.auna.net>	<44FFE7AF.8010808@gmail.com>	<20060907131327.494fd1c2@werewolf.auna.net>	<20060907113224.GA21853@htj.dyndns.org> <20060907132707.38e63155.akpm@osdl.org> <4500893D.6090907@pobox.com>
In-Reply-To: <4500893D.6090907@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Andrew Morton wrote:
>> You mean 2.6.18, yes?
> 
> Actually, it looks like it should indeed be 2.6.19 (libata #upstream), 
> not 2.6.18 (libata #upstream-fixes).  Alan's "add compactflash support" 
> patch isn't in 2.6.18-rc.
> 
> So, this should -not- be sent for 2.6.18.

Hello,

Yes, I meant .18.  Jeff, this should be fixed before 2.6.18 is released. 
  It's not the question of whether CFA support is implemented or not. 
We're sanity-checking in 2.6.18-rcX anyway and it's the sanity checking 
which is causing problem.  What seems to have happened is...

1. CFA support is implemented
2. CFA check was added (backported) to upstream-fixes, but it was incorrect.

So, we need to do one of two things.

* apply this patch to 2.6.18-rcX
* remove ata_id_is_cfa() check altogether

-- 
tejun
