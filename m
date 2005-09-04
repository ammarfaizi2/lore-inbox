Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbVIDNNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbVIDNNj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 09:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbVIDNNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 09:13:39 -0400
Received: from smtp8.libero.it ([193.70.192.92]:7661 "EHLO smtp8.libero.it")
	by vger.kernel.org with ESMTP id S1750814AbVIDNNi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 09:13:38 -0400
From: "Giampaolo Tomassoni" <g.tomassoni@libero.it>
To: "Francois Romieu" <romieu@fr.zoreil.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-atm-general@lists.sourceforge.net>
Subject: R: [Linux-ATM-General] [ATMSAR] Request for review - update #1
Date: Sun, 4 Sep 2005 15:13:19 +0200
Message-ID: <NBBBIHMOBLOHKCGIMJMDCEICEKAA.g.tomassoni@libero.it>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20050904120047.GA6556@electric-eye.fr.zoreil.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Importance: Normal
X-Scanned: with antispam and antivirus automated system at libero.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Messaggio originale-----
> Da: linux-atm-general-admin@lists.sourceforge.net
> [mailto:linux-atm-general-admin@lists.sourceforge.net]Per conto di
> Francois Romieu
> Inviato: domenica 4 settembre 2005 14.01
> A: Giampaolo Tomassoni
> Cc: linux-kernel@vger.kernel.org;
> linux-atm-general@lists.sourceforge.net
> Oggetto: Re: [Linux-ATM-General] [ATMSAR] Request for review - update #1
> 
> 
> Giampaolo Tomassoni <g.tomassoni@libero.it> :
> [...]
> > However, I'm still hearing for your comments about the usefulness of an
> > ATMSAR layer.
> 
> Afaik all but one pci ADSL modems are out of tree drivers and 
> include various
> level of proprietary code. If Duncan is not interested in 
> changing its code,
> the usefulness remains to be proven.

Well, the idea is that more pci devices may appear, as adsl-enabled embedded systems will begin to appear in the market.

Also, I believe that adsl will carry much more services then just AAL5 for internet connection in the future. Even if the ATMSAR actually lacks of AAL1 and AAL2/3 capabilities, adding them in a single, specialized module is much easier than swimming in a usb+atm middle layer.

Finally, the fact that ATMSAR is device-unspecific makes it easier to maintain, I guess.


> The codingstyle is broken. Please read again Documentation/CodingStyle,

That's a matter of taste: even Linus burned the GNU coding style book...

However, if it is needed by the linux community, I shurely will fix it whenever the ATMSAR idea will get passed: I'm just gathering feedbacks like the previous one you expressed.


> remove the redundant typedef

Oh, you mean the "typedef enum _HECSTS ..." ?

You're right, thanks.


> and the silly comments ("Reserve 
> header space",
> Encode packet into cells", ...).

I would prefer to explain better what the ATMSAR is doing there. So, I'll get your as a "clarify silly comments". Ok?


> - &page[strlen(page)] in atmProcRead sucks.

Why? It is preceded by an strcpy(page,...). A constant would be worse if someone changes the prefix string...

Or is a page (a pointer) + strlen(page) (an integer) preferred over a closed syntax?


> - "return" is not a function.

Not even for() or while(). But doesn't they look cute this way?


> - consider 'goto' to handle the errors instead of deep nesting

I prefer not using goto when not required to. Nesting is far more readable to my opinion. Compilers do work fine with both.

Anyway, which are the functions you are objecting?


> - +const atmsar_aalops_t opsAALR = {
>   +       ATM_AAL0,
>   +       "raw",
>   -> use .foo = baz instead.

atmasr_aalops_t is not an exported structure (you'll find just an opaque definition in include/linux/atmsar.h), so it is not meant to be statically declared by device drivers. But I guess that the problem is readability, right?

Ok, I'm going to consider your hint in the next patch version.


> drivers/net/*c may give some hint.
> 
> --
> Ueimor

Thank you for your help.

May I ask if this is just your own contribution or if you are in charge of something in the linux and/or linux-atm projects?

Regards,

-----------------------------------
Giampaolo Tomassoni - IT Consultant
Piazza VIII Aprile 1948, 4
I-53044 Chiusi (SI) - Italy
Ph: +39-0578-21100

