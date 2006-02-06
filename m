Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbWBFTgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWBFTgq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbWBFTgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:36:45 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:29339 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932315AbWBFTgo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:36:44 -0500
Subject: Re: [PATCH] Revert serial 8250 console fixes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>
In-Reply-To: <DC17879A-2B03-4D20-865F-C89386A393EF@kernel.crashing.org>
References: <Pine.LNX.4.44.0602061116190.11785-100000@gate.crashing.org>
	 <1139250251.10437.39.camel@localhost.localdomain>
	 <DC17879A-2B03-4D20-865F-C89386A393EF@kernel.crashing.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 06 Feb 2006 19:38:31 +0000
Message-Id: <1139254711.10437.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-02-06 at 13:14 -0600, Kumar Gala wrote:
> Can you explain further why you had to change wait_for_xmitr() from  
> testing BOTH_EMPTY to UART_LSR_THRE.

Because you want to wait for the uart to show that it is ready to accept
a character, not that the byte has been clocked out entirely. Thats
essential for working with virtual serial ports on servers as they use
the fact there is no pending character to work out how to packetize it
as a TCP stream.


> Also, what exactly would you be looking for in a register dump?

When it gets stuck what state are the serial chip registers in and where
is the OS hanging ?

