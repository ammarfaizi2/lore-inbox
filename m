Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268003AbUH2PLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268003AbUH2PLb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 11:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268008AbUH2PLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 11:11:31 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:48272 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S268003AbUH2PK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 11:10:57 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: gene.heskett@verizon.net, linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Sun, 29 Aug 2004 17:21:12 +0200
User-Agent: KMail/1.5
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408250913.23840.vda@port.imtp.ilyichevsk.odessa.ua> <200408290948.47890.gene.heskett@verizon.net>
In-Reply-To: <200408290948.47890.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408291721.13192.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 29 of August 2004 15:48, Gene Heskett wrote:
> On Wednesday 25 August 2004 02:13, Denis Vlasenko wrote:
> >On Wednesday 25 August 2004 04:49, Tom Vier wrote:
> >> On Mon, Aug 23, 2004 at 11:08:41PM -0400, Gene Heskett wrote:
> >> > >are you translating virt->phys?
> >> >
> >> > No, this is straight out of the memburn output (after I'd fixed
> >> > the
> >>
> >> that's weird that you're finding that pattern in virtual
> >> addresses. i wouldn't expect that. even if you're booting to
> >> single user, certain variables might change during boot and cause
> >> different physical pages to be mapped. maybe single user is more
> >> deterministic than i think, though.
> >
> >On x86, pages are aligned at 4k. Lower 12 bits of virtual address
> >match lower 12 bits of corresponding real address.
> >
> >So, yes, if you hit bad RAM cell, you see random virtual address,
> > but three last digits of it (in hex) must be the same.
>
> I think, based on the last 25 hours of running both memburn and
> setiathome at a -nice 19, and there have been no errors, that I might
> have stumbled onto a fix.
>
> It seems the dram is marked DDR400, so I was trying to run it that
> way.  Unforch, on checking the invoice for the umpteenth time, it
> finally dawned on me that this particular AMD 2800XP is supposedly a
> 333mhz FSB chip, and not rated for use with DDR400 memory.  Switching
> the bios setting for the memory to 'auto' from 'spd' seems to effect
> this particular item, and the memory now signs in as DDR333 Dual
> Channel.
>
> And after 25 hours, no errors, nothing unusual in the logs.
>
> I guess I should go paint my face with egg or something...

Not necessarily.  :-)  Some mobos based on the nforce2 chipsets should be able 
to clock FSB and memory asynchronously.   The very fact that you can set the 
memory clock separately in the BIOS indicates that your mobo is one of these.  
So, if it runs well at synchronous FSB and memory clock rates, but causes 
problems otherwise, the northbridge is probably fishy.  Or the memory is not 
up to the spec.  Anyway, the symptoms are quite "interesting" and it's good 
to know what they are.

Regards,
RJW

-- 
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
