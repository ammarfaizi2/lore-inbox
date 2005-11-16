Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965235AbVKPEDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965235AbVKPEDY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 23:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965241AbVKPEDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 23:03:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:642 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965235AbVKPEDX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 23:03:23 -0500
Date: Tue, 15 Nov 2005 20:03:19 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] isaectomy: toshiba.c
In-Reply-To: <E1EcEJS-0007dd-7b@ZenIV.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0511151959270.13959@g5.osdl.org>
References: <E1EcEJS-0007dd-7b@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 16 Nov 2005, Al Viro wrote:
> 
> switch from isa_read...() to ioremap() and read...()

Hmm.. I actually believe that the isa_read() functions are more portable 
and easier to use than ioremap().

The reason? A platform will always know where any legacy ISA bus resides, 
while the "ioremap()" thing will depend on platform PCI code to have set 
the right offsets (and thus the resource addresses) for whatever bus the 
PCI device is on.

So doing a "ioremap(0xf0000)" is actually a harder operation at run-time 
when you have to basically have some special case ("is this address range 
in the ISA legacy region") than for the platform code to just always map 
the ISA legacy region at some random offset and then doing "isa_read()" 
from that.

Is there some underlying reason you want to remove the isa_xxx stuff?

		Linus
