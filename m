Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272120AbTHFU47 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 16:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272302AbTHFU47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 16:56:59 -0400
Received: from dclient217-162-108-200.hispeed.ch ([217.162.108.200]:25094 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S272120AbTHFU43
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 16:56:29 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Russell King <rmk@arm.linux.org.uk>, Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH 2.6] ToPIC specific init for yenta_socket
Date: Wed, 6 Aug 2003 22:50:55 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-pcmcia <linux-pcmcia@lists.infradead.org>
References: <200308062025.08861.daniel.ritz@gmx.ch> <20030806194430.D16116@flint.arm.linux.org.uk>
In-Reply-To: <20030806194430.D16116@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308062250.55885.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed August 6 2003 20:44, Russell King wrote:
> On Wed, Aug 06, 2003 at 08:25:08PM +0200, Daniel Ritz wrote:
> > this patch adds override functions for the ToPIC family of controllers.
> > also adds the device id for ToPIC100 and (untested) support for zoom
> > video for ToPIC97/100.
> > 
> > tested with start/stop and suspend/resume.
> 
> We currently have some fairly serious IRQ problems with yenta at the
> moment.  I'm holding all patches until we get this problem resolved -
> it seems to be caused by several bad changes over the past couple of
> years accumulating throughout the 2.5 series.

yep, i saw the mails on lkml...

> 
> Therefore, I don't want to add any further changes into the mix just
> yet.

ok. the topic code is low-prio as these chips works mostly w/o the patch.
my craptop just fucks up in 1 of 30 boots or so.

> 
> Also, assigning to socket->socket.ops->init modifies the global
> yenta_socket_operations structure, which I'm far from happy about.

yes, i saw that too, but copy-pasted from the other overrides to fix up
in the next patch...i think ->init should always point to yenta_init,
the additional init function should be called from inside there, before
activating the interrupts...wanna have a patch?

-daniel


ps: in a few days, when i get my other laptop back, i have access to one of
those TI chips with all the nice problems (ie. under FreeBigStinkyDaemon the
machine dies under an interrupt storm when activating the socket) so i could
also test the irq routing and other fixes a bit. 

