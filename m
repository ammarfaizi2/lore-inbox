Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965105AbVKHM5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965105AbVKHM5F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 07:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965115AbVKHM5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 07:57:01 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:9652 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965105AbVKHM5A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 07:57:00 -0500
Date: Tue, 8 Nov 2005 13:57:09 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Zachary Amsden <zach@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 4/21] i386 Broken bios common
Message-ID: <20051108125709.GA4218@elte.hu>
References: <200511080422.jA84MQxK009859@zach-dev.vmware.com> <20051108071935.GB28201@elte.hu> <43709E86.8010203@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43709E86.8010203@vmware.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Zachary Amsden <zach@vmware.com> wrote:

> >>-	gdt[0x40 / 8] = bad_bios_desc;
> >>+	gdt[0x40 / 8] = gdt[GDT_ENTRY_BAD_BIOS_CACHE];
> >
> >i like the cleanup, but wouldnt it be simpler to dedicate GDT entry #8 
> >to the 0x40 descriptor, and hence be compatible with such broken BIOSes 
> >by default? Right now entry #8 is taken up by TLS segment #2, but we 
> >could change GDT_ENTRY_TLS_MIN from 6 to 9 and push the TLS segments to 
> >entries 9,10,11. [ Could there be any buggy SMM code that relies on 
> >having something at 0x40? ]
> 
> I worry that there could be buggy userspace code that relies on having 
> selector 0x40 - notably Wine.  So although I would like to make 0x40 
> the default, can't be guaranteed.

why use up a GDT entry then for GDT_ENTRY_BAD_BIOS_CACHE? Just put it 
into a global variable, into the readmostly section.

	Ingo
