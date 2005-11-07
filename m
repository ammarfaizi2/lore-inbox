Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965365AbVKGWMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965365AbVKGWMp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 17:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965385AbVKGWMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 17:12:45 -0500
Received: from mx1.suse.de ([195.135.220.2]:38570 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965381AbVKGWMo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 17:12:44 -0500
From: Neil Brown <neilb@suse.de>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Tue, 8 Nov 2005 09:12:30 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17263.53582.223276.493074@cse.unsw.edu.au>
Cc: device-mapper development <dm-devel@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       aherrman@de.ibm.com, bunk@stusta.de, cplk@itee.uq.edu.au
Subject: Re: [dm-devel] Re: [PATCH resubmit] do_mount: reduce stack consumption
In-Reply-To: message from Heiko Carstens on Monday November 7
References: <20051104105026.GA12476@osiris.boeblingen.de.ibm.com>
	<20051104084829.714c5dbb.akpm@osdl.org>
	<20051104212742.GC9222@osiris.ibm.com>
	<20051104235500.GE5368@stusta.de>
	<20051104160851.3a7463ff.akpm@osdl.org>
	<Pine.GSO.4.60.0511051108070.2449@mango.itee.uq.edu.au>
	<20051104173721.597bd223.akpm@osdl.org>
	<17260.17661.523593.420313@cse.unsw.edu.au>
	<17262.40176.342746.634262@cse.unsw.edu.au>
	<20051107161522.GA28164@osiris.boeblingen.de.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday November 7, heiko.carstens@de.ibm.com wrote:
> > > Ok, I'll dust it off, make sure it seems to work (at the time I first
> > > wrote it, I think it caused 'md' to deadlock) and submit it.
> > > 
> > > NeilBrown
> > > 
> > 
> > For your consideration and testing (it works for me, but I'd like to
> > see it tested a bit more heavily in a variety of configurations).
> 
> Works fine for me. Thank you!
> 

Thanks for the feed-back.

> However I noticed another recursive call while dumping all call traces:
>  ...
>  [<00000000001e1952>] zfcp_scsi_command_async+0xf6/0x1c4
>  [<000000000013cd6a>] scsi_dispatch_cmd+0x1ae/0x37c
>  [<0000000000143dc4>] scsi_request_fn+0x1dc/0x390
>  [<000000000012f65a>] generic_unplug_device+0x2a/0x38
>  [<0000000000181262>] dm_table_unplug_all+0x42/0x58
>  [<000000000017e598>] dm_unplug_all+0x2c/0x44
>  [<0000000000181262>] dm_table_unplug_all+0x42/0x58
>  [<000000000017e598>] dm_unplug_all+0x2c/0x44
>  [<00000000000782aa>] block_sync_page+0x4e/0x68
>  [<00000000000514f8>] sync_page+0x48/0x68
>  [<00000000002ab36e>] __wait_on_bit+0x9a/0xe0
>  ...

Hmm.. This (and a similar one with ->issue_flush_fn) would be a lot
harder to unwind, but it is also much more benign.  These sorts of
calls should always be very shallow.
I don't think there is anything useful that can be done here, and I'm
not convinced there is a real problem.
It is worth noticing it and keeping it in mind though.

Thanks,
NeilBrown
