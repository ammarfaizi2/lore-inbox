Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263295AbUEBVVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbUEBVVW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 17:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263252AbUEBVVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 17:21:22 -0400
Received: from [81.3.11.18] ([81.3.11.18]:58777 "EHLO mail.ku-gbr.de")
	by vger.kernel.org with ESMTP id S263295AbUEBVVR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 17:21:17 -0400
Date: Sun, 2 May 2004 23:21:03 +0200
From: Konstantin Kletschke <lkml@ludenkalle.de>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: kernel BUG at include/linux/list.h:164!
Message-ID: <20040502212103.GB9447@ku-gbr.de>
Reply-To: Konstantin Kletschke <konsti@ku-gbr.de>
References: <20040501150308.GB8709@ku-gbr.de> <Pine.LNX.4.44.0405020856040.14500-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0405020856040.14500-100000@localhost.localdomain>
Organization: Kletschke & Uhlig GbR
X-PGP-Key: http://www.ludenkalle.de/konsti/pubkey.asc
User-Agent: Mutt/1.5.6i
X-Spam-Score: 3.3
X-Spam-Report: Spam detection software, running on the system "kermit", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or block
	similar future email.  If you have any questions, see
	admin@mail.ku-gbr.de for details.
	Content preview:  Am 2004-05-02 09:22 +0100 schrieb Hugh Dickins: > On
	Sat, 1 May 2004, Konstantin Kletschke wrote: > > > > May 1 12:03:07
	kermit kernel: kernel BUG at include/linux/list.h:164! > > May 1
	12:03:07 kermit kernel: invalid operand: 0000 [#1] > > May 1 12:03:07
	kermit kernel: PREEMPT > > May 1 12:03:07 kermit kernel: CPU: 0 > > May
	1 12:03:07 kermit kernel: EIP: 0060:[exit_rmap+237/272] Not tainted VLI
	> > May 1 12:03:07 kermit kernel: EFLAGS: 00010283 (2.6.6-rc2-mm1) >
	.... > > 2.6.6-rc2-mm1 with devmapper udm1 patch > > > > Is this dump
	due to udma1 or not and the error is fixed now? > > Probably not - I
	don't know this udma1 patch, but the error above [...] 
	Content analysis details:   (3.3 points, 10.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.5 RCVD_IN_NJABL_DIALUP   RBL: NJABL: dialup sender did non-local SMTP
	[145.254.145.165 listed in dnsbl.njabl.org]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[145.254.145.165 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_NJABL          RBL: Received via a relay in dnsbl.njabl.org
	[145.254.145.165 listed in dnsbl.njabl.org]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[145.254.145.165 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2004-05-02 09:22 +0100 schrieb Hugh Dickins:
> On Sat, 1 May 2004, Konstantin Kletschke wrote:
> > 
> > May  1 12:03:07 kermit kernel: kernel BUG at include/linux/list.h:164!
> > May  1 12:03:07 kermit kernel: invalid operand: 0000 [#1]
> > May  1 12:03:07 kermit kernel: PREEMPT
> > May  1 12:03:07 kermit kernel: CPU:    0
> > May  1 12:03:07 kermit kernel: EIP:    0060:[exit_rmap+237/272] Not tainted VLI
> > May  1 12:03:07 kermit kernel: EFLAGS: 00010283   (2.6.6-rc2-mm1)
> ....
> > 2.6.6-rc2-mm1 with devmapper udm1 patch
> > 
> > Is this dump due to udma1 or not and the error is fixed now?
> 
> Probably not - I don't know this udma1 patch, but the error above

It provides snapshot and pvmove functionality for LVM2 and 2.6.x
kernels and is in the early creation if I understood right...

> definitely occurs in my rmap area.

HA! :)

> though neither my testing nor anyone else has seen the same (yet).

Ok, lets see...

> I imagine you're limited in the experiments you can do on that server,
> and wouldn't want to run it with CONFIG_SLAB_DEBUG=y, which might show
> up unrelated problems - interesting for us, but troublesome for you.

Yes, sadly :(

> You're UP but PREEMPT on.  Hmm, there's a suspicious atomic_read
> in exit_rmap: once upon a time I convinced myself it was good, but
> it looks unsafe to me now - could cause a double free of an anonmm,
> which would lead to your BUG if reallocated in between.
> 
> Not so likely for me to feel this is definitely the answer, but
> likely enough to be well worth trying.  Please try patch below -
> simple enough not to make your case worse anyway - thanks.

Ok, I will try that out and incorporate the patch tomorrow. Works on
test machine fine so far (and compiles of course :P). Then we will
see, if the uptime lasts longer...

reHugh

-- 
2.6.5-mm1
Konstantin Kletschke <konsti@ludenkalle.de>, <konsti@ku-gbr.de>
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF
keulator.homelinux.org up 5:23, 18 users
