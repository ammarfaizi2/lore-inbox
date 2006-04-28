Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751760AbWD1Rzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751760AbWD1Rzx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 13:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751769AbWD1Rzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 13:55:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3503 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751760AbWD1Rzx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 13:55:53 -0400
Date: Fri, 28 Apr 2006 10:54:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, Ian Kent <raven@themaw.net>,
       Matt Mackall <mpm@selenic.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: initcall warnings in 2.6.17
Message-Id: <20060428105403.250eb2d6.akpm@osdl.org>
In-Reply-To: <200604281406.34217.ak@suse.de>
References: <200604281406.34217.ak@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> I still get
> 
> initcall at 0xffffffff807414c2: pci_iommu_init+0x0/0x501(): returned with error code -1

Should be returning -ENODEV.

> initcall at 0xffffffff80748b4d: init_autofs4_fs+0x0/0xc(): returned with error code -16

hm.  Why'd that happen?

> initcall at 0xffffffff803c7d5c: init_netconsole+0x0/0x6b(): returned with error code -22

Yeah.  I think netconsole is just being wrong here.  If it wasn't enabled
there's no error.

> initcall at 0xffffffff80249307: software_resume+0x0/0xcf(): returned with error code -2

Similarly, there's no resume file configured so should we really consider
this an error?


> I'm not sure it was that good an idea to enable this warning by default in 2.6.17.
> It will be still in the release and probably generate some user queries.
> 
> Might be better to disable it for 2.6.17 again and only reenable for 2.6.18 after
> some auditing?
> 

Yes, I'm inclined to agree.  It's finding some real but very minor
problems.  Probably too minor to be scaring users.  I'll cook up a patch to
move it under `initcall_debug'.

