Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266508AbUHVLdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266508AbUHVLdO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 07:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266650AbUHVLdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 07:33:14 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:42171 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S266508AbUHVLdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 07:33:11 -0400
From: "R. J. Wysocki" <rjw@sisk.pl>
Organization: SiSK
To: gene.heskett@verizon.net
Subject: Re: Possible dcache BUG
Date: Sun, 22 Aug 2004 13:42:54 +0200
User-Agent: KMail/1.5
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408201617.09245.gene.heskett@verizon.net> <200408220105.25734.gene.heskett@verizon.net>
In-Reply-To: <200408220105.25734.gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408221342.54563.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 of August 2004 07:05, Gene Heskett wrote:
> On Friday 20 August 2004 16:17, Gene Heskett wrote:
> >On Friday 20 August 2004 16:11, R. J. Wysocki wrote:[...]
> >
> >>There's a simple test you can do unless your DIMMs must go in pairs
> >> (I don't remember if it's required by nforce2): remove one of them
> >> and see what happens.
> >
> >To get dual channel DDR, they have to be in a pair.  Since this
> > post, they've been swapped one for the other, and I'll be curious
> > to see if the address goes to an even address when it errors, which
> > it hasn't yet.
>
> It has, one time in 35 hours now.  The problem is considerably
> reduced.
>
> Whereas the error was always at an odd address, and in the 2nd LSbyte,
> now its still an odd address but the error has moved to the MSB of a
> 32 bit fetch:
>
> [root@coyote memburn]# ./memburn 512
> Starting test with size 512 megs..
> Passed round 2308, elapsed 41225.98.
> FAILED at round 2309/40220063: got ff000000, expected 00000000!!!
> REREAD: ff000000, ff000000, ff000000!!!
> [root@coyote memburn]# ./memburn 512
> Starting test with size 512 megs..
> Passed round 2636, elapsed 60944.15.
>
> As can be seen, I restarted it, and its ran quite even more loops now
> without error.  There has been no more Oops, but with memburn eating
> 512 megs, half my ram, and kde-3.3 under construction by konstruct,
> I've peaked at nearly a gig of swap, and 754 megs in swap right now.
> Sure, its a bit laggy, but not unusable.
>
> So now the question is since the error address is always odd, which
> stick is it?

Hard to tell.  I think the memory controller is interleaving them for 
efficiency but the question remains which one is regarded as the first.

BTW, as it indicates that DRAM is to blame, you can try to fiddle a bit with 
its timings (provided the board setup allows you to do this).  For example, 
you can set them to 3-3-3 or equivalent (generally, push them up) and check 
if this affects the memburn results and how.  Just an idea, you know. ;-)

Greetings,
-- 
Rafael J. Wysocki
----------------------------
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
