Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751961AbWJWQGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961AbWJWQGl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 12:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751963AbWJWQGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 12:06:41 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:27333
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751961AbWJWQGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 12:06:40 -0400
Message-Id: <453D050D.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Mon, 23 Oct 2006 17:08:13 +0100
From: "Jan Beulich" <jbeulich@novell.com>
To: <vgoyal@in.ibm.com>
Cc: "Andi Kleen" <ak@suse.de>, "Magnus Damm" <magnus@valinux.co.jp>,
       <linux-kernel@vger.kernel.org>, <patches@x86-64.org>,
       <Ian.Campbell@XenSource.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [patches] [PATCH] [18/19] x86_64: Overlapping program
	headers in physical addr space fix
References: <20061021651.356252000@suse.de>
 <20061021165138.B8B5E13C4D@wotan.suse.de>
 <453C8966.76E4.0078.0@novell.com> <20061023144145.GB15532@in.ibm.com>
In-Reply-To: <20061023144145.GB15532@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I think plain "init" also does not reflect the correct name as this section
>is also mapping .data.init_task, .data.page_aligned and .data_nosave, which
>will probably never get freed. It maps smp alternatives sections which will
>not be freed if CPU_HOTPLUG is enabled. It also maps .bss, which will never
>get freed.
>
>I think, the sections which are not being freed, should be moved up and
>made part of 'data' segment. Then create a segment 'init' for all the init
>text/data and finally create another segment say 'bss' to map bss at the
>end. How does this sound?

Superb. Though I guess .bss needs no extra segment, it should simply
be the last thing in the data segment.

Jan
