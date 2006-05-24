Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932488AbWEXARb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbWEXARb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 20:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbWEXAQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 20:16:57 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:41930 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932506AbWEXAQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 20:16:53 -0400
Date: Wed, 24 May 2006 09:18:15 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Ashok Raj <ashok.raj@intel.com>
Cc: linux-kernel@vger.kernel.org, y-goto@jp.fujitsu.com, ktokunag@redhat.com,
       ashok.raj@intel.com, akpm@osdl.org
Subject: Re: [RFC][PATCH] node hotplug : register_cpu() changes [0/3]
Message-Id: <20060524091816.5a3960b9.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060523075202.A24516@unix-os.sc.intel.com>
References: <20060523195636.693e00d6.kamezawa.hiroyu@jp.fujitsu.com>
	<20060523075202.A24516@unix-os.sc.intel.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2006 07:52:03 -0700
Ashok Raj <ashok.raj@intel.com> wrote:

> On Tue, May 23, 2006 at 07:56:36PM +0900, KAMEZAWA Hiroyuki wrote:
> > I found acpi container, which describes node, could evaluate cpu before
> > memory. This means cpu-hot-add occurs before memory hot add.
> > 
> 
> Is it possible to process memory before cpu in container hot-add code?
> 

Maybe No. I know ACPI people doesn't want to add special handling for cpu/memory
in a container. It complicates the code very much.

> > In most part, cpu-hot-add doesn't depend on node hot add.
> > But register_cpu, which creates symbolic link from node to cpu, requires
> 
> Dont you need all per-cpu allocated on that node? Or is it from node0 or 
> something for all hotpluggable cpus?
> 
I want to allocate on-node. But it's impossible now because per-cpu-pages
has to be allocated at boot-time as for possible cpus. They has to be
off-node now. They are from node0 (ia64) now.

I want to migrate per-cpu when a cpu is enabled (if I can). But maybe there
is a code which has pointer to object in per-cpu area.


> If node is online first, then all allocations come from that node, thought you
> *want* to ensure node/mem is online before cpu is up to get that benefit.
> 
Yes. But per-cpu should be allocated at boot-time now. I'd like to go step-by-step.

-Kame

