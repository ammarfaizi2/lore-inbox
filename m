Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933246AbWKSUlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933246AbWKSUlg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 15:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933230AbWKSUlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 15:41:35 -0500
Received: from gate.crashing.org ([63.228.1.57]:32897 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S933246AbWKSUle (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 15:41:34 -0500
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
	type IRQ handlers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, dwalker@mvista.com
In-Reply-To: <4560C121.30403@ru.mvista.com>
References: <200611192243.34850.sshtylyov@ru.mvista.com>
	 <1163966437.5826.99.camel@localhost.localdomain>
	 <20061119200650.GA22949@elte.hu>
	 <1163967590.5826.104.camel@localhost.localdomain>
	 <4560BDF5.400@ru.mvista.com>
	 <1163968376.5826.110.camel@localhost.localdomain>
	 <4560C121.30403@ru.mvista.com>
Content-Type: text/plain
Date: Mon, 20 Nov 2006 07:41:25 +1100
Message-Id: <1163968885.5826.116.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>     This is not implicit -- CPU has to read INTACK reg. on OpenPIC.

Which is what I meant... "implicit by reading the vector".

> Really implicit method is in action on x86 where CPU issues dual ACK bus cycle to get 
> the vector form 8259...

Which you can do on OpenPIC too. It's the same idea. The concept that
obtaining the vector performs the ack.

> > EOI is a more "high level" thing that some "intelligent" PICs that
> > automatically raise the priority do to restore the priority to what it
> > was before the interrupt occured.
> 
>     Thank you, I know. Even 8259 has the notion of priority and EOI works the 
> same way here.

Ok, so why would you need an ack there then while eoi is just what you
need ? :-)

Also, that's interesting what you are saying about 8259... I should be
able to convert ppc's i8259 to use fasteoi too...

Ben.


