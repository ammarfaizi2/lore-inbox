Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261376AbSIWVSd>; Mon, 23 Sep 2002 17:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261410AbSIWVSd>; Mon, 23 Sep 2002 17:18:33 -0400
Received: from AMarseille-201-1-5-7.abo.wanadoo.fr ([217.128.250.7]:4208 "EHLO
	zion.wanadoo.fr") by vger.kernel.org with ESMTP id <S261376AbSIWVSb>;
	Mon, 23 Sep 2002 17:18:31 -0400
From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Marcelo Tosatti" <marcelo@conectiva.com.br>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20pre7, aic7xxx-6.2.8: Panic: HOST_MSG_LOOP with invalid
 SCB 0
Date: Mon, 23 Sep 2002 08:35:31 +0200
Message-Id: <20020923063531.30270@192.168.4.1>
In-Reply-To: <Pine.LNX.4.44.0209231350390.973-100000@freak.distro.conectiva>
References: <Pine.LNX.4.44.0209231350390.973-100000@freak.distro.conectiva>
X-Mailer: CTM PowerMail 4.0.1 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> This issue has already been resolved as a chipset issue requiring
>> I/O mapped register access to work around.  The "old" aic7xxx driver
>> avoids these issues by issuing a register read after every register
>> write.  This stops up your PCI bus with wasted cycles even if you have
>> a perfectly working chipset.
>>
>> So, how would you like me to resolve this.  We can do the same thing
>> as Adaptec's windows drivers and just always use the slower, less
>> efficient I/O mapped method for accessing registers.  This will "fix"
>> the problems people have with broken VIA and Intel chipsets.  I can
>> make this a compile and run-time option, but should we default to
>> I/O mapped or memory mapped?
>>
>> Don't you just love broken PC hardware?
>
>Its all fine, then: I thought the problems were caused by some bug in the
>driver itself.
>
>Thanks for explaining me the issue clearly. :)

Hi Justin ! What is the actual breakage here ? Is this just PCI write
posting ? (that is PCI writes staying in bridge write buffer for
some time until you flush the whole path with a read). In this
case those intel & VIA chipsets aren't at fault as this is perfectly
legal per PCI spec and we'll have problem with all other sort of
machines, especially machines with stacked PCI<->PCI bridges like
it's the case for most pmacs.

Or is there a real Intel/VIA bug regarding PCI write buffers ?

I doubt it would affect only Adaptec cards then...

Ben.


