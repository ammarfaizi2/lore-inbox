Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265305AbUGGStr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265305AbUGGStr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 14:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265311AbUGGStp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 14:49:45 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:6067 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S265305AbUGGSsG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 14:48:06 -0400
Date: Wed, 7 Jul 2004 14:50:07 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: Michael Clark <michael@metaparadigm.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Update in-kernel orinoco drivers to upstream current
 CVS
In-Reply-To: <40EB510F.2040801@metaparadigm.com>
Message-ID: <Pine.LNX.4.60.0407071359530.3991@marabou.research.att.com>
References: <20040702222655.GA10333@bougret.hpl.hp.com>
 <20040703010709.A22334@electric-eye.fr.zoreil.com> <20040704021304.GD25992@zax>
 <20040704191732.A20676@electric-eye.fr.zoreil.com>
 <20040706011401.A390@electric-eye.fr.zoreil.com> <40E9E6BC.8020608@pobox.com>
 <20040707005402.A15251@electric-eye.fr.zoreil.com> <40EB510F.2040801@metaparadigm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

[trimming the cc: a bit]

On Wed, 7 Jul 2004, Michael Clark wrote:

> Just like to chime in as a tester. I've been running the orinoco CVS
> for around 6 weeks now. Has been very stable although I needed the
> attached patch to make suspend/resume work (thinkpad with APM).
>
> I posted a bug on orinoco savannah but haven't seen any changes in CVS.

Sorry, but bug tracking systems rarely provide fast turnaround.  It's 
better that you post to orinoco-devel@lists.sourceforge.net to get a reply 
fast.

The patch you submitted on Savannah reverts the patch submitted by Simon 
Huggins: http://sourceforge.net/mailarchive/message.php?msg_id=7995284

The patch you attached seems to be much better.  I've applied it.

> BTW - what is the *correct* ordering of pci_(save|restore)_state,
> pci_set_power_state?

drivers/net/pci-skeleton.c doesn't have power management code, but the 
driver it was based on, 8139too.c, has such code and uses 
pci_set_power_state() after pci_(save|restore)_state().  Other well 
maintained drivers (e.g. e100.c) use pci_set_power_state() after 
pci_save_state() and before pci_restore_state().  I think it's reasonable 
to follow this example.  Jeff?

-- 
Regards,
Pavel Roskin
