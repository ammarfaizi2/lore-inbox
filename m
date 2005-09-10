Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbVIJVGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbVIJVGU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 17:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbVIJVGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 17:06:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54993 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932303AbVIJVGT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 17:06:19 -0400
Date: Sat, 10 Sep 2005 14:06:11 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Miguel <frankpoole@terra.es>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: PCI bug in 2.6.13
In-Reply-To: <Pine.LNX.4.58.0509100949370.30958@g5.osdl.org>
Message-ID: <Pine.LNX.4.58.0509101401490.30958@g5.osdl.org>
References: <20050909180405.3e356c2a.frankpoole@terra.es>
 <20050909225956.42021440.akpm@osdl.org> <20050910113658.178a7711.frankpoole@terra.es>
 <Pine.LNX.4.58.0509100949370.30958@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 10 Sep 2005, Linus Torvalds wrote:
> 
> Can you show the differences in "/sbin/lspci -vvx" with and without that 
> patch? It really makes no sense for so many reasons that it's not even 
> funny.
> 
> Also, what disk controller is this happening on?

Oh, one more thing: the pci_map_rom() bug might have mapped some ROM image
in your system at a bogus address, and that might cause problems.

Now, not many drivers use pci_map_rom(), and for video ROMs this bug
should be hidden by the fact that video ROMs end up using the shadow
system rom on x86, but it's possible that you had something that used the
sysfs rom code to enable a ROM and that causes problems.

If so, the bug should be fixed in the 2.6.13.1 -stable release and/or in 
the current -git snapshots, so it would be very nice if you could test one 
of those..

		Linus
