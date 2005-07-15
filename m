Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262551AbVGOAEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262551AbVGOAEJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 20:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262816AbVGOAEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 20:04:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1740 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262551AbVGOAEH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 20:04:07 -0400
Subject: Re: [rfc patch 2/2] direct-io: remove address alignment check
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: ak@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050714163947.3fb952f1.akpm@osdl.org>
References: <1121298112.6025.21.camel@ibm-c.pdx.osdl.net.suse.lists.linux.kernel>
	 <p73hdex5xws.fsf@bragg.suse.de>
	 <1121356952.6025.33.camel@ibm-c.pdx.osdl.net>
	 <20050714182325.GI23737@wotan.suse.de>
	 <1121373639.6025.70.camel@ibm-c.pdx.osdl.net>
	 <20050714163947.3fb952f1.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1121385837.6025.97.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 14 Jul 2005 17:03:58 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-14 at 16:39, Andrew Morton wrote:
> Daniel McNeil <daniel@osdl.org> wrote:
> >
> > Do drivers have problems with odd addresses or with
> >  non-512 addresses?
> 
> I do recall hearing rumours that some bus-masters have fairly strict memory
> alignment requirements.  A cacheline size, perhaps - that would be 32 bytes
> given the age of the hardware.
> 
> But yeah, it's v.  risky to assume that all bus masters can cope with
> memory alignments down to two bytes.
> 
> It would be sane to put the minimum alignment into ->backing_dev_info,
> default to 512, get the device drivers to override that as they are tested.
> 
> But this introduces a very very bad problem: people will write applications
> which work on their hardware, ship the things and then find that the apps
> break on other people's hardware.  So we can't do that.
> 
> Instead, we need to work out the minimum alignment requirement for all disk
> controllers and DMA controllers and motherboards in the world.  And that
> includes catering for weird ones which appear to work but which
> occasionally fail in mysterious ways with finer alignments.  That's hard. 
> It's easier to continue to make application developers jump through hoops.

I was hoping this patch would help turn rumors into real data :)

If we did put min alignment into backing_dev_info, we could implement
the equivalent of bounce buffers for direct-io -- or just fall back
to buffer i/o like it does sometimes anyway.  That way application
would not break, just get worse performance on some hardware.

Right now I just wanted to get the issues on table, get some test
results, and see how to proceed from there.  Since this patch only
affects direct i/o, getting test results shouldn't cause too many
problems.

Thanks,

Daniel

