Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270291AbTHLM0b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 08:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270295AbTHLM0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 08:26:31 -0400
Received: from www.13thfloor.AT ([212.16.59.250]:26304 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S270291AbTHLM03 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 08:26:29 -0400
Date: Tue, 12 Aug 2003 14:26:39 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3 cannot mount root fs
Message-ID: <20030812122639.GA27114@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Norbert Preining <preining@logic.at>,
	linux-kernel@vger.kernel.org
References: <3F34D0EA.8040006@rogers.com> <20030810211745.GA5327@gamma.logic.tuwien.ac.at> <20030810154343.351aa69d.akpm@osdl.org> <20030811053437.GA19040@gamma.logic.tuwien.ac.at> <20030811145940.GF4562@www.13thfloor.at> <20030811154009.GE6763@gamma.logic.tuwien.ac.at> <20030811185326.GB25186@www.13thfloor.at> <20030811215058.GA24474@gamma.logic.tuwien.ac.at> <20030811222134.GA10481@www.13thfloor.at> <20030812053956.GA7108@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030812053956.GA7108@gamma.logic.tuwien.ac.at>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 12, 2003 at 07:39:56AM +0200, Norbert Preining wrote:
> On Die, 12 Aug 2003, Herbert Pötzl wrote:
> > > > -----------
> > > > VFS: Cannot open root device "hdb1" or unknown-block(0,0)
> > > > Please append a correct "root=" boot option
> > > > -----------
> > > 
> > > Yes, it is like this.
> > 
> > like or exactly like? 
> 
> Ok, here is the exact output with different root= options:

now this makes some sense ...

> root=/dev/hdb1
> 	Cannot open root device "<NULL>" or hdb1
> 	Please append a correct "root=" boot option

here obviously root wasn't set to a string, but
device hdb1 is passed as in kernel setting?

> root=0341
> 	Cannot open root device "0341" or hdb1
> 	Please append a correct "root=" boot option

this seems correct, but maybe some bug kicks in ...

> root=03:41
> 	Cannot open root device "03:41" or unknown-block(0,0)
> 	Please append a correct "root=" boot option
> 
> root=03:65
> 	Cannot open root device "03:65" or unknown-block(0,0)
> 	Please append a correct "root=" boot option

the other options are obviously passed as root=
but can not be interpreted/resolved to a device

my assumption would be that you use the lilo root option
and do not pass the root= as kenel boot option ...

I would suggest to give append="root=/dev/hdb1" a try,
and/or update lilo or change to grub ...

> > (as well as the lines regarding hdb discovery ;)
> 
> Why? Isnt't this line what you meant: (From my previous email)

because IC35L040AVER07-0 .... is very unlikely to be a kernel message ...

> > > hdb: IC35L040AVER07-0 ....
> ...
> > > hdb: max request size 128 KiB
> > > hdb: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=79780/16/63, UDMA(100)
> > >         hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 hdb6 hdb7 hdb8 hdb9 hdb10 hdb11 hdb12>
> ...

best,
Herbert

> Best wishes
> 
> Norbert
> 
> -------------------------------------------------------------------------------
> Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
> gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
> -------------------------------------------------------------------------------
> FROSSES (pl.n.)
> The lecherous looks exchanged between sixteen-year-olds at a party
> given by someone's parents.
> 			--- Douglas Adams, The Meaning of Liff
