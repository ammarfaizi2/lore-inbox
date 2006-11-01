Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992755AbWKATea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992755AbWKATea (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 14:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992758AbWKATea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 14:34:30 -0500
Received: from dev.mellanox.co.il ([194.90.237.44]:4755 "EHLO
	dev.mellanox.co.il") by vger.kernel.org with ESMTP id S2992755AbWKATe2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 14:34:28 -0500
Date: Wed, 1 Nov 2006 21:33:33 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Ernst Herzberg <earny@net4u.de>,
       Len Brown <lenb@kernel.org>, Adrian Bunk <bunk@stusta.de>,
       Hugh Dickins <hugh@veritas.com>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org, linux-pm@osdl.org,
       Martin Lorenz <martin@lorenz.eu.org>
Subject: Re: 2.6.19-rc <-> ThinkPads
Message-ID: <20061101193333.GC9085@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <Pine.LNX.4.64.0611011003270.25218@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611011003270.25218@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Linus Torvalds <torvalds@osdl.org>:
> Subject: Re: 2.6.19-rc <-> ThinkPads
> 
> 
> 
> On Wed, 1 Nov 2006, Andi Kleen wrote:
> >
> > Ok please revert the i386 patch for now then if it fixes the ThinkPads. 
> > The x86-64 version should be probably fixed too, but doesn't cleanly. I will 
> > send you later a patch to fix this there properly.
> 
> Actually, I should have just fixed the ordering. I did some cleanups too, 
> but those are unrelated (except in the sense that I wanted to look at the 
> assembly code, and the cleanups made the code generation at least half-way 
> sane!)
> 
> I've pushed out the changes, but here is the part that may or may not 
> matter for anybody who wants to test it if they don't use git or if it 
> hasn't mirrored out yet. Michael? Martin?

I pulled the latest git, and seems to work for me, thanks.
This still could be a false negative (happened already) so I'll
continue using this, and will post the results.

> Andi: I think the patches should work pretty much as-is for x86-64 too, 
> since all the issues would seem to be similar. 
> 
> I'm not entirely happy with "ioapic_write_entry()" now either (if we 
> change an entry that was already unmasked, we should probably mask it 
> first by writing the low word with the mask bit set, then write the high 
> word, and then write the low word again), but 
> 
>  - this makes us match the ordering we _used_ to have, so if the cleanup 
>    broke things for people, this should unbreak it, and at least not be 
>    any worse than it used to be.
> 
>  - when we write new unmasked entries, they all _should_ have been masked 
>    before, so hopefully the "change a unmasked entry while it's unmasked" 
>    case doesn't actually ever happen. But I didn't actually _check_.
> 
> Somebody should look into that case. Does anybody feel like they want to 
> learn more about the IO-APIC? Halloween is over and gone, but if you want 
> to scare small children _next_ year, telling them about the IO-APIC is 
> likely a good strategy.
> 
> 		Linus

Hmm, sounds interesting :)
Is this a good place to start (I'm feeling lucky hit for IO-APIC)?
http://www.intel.com/design/chipsets/datashts/290566.htm

-- 
MST
