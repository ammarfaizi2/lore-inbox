Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbVFATux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVFATux (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 15:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVFATuC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 15:50:02 -0400
Received: from smtpq2.home.nl ([213.51.128.197]:4067 "EHLO smtpq2.home.nl")
	by vger.kernel.org with ESMTP id S261197AbVFATrr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 15:47:47 -0400
Message-ID: <429E1049.20903@keyaccess.nl>
Date: Wed, 01 Jun 2005 21:45:13 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a6) Gecko/20050111
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Petr Vandrovec <vandrove@vc.cvut.cz>
CC: Mark Lord <lkml@rtr.ca>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       David Brownell <dbrownell@users.sourceforge.net>
Subject: Re: External USB2 HDD affects speed hda
References: <429BA001.2030405@keyaccess.nl> <429DA0A9.6010808@rtr.ca> <429DFEBF.8090908@keyaccess.nl> <429E0965.1090809@vc.cvut.cz>
In-Reply-To: <429E0965.1090809@vc.cvut.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:

> Rene Herman wrote:

>> No, that's not it. Both ide0 (14) and EHCI (3) are on private, 
>> unshared IRQs. rmmodding ehci_hcd as per Pavel's sugestion gets me 
>> back my speed. Exactly _why_ I've no idea though. I've just added you 
>> to the CC on that reply...
> 
> 
> Because EHCI hardware continuously watches some memory area to
> find whether there are some transfers from host to your USB
> devices ready...  You just need better memory bandwidth so all
> your devices transfers fit on your bus.  Or maybe EHCI driver
> could program hardware to not query transfer descriptors
> that often. But it would increase latency for people
> who use USB only and do not care about other parts of system.

I see. I was totally unaware of that, many thanks for the information. 
Getting more memory bandwidth (to/from the PCI bus at least) will have 
to wait for my next system, I suppose.

Added EHCI maintainer to this one as well. If possible, this looks like 
a good candidate for a /proc or /sys knob?

Or maybe even starting out with a low querying frequency and dynamically 
adjusting it up (and down again!) with traffic? Probably not that. I'd 
like to have the knob though, so that I can have EHCI builtin and still 
tell the controller to take it easy (certainly after I've switched of 
the external HDD again, but on this system possibly also while in use).

Rene.
