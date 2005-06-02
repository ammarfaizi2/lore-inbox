Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbVFBBiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbVFBBiw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 21:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbVFBBiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 21:38:52 -0400
Received: from mail.tmr.com ([64.65.253.246]:28550 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S261558AbVFBBhk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 21:37:40 -0400
Message-ID: <429E62C1.2040605@tmr.com>
Date: Wed, 01 Jun 2005 21:37:05 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Matthias Andree <matthias.andree@gmx.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux does not care for data integrity
References: <20050515152956.GA25143@havoc.gtf.org> <20050516.012740.93615022.okuyamak@dd.iij4u.or.jp> <42877C1B.2030008@pobox.com> <20050516110203.GA13387@merlin.emma.line.org> <1116241957.6274.36.camel@laptopd505.fenrus.org> <20050516112956.GC13387@merlin.emma.line.org> <1116252157.6274.41.camel@laptopd505.fenrus.org> <20050516144831.GA949@merlin.emma.line.org> <1116256005.21388.55.camel@localhost.localdomain> <87zmudycd1.fsf@stark.xeocode.com> <20050529211610.GA2105@merlin.emma.line.org> <429E062B.60909@tmr.com> <429E5483.3020404@pobox.com>
In-Reply-To: <429E5483.3020404@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Bill Davidsen wrote:
>
>> This would change the meaning of fsync from "force out the data" to 
>> "wait for the data to be written" in some implementations.
>
>
> This is the meaning of fsync:  copies all in-core parts of a file to 
> disk, and waits until the device reports that all parts are on stable 
> storage.
>
> Anything less is a bug. 


How about anything more? The truth is that much common hardware doesn't 
really make the cache to disk move visible, and turning off cache really 
hurts performance. And it would appear that fsync force a lot more data 
out of memory than just the blocks for the file in question.

However, the point I was making is that it would be useful to be able to 
tell when the write to non-volatile took place, not to force that to 
happen. Not to do anything which would flush a lot of other stuff and 
busy the drive. What I suggest is NOT fsync, just a way to assure ordering.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

