Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261527AbTAXWca>; Fri, 24 Jan 2003 17:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261847AbTAXWc3>; Fri, 24 Jan 2003 17:32:29 -0500
Received: from [195.208.223.236] ([195.208.223.236]:3200 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S261527AbTAXWc0>; Fri, 24 Jan 2003 17:32:26 -0500
Date: Sat, 25 Jan 2003 01:41:02 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: "David S. Miller" <davem@redhat.com>
Cc: Jeff.Wiedemeier@hp.com, jgarzik@pobox.com, ink@jurassic.park.msu.ru,
       willy@debian.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5] tg3.c: pci_{save,restore}_extended_state
Message-ID: <20030125014102.A825@localhost.park.msu.ru>
References: <20030124154635.A4161@dsnt25.mro.cpqcorp.net> <20030124.125121.78932406.davem@redhat.com> <20030124163341.A4366@dsnt25.mro.cpqcorp.net> <20030124.133434.66251483.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030124.133434.66251483.davem@redhat.com>; from davem@redhat.com on Fri, Jan 24, 2003 at 01:34:34PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2003 at 01:34:34PM -0800, David S. Miller wrote:
> Right, the whole issue is that we're generally MSI ignorant in our PCI
> layer right now.  And you're trying to make use of MSI on some
> platform :-)

Right. Alpha is way ahead, as usual. ;-)

> So because the driver has no way to ask the platform "are you going
> to use MSI for this device?" there is no way for tg3 to portably
> deal with this issue.
> 
> That being said, why don't we add "pci_using_msi(pdev)" to asm/pci.h?
> Once we have that, tg3.c can then go and set the tg3 specific MSI
> enable bit to match whatever pci_using_msi(pdev) returns.  This, plus
> the extended state save/restore, should solve all the problems.

I don't understand the issue, really. The config register says:
"MSIs are enabled". Which means: "My platform is *really* going to
use MSI". Why do you want to ignore that?
In the case when firmware has MSI enabled by mistake and it's known
that this platform cannot support MSI, we'll have a quirk that
fixes the config register. No?

Ivan.
