Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265662AbTFSAvy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 20:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265664AbTFSAvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 20:51:54 -0400
Received: from auemail2.lucent.com ([192.11.223.163]:59285 "EHLO
	auemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S265662AbTFSAvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 20:51:51 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16113.3132.953080.164174@gargle.gargle.HOWL>
Date: Wed, 18 Jun 2003 21:05:00 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: John Stoffel <stoffel@lucent.com>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH CYCLADES 1/2] fix cli()/sti() for ISA Cyclom-Y boards
In-Reply-To: <20030618224323.GE6754@parcelfarce.linux.theplanet.co.uk>
References: <16112.56865.325452.254827@gargle.gargle.HOWL>
	<20030618224323.GE6754@parcelfarce.linux.theplanet.co.uk>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


viro> On Wed, Jun 18, 2003 at 05:48:17PM -0400, John Stoffel wrote:
>> -    save_flags(flags); cli();
>> +    spin_lock_irqsave(&isa_card_lock, flags);
>> 
>> if ((e1 = tty_unregister_driver(cy_serial_driver)))
>> printk("cyc: failed to unregister Cyclades serial driver(%d)\n",
>> e1);
>> 
>> -    restore_flags(flags);
>> +    spin_unlock_irqrestore(&isa_card_lock,flags);

viro> It doesn't fix the problem and only makes the compile trouble go
viro> away.  Not to mention anything else, you are relying on a lot of
viro> code being non-blocking.

viro> Could you explain what is protected by disabling interrupts and
viro> taking a spinlock here?

Honestly, I'm not sure.  My original patch was against 2.5.69, which
didn't have this section of code at all, I think there have been some
patches to the code between 2.5.69 and 2.5.72 which have mucked around
with stuff.

It looked suspicious to me as well, and I'd be happy to remove this
from my patch, since I don't know what locking is needed around this
section of code off hand.  Let me look at some other drivers and see
how they unregister themselves.  Maybe theres a tty_drive_spinlock
somewhere that should be used instead.

Thanks for your comments, good to see you back on l-k.

John
