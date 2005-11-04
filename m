Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbVKDNLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbVKDNLI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 08:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbVKDNLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 08:11:07 -0500
Received: from [81.2.110.250] ([81.2.110.250]:423 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751419AbVKDNLG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 08:11:06 -0500
Subject: Re: Parallel ATA with libata status with the patches I'm working on
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, bzolnier@gmail.com, rmk@arm.linux.org.uk
In-Reply-To: <20051104013054.GF3469@ime.usp.br>
References: <1131029686.18848.48.camel@localhost.localdomain>
	 <20051103144830.GF28038@flint.arm.linux.org.uk>
	 <58cb370e0511030702hb06a5f3qc2dfe465ee1d784c@mail.gmail.com>
	 <m3oe51zc2e.fsf@defiant.localdomain>
	 <58cb370e0511031329h7532259y6d3624fbf2d93f88@mail.gmail.com>
	 <1131058464.18848.94.camel@localhost.localdomain>
	 <20051104013054.GF3469@ime.usp.br>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 04 Nov 2005 13:41:06 +0000
Message-Id: <1131111667.26925.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While writing the new sl82c05 driver I noticed a real nasty lurking in
the old code. According to the errata docs you have to reset the DMA
engine every transfer to work around chip errata. It also says that this
resets any other ATA transfer in progress.

If both channels are in use there is no locking between the channels to
stop a reset on one channel as DMA begins making a mess of the other
channel. Looks like serialize should be set on the driver ?

Alan

