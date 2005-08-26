Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932547AbVHZHVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932547AbVHZHVb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 03:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbVHZHVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 03:21:31 -0400
Received: from web25802.mail.ukl.yahoo.com ([217.12.10.187]:16228 "HELO
	web25802.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932547AbVHZHVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 03:21:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=d0mqPskSHuXI/0vkeUhieV//wOORWda/3y9tzKtdRiiqnQj7iSFlgXgq2hkqZfOD8ILeyxNM1gGBzL54/r3ULKsiHP95KNDAbxc7mJGR1ZfrtUhbtvN6yF/1dbHKygKlH/zAkJwzloTsGQGvfGvFKS67RpGWSMsELhdjB4i4dOc=  ;
Message-ID: <20050826072129.71855.qmail@web25802.mail.ukl.yahoo.com>
Date: Fri, 26 Aug 2005 09:21:29 +0200 (CEST)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: question on memory barrier
To: Andy Isaacson <adi@hexapodia.org>
Cc: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <20050825145445.GD7319@hexapodia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Andy Isaacson <adi@hexapodia.org> a écrit :
> 
> Did you *read* the post?
> 
> # The _only_ acceptable use of "volatile" is basically:
> # 
> # - in _code_ (not data structures), where we might mark a place as making
> #   a special type of access. For example, in the PCI MMIO read functions,
> #   rather than use inline assembly to force the particular access (which
> #   would work equally well), we can force the pointer to a volatile type.
> 
> That's *exactly* what the writel you quote above does!

OK but he speaks about special type of access, no ordering constraint.
I don't think that MIPS cpu reorder memory access, but gcc can ! And I
don't think that the use of 'volatile' can prevent it to do that.


> To return to the point directly at hand - on MIPS architectures to date,
> simply doing your memory access through a "volatile u32 *" is sufficient
> to ensure that the IO hits the bus (assuming that your pointer points to
> kseg1, not kseg0, or is otherwise uncached), because 'volatile' forces
> gcc to generate a "sw" for each store, and all MIPS so far have been
> designed so that multiple uncached writes to mmio locations do generate
> multiple bus transactions.

ok thanks for this, but once again, there's no ordering constraint garantuee.

> 
> I'm not an architect, but I think it would be possible to build a MIPS
> where this was not the case, and require additional contortions from
> users.  Such a MIPS would suck to program and would probably fail in the
> marketplace, and there's no compelling benefit to doing so; ergo, I
> would expect "volatile" to continue to be sufficient on MIPS.
> 

I hope so...It's hard to find out an answer to such questions (maybe
it's the case only for MIPS arch) although it's an important point.

Thanks.
             Francis


	

	
		
___________________________________________________________________________ 
Appel audio GRATUIT partout dans le monde avec le nouveau Yahoo! Messenger 
Téléchargez cette version sur http://fr.messenger.yahoo.com
