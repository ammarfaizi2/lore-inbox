Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbUAMAwM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 19:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbUAMAwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 19:52:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:64172 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262707AbUAMAwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 19:52:10 -0500
Date: Mon, 12 Jan 2004 16:25:39 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Intel Alder IOAPIC fix
In-Reply-To: <1073954751.4178.98.camel@mulgrave>
Message-ID: <Pine.LNX.4.58.0401121621220.14305@evo.osdl.org>
References: <1073876117.2549.65.camel@mulgrave>  <Pine.LNX.4.58.0401121152070.1901@evo.osdl.org>
 <1073948641.4178.76.camel@mulgrave>  <Pine.LNX.4.58.0401121452340.2031@evo.osdl.org>
 <1073954751.4178.98.camel@mulgrave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 12 Jan 2004, James Bottomley wrote:
>
> OK, with the patch below (to insert_resource) I know get the IO APIC
> successfully inserted under the reserved fixmap resources:
> 
> /proc/iomem still looks very odd:
> 
> fec00000-fec08fff : reserved
>   fec01000-fec013ff : 0000:00:0f.0
> fffffc00-ffffffff : 0000:00:0f.0
>   fffffc00-ffffffff : 0000:00:0f.0
>     fffffc00-ffffffff : 0000:00:0f.0
>       fffffc00-ffffffff : 0000:00:0f.0
>         fffffc00-ffffffff : 0000:00:0f.0
>           ffe80000-ffffffff : reserved
> 
> unfortunately, because BARs 1-5 cover the same region.

I think BARs 1-5 don't exist at all. Being set to all ones is common for
"unused" (it ends up being a normal result of a lazy probe - you set all 
bits to 1 to check for the size of the region, and if you decide not to 
map it and leave it there, you'll get the above behaviour).

I suspect only BAR0 is actually real.

What's in that ffe80000-ffffffff region that the BIOS has allocated,
anyway?

		Linus
