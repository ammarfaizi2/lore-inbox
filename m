Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751781AbWD1SOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbWD1SOu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 14:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751782AbWD1SOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 14:14:50 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52406 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751781AbWD1SOt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 14:14:49 -0400
Date: Fri, 28 Apr 2006 20:14:05 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Ian Kent <raven@themaw.net>, Matt Mackall <mpm@selenic.com>
Subject: Re: initcall warnings in 2.6.17
Message-ID: <20060428181404.GB26821@elf.ucw.cz>
References: <200604281406.34217.ak@suse.de> <20060428105403.250eb2d6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060428105403.250eb2d6.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Pá 28-04-06 10:54:03, Andrew Morton wrote:
> Andi Kleen <ak@suse.de> wrote:
> >
> > I still get
> > 
> > initcall at 0xffffffff807414c2: pci_iommu_init+0x0/0x501(): returned with error code -1
> 
> Should be returning -ENODEV.
> 
> > initcall at 0xffffffff80748b4d: init_autofs4_fs+0x0/0xc(): returned with error code -16
> 
> hm.  Why'd that happen?
> 
> > initcall at 0xffffffff803c7d5c: init_netconsole+0x0/0x6b(): returned with error code -22
> 
> Yeah.  I think netconsole is just being wrong here.  If it wasn't enabled
> there's no error.
> 
> > initcall at 0xffffffff80249307: software_resume+0x0/0xcf(): returned with error code -2
> 
> Similarly, there's no resume file configured so should we really consider
> this an error?

That one is easier to solve. But "configured but image not present"
will also produce warning I guess. If I return -ENODEV, will it keep
debugging system quiet?
								Pavel
-- 
Thanks for all the (sleeping) penguins.
