Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbVFZNbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVFZNbL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 09:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVFZNbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 09:31:11 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:2754 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261186AbVFZNbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 09:31:07 -0400
Message-ID: <42BEAE15.3020607@comcast.net>
Date: Sun, 26 Jun 2005 09:31:01 -0400
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pierre Ossman <drzeus-list@drzeus.cx>
CC: Bjorn Helgaas <bjorn.helgaas@hp.com>, LKML <linux-kernel@vger.kernel.org>,
       jgarzik@pobox.com
Subject: Re: 2.6.12 breaks 8139cp
References: <42B9D21F.7040908@drzeus.cx> <200506221534.03716.bjorn.helgaas@hp.com> <42BA69AC.5090202@drzeus.cx> <200506231143.34769.bjorn.helgaas@hp.com> <42BB3428.6030708@drzeus.cx> <42BCBB60.7000508@comcast.net> <42BD334A.9090900@drzeus.cx>
In-Reply-To: <42BD334A.9090900@drzeus.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman wrote:

>Ed Sweetman wrote:
>
>  
>
>>2.6.11-mm4 doesn't work. So i'm guessing 2.6.11 wont work either which
>>may be why backporting it's via fixes didn't do anything.  I'm gonna
>>try vanilla and if that by some crazy chance works, then it'll be
>>fairly easy to see what change did it since mm has a nice Changelog.
>>    
>>
>
>
>2.6.11 works fine here so if you're having problems with it I'd say
>we're experiencing two different bugs.
>
>Rgds
>Pierre
>  
>

It seems that whatever is causing the bug i'm seeing was a change that 
involved the network driver/interrupt subsystem and not actually the 
8139too driver, this was done at around 2.6.3-2.6.4.   A NAPI patch that 
was introduced at that time basically reverted the interrupt function 
and removed the poll functions from the driver (via not enabling napi in 
Kconfig).   I have patched 2.6.12.1 with the NAPI patch and it works.  
Now i just have  a problem with messages about "Badness in __kfree_skb 
at net/core/skbuff.c:290" coming from the changes i made in the 8139too 
driver flooding my logs.  (very bad but also helpful)

That narrows it down, but i was unable to clean up the kfree errors.
