Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263875AbUHBV4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263875AbUHBV4s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 17:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264002AbUHBVzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 17:55:06 -0400
Received: from mail1.fw-sj.sony.com ([160.33.82.68]:46038 "EHLO
	mail1.fw-sj.sony.com") by vger.kernel.org with ESMTP
	id S263875AbUHBVxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 17:53:13 -0400
Message-ID: <410EB8A7.1090101@am.sony.com>
Date: Mon, 02 Aug 2004 14:56:55 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Todd Poynor <tpoynor@mvista.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dsingleton@mvista.com, vda@port.imtp.ilyichevsk.odessa.ua,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Configure IDE probe delays
References: <20040730191100.GA22201@slurryseal.ddns.mvista.com> <1091226922.5083.13.camel@localhost.localdomain>
In-Reply-To: <1091226922.5083.13.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
 > Crowd of "my old crapbox no longer boots with newer kernel, wtf?" people
 > won't be happy at all.
 >
 > +               ide_delay = simple_strtoul(s+10,NULL,0);
 > +               printk(" : Delay set to %dms\n", ide_delay);
 > +               return 1;
 >
 > Can we have a bit louder warning here?

We can make this even stronger if desired.

Alan Cox wrote:
> On Gwe, 2004-07-30 at 20:11, Todd Poynor wrote:
> 
>>IDE initialization and probing makes numerous calls to sleep for 50
>>milliseconds while waiting for the interface to return probe status and
>>such. 
> 
> 
> Please make it taint the kernel if you do that so we can ignore all the
> bug reports.

We can certainly make the warning louder as Denis suggests, and also
make the wording in the documentation stronger, like so...

+ "ide-delay=xx"		: set delay in milliseconds for initialization and
+			  probing.  Defaults to 50ms.  Use at your own risk.  Please
+			  do not report ANY problems to kernel developers if using a
+			  non-default setting.

If needed, I'd be willing to taint the kernel to reduce the burden
of related bug reports.  I'm a little concerned that tainting conveys
a meaning of GPL conformance questionability, which would not be the
case here. (Just configuration questionability...  ;-)

This is primarily to support embedded systems with known hardware, but
I *DO* see the need to avoid having desktop people experiment with it
and make themselves (and by transitivity kernel developers) unhappy.

This is, admittedly, introducing a gun which one might use to shoot
one's own foot.  However, in my testing these delays accounted
for about 70% of total kernel bootup time, and this is a pretty easy
way to "fix" it.  I know many companies are very willing to bear
the burden of testing this out on their hardware before shipping
products (Sony would), in exchange for the dramatic bootup time
savings.

I'm still considering Jeff's comment, and I'll respond to that separately.

=============================
Tim Bird
Architecture Group Co-Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
E-mail: tim.bird@am.sony.com
=============================
