Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263461AbTFJQb0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 12:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbTFJQbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 12:31:25 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:12966
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263461AbTFJQbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 12:31:25 -0400
Subject: Re: IDE IRQ probe brokenness.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1055233984.29633.56.camel@passion.cambridge.redhat.com>
References: <1055233984.29633.56.camel@passion.cambridge.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055263361.32661.10.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 Jun 2003 17:42:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-06-10 at 09:33, David Woodhouse wrote:
> I have on my desk a machine where all PCI interrupts are routed to 
> IRQ 0.
> 
> The IDE code doesn't seem very happy with it -- it seems to think that
> hwif->irq == 0 means that no IRQ has been set. It should be using -1 for
> that instead.
> 
> This error is in both 2.4 and 2.5.

It isn't clear that -1 is safe either. One thing I would suggest for
your latest weird embedded beastie is that you tweak the IRQ assignment
so IRQ 0 disappears or becomes IRQ 63 or something. IDE does have this
problem, but so does USB and a lot of other code.

Basically we need a "NOT_AN_IRQ" value defined either globally or per
port

Alan

