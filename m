Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263962AbUG2DXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263962AbUG2DXw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 23:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263971AbUG2DXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 23:23:52 -0400
Received: from gate.crashing.org ([63.228.1.57]:47331 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263962AbUG2DXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 23:23:46 -0400
Subject: Re: PATCH: Fix ide probe double detection
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040727224629.GA17147@devserv.devel.redhat.com>
References: <20040727224629.GA17147@devserv.devel.redhat.com>
Content-Type: text/plain
Message-Id: <1091071364.13625.37.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 29 Jul 2004 13:22:44 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-28 at 08:46, Alan Cox wrote:
> Some devices don't decode master/slave - notably PCMCIA adapters. 
> Unfortunately for us some also do, which makes it hard to guess if we
> should probe the slave.
> 
> This patch fixes the problem by probing the slave and then using the model
> and serial information to spot undecoded pairs. An additional check is done
> to catch pairs of pre ATA devices just in case.

What about checking if drive->select sticks ? And if that doesn't work,
something like

- select 0
- write a value to reg X
- select 1
- write a different value to reg X
- select 0
- check value

reg X could be nsect or such ...

I don't like relying on drive->id and serial_no, but that may just be
paranoia...

Ben.


