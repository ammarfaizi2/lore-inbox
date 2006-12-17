Return-Path: <linux-kernel-owner+w=401wt.eu-S1752416AbWLQK5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416AbWLQK5z (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 05:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752418AbWLQK5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 05:57:54 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:42647 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752415AbWLQK5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 05:57:52 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: sata badness in 2.6.20-rc1? [Was: Re: md patches in -mm]
Date: Sun, 17 Dec 2006 12:00:12 +0100
User-Agent: KMail/1.9.1
Cc: Jeff Garzik <jeff@garzik.org>, Neil Brown <neilb@suse.de>,
       Jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org, Tejun Heo <htejun@gmail.com>,
       Alan <alan@lxorguk.ukuu.org.uk>, Luben Tuikov <ltuikov@yahoo.com>
References: <20061204203410.6152efec.akpm@osdl.org> <200612161056.26830.rjw@sisk.pl> <200612161216.07669.rjw@sisk.pl>
In-Reply-To: <200612161216.07669.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612171200.13075.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 16 December 2006 12:16, Rafael J. Wysocki wrote:
> On Saturday, 16 December 2006 10:56, Rafael J. Wysocki wrote:
> > On Saturday, 16 December 2006 00:38, Rafael J. Wysocki wrote:
> > > On Friday, 15 December 2006 23:24, Jeff Garzik wrote:
> > > > Rafael J. Wysocki wrote:
> > > > > On Friday, 15 December 2006 22:39, Andrew Morton wrote:
> > > > >> On Fri, 15 Dec 2006 13:05:52 -0800
> > > > >> Andrew Morton <akpm@osdl.org> wrote:
> > > > >>
> > > > >>> Jeff, I shall send all the sata patches which I have at you one single time
> > > > >>> and I shall then drop the lot.  So please don't flub them.
> > > > >>>
> > > > >>> I'll then do a rc1-mm2 without them.
> > > > >> hm, this is looking like a lot of work for not much gain.  Rafael, are
> > > > >> you able to do a quick chop and tell us whether these:
> > > > >>
> > > > >> pci-move-pci_vdevice-from-libata-to-core.patch
> > > > >> pata_cs5530-suspend-resume-support-tweak.patch
> > > > >> ata-fix-platform_device_register_simple-error-check.patch
> > > > >> initializer-entry-defined-twice-in-pata_rz1000.patch
> > > > >> pata_via-suspend-resume-support-fix.patch
> > > > >> sata_nv-add-suspend-resume-support.patch
> > > > >> libata-simulate-report-luns-for-atapi-devices.patch
> > > > >> user-of-the-jiffies-rounding-patch-ata-subsystem.patch
> > > > >> libata-fix-oops-with-sparsemem.patch
> > > > >> sata_nv-fix-kfree-ordering-in-remove.patch
> > > > >> libata-dont-initialize-sg-in-ata_exec_internal-if-dma_none-take-2.patch
> > > > >> pci-quirks-fix-the-festering-mess-that-claims-to-handle-ide-quirks-ide-fix.patch
> > > > >>
> > > > >> are innocent?
> > > > > 
> > > > > Yes, they are.
> > > > 
> > > > We all really appreciate your patience :)  This is good feedback.
> > > > 
> > > > To narrow down some more, does applying 2.6.20-rc1 + the attached patch 
> > > > work?  (ignoring -mm tree altogether)
> > > 
> > > Yes, it does.
> > 
> > I've applied the patches from -rc1-mm1 up to and including
> > 
> > problem-phy-probe-not-working-properly-for-ibm_emac-ppc4xx.patch
> > 
> > on top of 2.6.20-rc1 and they don't seem to break anything.  Will try some
> > more.
> 
> The patch that breaks things is somewhere between
> 
> dont-export-device-ids-to-userspace.patch
> 
> and
> 
> funsoft-is-bust-on-sparc.patch
> 
> inclusive.
> 
> Now I'll need to resync my disk arrays so if anyone has any suggestions
> what to try next, I'll be grateful. ;-)

Okay, I have identified the patch that causes the problem to appear, which is

fix-sense-key-medium-error-processing-and-retry.patch

With this patch reverted -rc1-mm1 is happily running on my test box.

Greetings,
Rafael


-- 
If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King
