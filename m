Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265530AbUBFROg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 12:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265539AbUBFROg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 12:14:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:54194 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265530AbUBFROe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 12:14:34 -0500
Date: Fri, 6 Feb 2004 09:07:17 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Michael Frank <mhf@linuxmail.org>
Cc: riel@redhat.com, axboe@suse.de, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.25-rc1: BUG: wrong zone alignment, it will crash
Message-Id: <20040206090717.5e4f25e2.rddunlap@osdl.org>
In-Reply-To: <200402070046.31218.mhf@linuxmail.org>
References: <Pine.LNX.4.44.0402061034210.5933-100000@chimarrao.boston.redhat.com>
	<200402070046.31218.mhf@linuxmail.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Feb 2004 00:46:31 +0800 Michael Frank <mhf@linuxmail.org> wrote:

| On Friday 06 February 2004 23:36, Rik van Riel wrote:
| > On Fri, 6 Feb 2004, Michael Frank wrote:
| > 
| > > > > 300MB HIGHMEM available.
| > > > > 195MB LOWMEM available.
| > > > > On node 0 totalpages: 126960
| > > > > zone(0): 4096 pages.
| > > > > zone(1): 46064 pages.
| > > > > zone(2): 76800 pages.
| > > > > BUG: wrong zone alignment, it will crash
| > 
| > > It is supposed to work, just a bug in the zone alignment code.
| > 
| > The error isn't in the kernel, it's between the chair and the keyboard.
| > You have created a lowmem zone of a size that doesn't correctly
| > align with the largest blocks used by the buddy allocator.
| > 
| > > I have have to use HIGHMEM emulation for testing.
| > 
| > Then you'll need to choose a different size for the highmem=
| > parameter, one that doesn't cause an unaligned boundary.
| 
| Which is not user friendly and does not match the documentation.

Interesting boot option... but what doc. are you referring to?


| > Alternatively, you could submit a patch so the highmem= boot
| > option parsing code does the aligning for you.
| 
| OK, will do. I'll produce and test a patch.

Please include an update to Documentation/kernel-parameters.txt .

| > However, that would simply be an improvement to the kernel and
| > nothing like a bug you can demand to get fixed now.
| 
| OK, Please note that I only passed on the message produced by the kernel 
|   BUG: wrong zone alignment, it will crash 
| 
| Perhaps the kernel should have reported it as "Invalid value for highmem" 
| instead of "BUG" ;)

How does this option work?  Does it just fake highmem_pages of
low memory as being in high memory?

--
~Randy
kernel-janitors project:  http://janitor.kernelnewbies.org/
