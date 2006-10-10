Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030233AbWJJTqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030233AbWJJTqa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 15:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030234AbWJJTqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 15:46:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:4115 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030233AbWJJTq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 15:46:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=Qwv9lfprU2v82mtT4eN6UYWpNzgEerTeicz/jr4HOnN819E/EUKdd61YhavxgkJ2JRnY4ugMwHUS5QMtUHq4esEnn5ZnR2e14E8dXPw2BLXIUe6ICUj3xI8YRfTw72cxkd7AJ+i1kWE2W09Im7Omw5aY2wLBJFIiHsz7M2+dQe0=
Subject: Re: 2.6.18 suspend regression on Intel Macs
From: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Riss <frederic.riss@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, len.brown@intel.com
In-Reply-To: <1160509121.3000.327.camel@laptopd505.fenrus.org>
References: <1160417982.5142.45.camel@funkylaptop>
	 <20061010103910.GD31598@elf.ucw.cz>
	 <1160476889.3000.282.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0610100830370.3952@g5.osdl.org>
	 <1160507296.5134.4.camel@funkylaptop>
	 <1160509121.3000.327.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=utf-8
Date: Tue, 10 Oct 2006 21:46:24 +0200
Message-Id: <1160509584.5134.11.camel@funkylaptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 10 octobre 2006 à 21:38 +0200, Arjan van de Ven a écrit :
> > So what's the plan? Should/Will the ACPI guys remove the bit-preserving
> > change brought in with the latest ACPICA merge?
> 
> 
> it sounds like a good idea to at least put the workaround back for now,
> until a more elegant solution (maybe something can be done to make it
> not needed anymore) is found...
> (or until it shows it breaks other machines at which point
> reconsideration is also needed)

The workaround hasn't been removed. It's still there,
drivers/acpi/pci_link.c:
788 
789 /* Make sure SCI is enabled again (Apple firmware bug?) */
790 acpi_set_register(ACPI_BITREG_SCI_ENABLE, 1, ACPI_MTX_DO_NOT_LOCK);
791 

The thing is acpi_set_register doesn't permit anymore to write the SCI
bit since the last ACPI merge. Or maybe you meant that the
acpi_hw_register_write modifications should be reverted until a better
solution is found?

Fred.

