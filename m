Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265032AbTGKTH4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 15:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265110AbTGKTHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 15:07:50 -0400
Received: from smtp3.wanadoo.fr ([193.252.22.25]:44745 "EHLO
	mwinf0603.wanadoo.fr") by vger.kernel.org with ESMTP
	id S265100AbTGKTGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 15:06:14 -0400
Message-ID: <3F0F2667.7090103@enib.fr>
Date: Fri, 11 Jul 2003 21:04:39 +0000
From: xi <xizard@enib.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: AMD760MPX: bogus chispset ? (was PROBLEM: sound is stutter,	sizzle
 with lasts kernel releases)
References: <3F0EED9B.4080502@enib.fr> <1057943291.20629.30.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1057943291.20629.30.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Gwe, 2003-07-11 at 18:02, xi wrote:
> 
>>Now I have done some investigations, and I think I have found the 
>>problem: It has appeared between kernel-2.4.18-pre9 and kernel-2.4.18-rc1
>>If I am not wrong, between these two versions, Alan Cox did a change in 
>>drivers/pci/quirks.c and this is this change which cause the problem.
> 
> 
> As I read the documentation the other change is also required in this
> situation to avoid a chipset lockup. It might be worth you rechecking
> the AMD errata docs for 762/768 again to be sure I didnt screw up and
> there are not newer rules for other revisions. 
> 

Ok, I have rechecked the errata docs. I have not found any 
recommandation change for PCI compliance configuration registers.

And one interesting thing:
in the AMD762 datasheet (24462.pdf) page 231 (Recommanded BIOS 
settings), I can see this: "Numerical Values shown with h or b are 
preferred settings." ; and AMD recommand this:
-> set bits 2 and 1 of register 0x4C to "0b"
-> set bits 23 and 3 respectively to "0b" and "1b"

I can confirm that these settings works much more better, even if they 
don't exactly follow PCI specs. And I don't think this is specific to my 
  cards since I have tested others.
Furthermore, my AMD762 is revision B1 (just before the last one: C0), 
and my AMD768 revision is B2, the last one.

Would you accept I make a patch which doesn't make any change in these 
registers at least up to AMD762 revision B1 (ie keeping recommanded 
values from AMD) ?
Or could you propose an other solution ?


Regards,
					Xavier

-- 
E-mail:
ctrl.alt.sup@free.fr xizard@chez.com
Please no longer use xizard@enib.fr, this e-mail will be removed soon.

Homepage:
http://xizard.free.fr
http://www.chez.com/xizard/

