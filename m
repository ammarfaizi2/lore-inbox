Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965086AbVKPEJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965086AbVKPEJl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 23:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965213AbVKPEJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 23:09:41 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:10908 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965086AbVKPEJk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 23:09:40 -0500
Date: Wed, 16 Nov 2005 04:09:39 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] isaectomy: toshiba.c
Message-ID: <20051116040939.GB27946@ftp.linux.org.uk>
References: <E1EcEJS-0007dd-7b@ZenIV.linux.org.uk> <Pine.LNX.4.64.0511151959270.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511151959270.13959@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 08:03:19PM -0800, Linus Torvalds wrote:
> Hmm.. I actually believe that the isa_read() functions are more portable 
> and easier to use than ioremap().
> 
> The reason? A platform will always know where any legacy ISA bus resides, 
> while the "ioremap()" thing will depend on platform PCI code to have set 
> the right offsets (and thus the resource addresses) for whatever bus the 
> PCI device is on.
> 
> So doing a "ioremap(0xf0000)" is actually a harder operation at run-time 
> when you have to basically have some special case ("is this address range 
> in the ISA legacy region") than for the platform code to just always map 
> the ISA legacy region at some random offset and then doing "isa_read()" 
> from that.
> 
> Is there some underlying reason you want to remove the isa_xxx stuff?

The fact that it has almost no users?  And nearly all drivers that do
use it (and not just have it in dead code) are using it for access to
very specific locations in BIOS...
