Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280696AbRKFXvI>; Tue, 6 Nov 2001 18:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280699AbRKFXu6>; Tue, 6 Nov 2001 18:50:58 -0500
Received: from [195.63.194.11] ([195.63.194.11]:17417 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S280696AbRKFXut>; Tue, 6 Nov 2001 18:50:49 -0500
Message-ID: <3BE883BF.1025EC08@evision-ventures.com>
Date: Wed, 07 Nov 2001 01:43:43 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: dalecki@evision.ag, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Using %cr2 to reference "current"
In-Reply-To: <E161FVT-00029X-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > If we are talking about memmory bload. Let's usk a question. Is somebody
> > there
> > working seriously on changing the default function call conventions on
> > IA32
> 
> Thats pure noise
> 
> On a 256Mb machine you have 65536 page map entries. Those are 64 bytes but
> its not hard to get it down to 56 bytes (.5Mb saved) and probably to 48
> bytes. We can probably also shave 8 bytes off each cached inode if not
> more (the nfs changes in -ac are a big help there already) - thats typically
> another 200K on a reasonable size box - and the new bootmem code can save a
> chunk too
> 
> Im not sure how much the code change for function call patterns would be
> but I doubt its so big for such little effort

Please count the removal of the *very* sparse read_ahead array as
well (patch went to this list a long time ago) in.
It doesn't cost anything and saves some few pages depending on the
number of drivers you have loaded... (Well in comparision to the above
that's nit picking, but...) 

And then there is the overloaded struct inde. It would be worth
quite a bit of memmory to not overlay the private,filesystem 
specific parts but to attach them by a pointer instead, in esp.
if you make this in a way where the private part would be used 
without the public interface in drivers. Currently the most rudiculous
inode layout is deterministic for the overall size in the compiled
kernel.
