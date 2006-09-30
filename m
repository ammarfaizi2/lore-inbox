Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbWI3RUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWI3RUw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 13:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWI3RUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 13:20:52 -0400
Received: from smtpout.mac.com ([17.250.248.177]:8176 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751315AbWI3RUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 13:20:50 -0400
In-Reply-To: <20060930162141.GB16272@parisc-linux.org>
References: <20060928014623.ccc9b885.akpm@osdl.org> <20060929155738.7076f0c8@werewolf> <20060929143949.GL5017@parisc-linux.org> <1159550143.13029.36.camel@localhost.localdomain> <20060929235054.GB2020@slug> <1159629982.14918.4.camel@mulgrave.il.steeleye.com> <20060930162141.GB16272@parisc-linux.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <921FE7F4-279D-4470-982A-18A871D6209C@mac.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Frederik Deweerdt <deweerdt@free.fr>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "J.A. Magall??n" <jamagallon@ono.com>, Andrew Morton <akpm@osdl.org>,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Mark Rustad <mrustad@mac.com>
Subject: Re: 2.6.18-mm2
Date: Sat, 30 Sep 2006 12:20:21 -0500
To: Matthew Wilcox <matthew@wil.cx>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 30, 2006, at 11:21 AM, Matthew Wilcox wrote:

> On Sat, Sep 30, 2006 at 10:26:22AM -0500, James Bottomley wrote:
>> On Fri, 2006-09-29 at 23:50 +0000, Frederik Deweerdt wrote:
>>> +       if (!pdev->irq)
>>> +               return -ENODEV;
>>> +
>>
>> Don't I remember that 0 is a valid IRQ on some platforms?
>>
>> i.e. shouldn't this be
>>
>> if (pdev->irq == NO_IRQ)
>> 	return -ENODEV;
>>
>> ?
>>
>> I think this won't quite work because only the platforms that  
>> actually
>> have a valid zero irq define it, but there must be something else  
>> that
>> works.
>
> Linus threw a hissy fit and declared that platforms which use 0 as a
> valid IRQ are broken and wrong.  Despite PCI using 255 to mean no IRQ
> and 0 as a valid IRQ ;-)

Having gone down the path of creating a platform that had IRQ 0 as a  
valid interrupt some time ago with the 2.4 kernel, all I can say is  
that while it can be made to work, things go much more smoothly if  
you don't use IRQ 0. Every driver added to the environment pretty  
much had to be tweaked. Of course that mainly meant adding to the  
#ifdef's that were already there for other architectures that had  
also made that mistake.

The biggest pain is admitting the mistake (of using IRQ 0) and  
changing it. Making a clear statement on the issue will help prevent  
others from making the same mistake again. I know that I wish that I  
had known not to do that from the beginning. Having been there and  
done that, I don't need any convincing.

-- 
Mark Rustad, MRustad@mac.com

