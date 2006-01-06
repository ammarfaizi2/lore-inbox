Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964834AbWAFSaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbWAFSaE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 13:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbWAFSaD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 13:30:03 -0500
Received: from [213.85.88.22] ([213.85.88.22]:34754 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S964827AbWAFSaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 13:30:00 -0500
From: Alexander Zarochentsev <zam@namesys.com>
Organization: namesys
To: reiserfs-dev@namesys.com
Subject: Re: Re. 2.6.15-mm1
Date: Fri, 6 Jan 2006 21:29:21 +0300
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, Alexander Gran <alex@zodiac.dnsalias.org>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       "Brown, Len" <len.brown@intel.com>, Adam Belay <ambx1@neo.rr.com>,
       Dave Airlie <airlied@linux.ie>, "Vladimir V. Saveliev" <vs@namesys.com>
References: <200601051801.29007@zodiac.zodiac.dnsalias.org> <20060105144720.25085afa.akpm@osdl.org>
In-Reply-To: <20060105144720.25085afa.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601062129.22733.zam@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 January 2006 01:47, Andrew Morton wrote:
> Alexander Gran <alex@zodiac.dnsalias.org> wrote:
> > Hi,
> >
> > just tried 2.6.15-mm1 on my thinkpad. Various aspects that didn't work /
> > look good:
>
> Thanks.  A few people have some work to do before they are ready to merge
> to 2.6.16.
>
> > Jan  5 16:22:38 t40 kernel: pnp: PnP ACPI init
> > Jan  5 16:22:38 t40 kernel: pnp: PnPACPI: unknown resource type 7
> > Jan  5 16:22:38 t40 kernel: pnp: PnPACPI: unknown resource type 7
> > Jan  5 16:22:39 t40 last message repeated 10 times
> > Jan  5 16:22:39 t40 kernel: pnp: PnP ACPI: found 0 devices
>
> pnpacpi is unhappy.
>
> > All over the place logs like this:
> > Jan  5 16:22:43 t40 kernel: **** SET: Misaligned resource pointer:
> > f7db5502 Type 07 Len 0
> > Unknown to me so far..
>
> acpi is unhappy.
>
> > When X startet, the laptops crashed:
> > Jan  5 16:22:43 t40 kernel: <4>reiser4[syslogd(2729)]:
> > disable_write_barrier (fs/reiser4/wander.c:233)[zam-1055]:
> > Jan  5 16:22:43 t40 kernel: WARNING: disabling write barrier

It means submit_bio(WRITE_BARRIER, bio) fails and reiser4 falls back to 
synchronous write in the transaction commit code.  

Ext3, reiserfs do similar checks in their code and all issue warnings if those 
checks fail.  But only ext3, it seems, has write barrier support disabled by 
default.

> Vladimir, is that expected?
>
> > Jan  5 16:22:43 t40 kernel:
> > Jan  5 16:22:47 t40 kernel: mtrr: 0xe0000000,0x8000000 overlaps existing
> > 0xe0000000,0x4000000
> > Jan  5 16:22:48 t40 last message repeated 2 times
>
> Is that new?
>
> > Jan  5 16:22:48 t40 kernel: agpgart: Found an AGP 2.0 compliant device at
> > 0000:00:00.0.
> > Jan  5 16:22:48 t40 kernel: c028b7cf
> > Jan  5 16:22:48 t40 kernel: Modules linked in: irtty_sir sir_dev
> > cfq_iosched ehci_hcd uhci_hcd
> > Jan  5 16:22:48 t40 kernel: EIP:    0060:[<c028b7cf>]    Not tainted VLI
> > Jan  5 16:22:48 t40 kernel: EFLAGS: 00013202   (2.6.15-mm1)
> > Jan  5 16:22:48 t40 kernel:        <0>c028b9e9 f762ff08 00000002 00000000
> > c19720ec 00000000 1f000217 c1a79400
> > Jan  5 16:22:48 t40 kernel:        <0>00000032 00000001 c028bfb5 c0297262
> > c1a79400 c02972af 1f000207 c029727f
>
> hm, it's not clear what oopsed.   Can you get a cleaner copy of this?
>
> > Jan  5 16:22:48 t40 kernel:  <3>[drm:drm_release] *ERROR* Device busy: 1
> > 0
>
> drm is unhappy

-- 
Alex.
