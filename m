Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263134AbUDZMjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263134AbUDZMjm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 08:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263129AbUDZMjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 08:39:42 -0400
Received: from mail.tpgi.com.au ([203.12.160.57]:34954 "EHLO mail1.tpgi.com.au")
	by vger.kernel.org with ESMTP id S263134AbUDZMhU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 08:37:20 -0400
Date: Mon, 26 Apr 2004 22:15:25 +1000
From: "Nigel Cunningham" <ncunningham@linuxmail.com>
To: "Herbert Xu" <herbert@gondor.apana.org.au>, 234976@bugs.debian.org
Subject: Re: Bug#234976: kernel-source-2.6.4: Software Suspend doesn't work
Cc: "Roland Stigge" <stigge@antcom.de>, "Pavel Machek" <pavel@suse.cz>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Reply-To: ncunningham@linuxmail.com
References: <1080310299.2108.10.camel@atari.stigge.org> <20040326142617.GA291@elf.ucw.cz> <1080315725.2951.10.camel@atari.stigge.org> <20040326155315.GD291@elf.ucw.cz> <1080317555.12244.5.camel@atari.stigge.org> <20040326161717.GE291@elf.ucw.cz> <1080325072.2112.89.camel@atari.stigge.org> <20040426094834.GA4901@gondor.apana.org.au> <20040426104015.GA5772@gondor.apana.org.au> <opr6193np1ruvnp2@laptop-linux.wpcb.org.au> <20040426121145.GA7610@gondor.apana.org.au>
Content-Type: text/plain; format=flowed; delsp=yes; charset=us-ascii
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <opr62cbzp9ruvnp2@laptop-linux.wpcb.org.au>
In-Reply-To: <20040426121145.GA7610@gondor.apana.org.au>
User-Agent: Opera M2/7.50 (Linux, build 663)
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 26 Apr 2004 22:11:45 +1000, Herbert Xu  
<herbert@gondor.apana.org.au> wrote:

> On Mon, Apr 26, 2004 at 09:27:13PM +1000, Nigel Cunningham wrote:
>>
>> There used to be such a check. Centrinos, however, if I recall  
>> correctly,
>> don't have PSE but can suspend with our current method. Perhaps we can
>
> Then it's just pure luck.  Whenever you have a page whose page table
> lies in a page beyond that page itself the non-PSE case will fail.

I'm no expert on the hardware side of things, but from what I know, it's  
really only these hardware devices that are accessing memory while we're  
doing the copyback that are the problem. All processes are stopped and  
we've called device_suspend(). Nothing but us should be using/modifying  
the page tables.

>> come up with a more nuanced test? Better still, though, we should just  
>> get
>> proper AGP support for suspending and resuming in.
>
> It's got nothing to do with AGP.  This is a flaw in the swsusp code.
> It can be triggered by anything that plays with page attributes.

Not so much a flaw in the suspend code as something that needs to be dealt  
with: it's not a bug for pages to have protection, and its not a bug for  
us to need it temporarily removed in order to do the copyback. We just  
need the support in the drivers to achieve that. When we have it (as we do  
in some cases in 2.4), all is well.

Regards,

Nigel
-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614, Australia.
+61 (2) 6251 7727 (wk)
