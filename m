Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbVBTCnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVBTCnL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 21:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbVBTCnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 21:43:11 -0500
Received: from atlmail.prod.rxgsys.com ([64.74.124.160]:50629 "EHLO
	bastet.signetmail.com") by vger.kernel.org with ESMTP
	id S261313AbVBTCnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 21:43:07 -0500
Date: Sat, 19 Feb 2005 21:42:58 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: slab corruption on 2.6.10-rc4-bk7
Message-ID: <20050220024257.GA16811@havoc.gtf.org>
References: <20050219221624.GB803@redhat.com> <20050219144147.4c771d4f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050219144147.4c771d4f.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 19, 2005 at 02:41:47PM -0800, Andrew Morton wrote:
> Dave Jones <davej@redhat.com> wrote:
> >
> > (This has actually been there for a while, but I only
> >  noticed it in dmesg this morning).
> > During boot on a dual em64t I see ..
> > 
> > scsi2 : ata_piix
> > isa bounce pool size: 16 pages
> > slab error in cache_free_debugcheck(): cache `size-2048': double free, or memory outside object was overwritten
> > 
> > Call Trace:<ffffffff80163448>{cache_free_debugcheck+392} <ffffffff801646aa>{kfree+234}
> >        <ffffffff88065189>{:libata:ata_pci_init_one+937} <ffffffff801fe9ea>{pci_bus_read_config_word+122}
> >        <ffffffff880707f2>{:ata_piix:piix_init_one+498} <ffffffff80202926>{pci_device_probe+134}
> >        <ffffffff802691ad>{driver_probe_device+77} <ffffffff802692cb>{driver_attach+75}
> >        <ffffffff802696c9>{bus_add_driver+169} <ffffffff802025e3>{pci_register_driver+131}
> >        <ffffffff88074010>{:ata_piix:piix_init+16} <ffffffff80152c58>{sys_init_module+344}
> >        <ffffffff8010e52a>{system_call+126}
> > ffff81011e49f4a0: redzone 1: 0x5a2cf071, redzone 2: 0x5a2cf071.
> > 
> 
> It's plain to see how ata_pci_init_one() will free `probe_ent' twice.  Jeff
> wanna fix that up please?  A naive fix would be

I'll take a look at it tomorrow when I get back home; it's not that
simple, as if you look through BK history, you'll see an almost reverse
patch applied, to fix another double-kfree (author: zaitcev).

	Jeff
