Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbWEYAc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbWEYAc7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 20:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbWEYAc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 20:32:59 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:37569 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S964791AbWEYAc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 20:32:58 -0400
Date: Thu, 25 May 2006 09:34:18 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Ashok Raj <ashok.raj@intel.com>
Cc: ashok.raj@intel.com, linux-kernel@vger.kernel.org, y-goto@jp.fujitsu.com,
       ktokunag@redhat.com, akpm@osdl.org
Subject: Re: [RFC][PATCH] node hotplug : register_cpu() changes [0/3]
Message-Id: <20060525093418.b1639de2.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060524075128.A32074@unix-os.sc.intel.com>
References: <20060523195636.693e00d6.kamezawa.hiroyu@jp.fujitsu.com>
	<20060523075202.A24516@unix-os.sc.intel.com>
	<20060524091816.5a3960b9.kamezawa.hiroyu@jp.fujitsu.com>
	<20060524075128.A32074@unix-os.sc.intel.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2006 07:51:28 -0700
Ashok Raj <ashok.raj@intel.com> wrote:

> Probably ACPI doesnt give a precise way to put the dependencies (in a certain
> order), there are EDL/EJD, but they have limitations and not directly imply
> a dependency like this. But container code having to deal with this dependency
> for add/remove is probably ok. 
> 
I know fujitsu's engineers posted codes to add devices under container in past
and it knew dependency of memory -> cpu. It was rejected.
So, the current container driver just uses acpi_bus_add/start() to add/start all
devices under the container.

> i hope container would eventually perform onlining the pieces from user space
> scripts via udev like mechanisms.
> 
> I remember folks from SGI posting patches to cpu only nodes in the past. 
> Same way there are probably IO only nodes. Are you sure we cover these cases 
> as well.

Currently, I think  creating new empty node (pgdat) at onlining can work.
by cpu hotplug notifier chain, dangling cpus will create new pgdat.
If people want to see node <-> cpu relationship before onlining cpu, I' ll have
to do complicated work.

I also expects we can migrate per-cpu in notifier chain if  VM-per_cpu is 
implemented.

Thanks, 
-Kame

