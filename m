Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270782AbTGPNEX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 09:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270803AbTGPNEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 09:04:23 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:19657
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S270782AbTGPNEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 09:04:22 -0400
Subject: Re: [PATCH] AHA152x driver hangs on PCMCIA card eject, kernel
	2.4.22-pre6
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Bhavesh P. Davda" <bhavesh@avaya.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       fischer@norbit.de, dahinds@users.sourceforge.net,
       Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <01db01c34b1b$fde04740$6e260987@rnd.avaya.com>
References: <01db01c34b1b$fde04740$6e260987@rnd.avaya.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058361370.6633.6.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 Jul 2003 14:16:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-07-15 at 22:56, Bhavesh P. Davda wrote:
> 2. A change to the aha152x_cs stub driver to not use the SCSI error-handling
> thread code. The aha152x_cs driver calls scsi_unregister_module() as a
> queued timer task when it gets a CS_EVENT_CARD_REMOVAL event, which causes
> scsi_unregister_host() to do a down() on a semaphore, calling schedule(),
> when executing the timer_bh for the timer.

Right - scsi_unregister should not be called on a timer event, instead
it needs to kick off a task queue

