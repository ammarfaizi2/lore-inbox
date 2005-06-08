Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbVFHQNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVFHQNb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 12:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbVFHQLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 12:11:21 -0400
Received: from fmr24.intel.com ([143.183.121.16]:18620 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S261379AbVFHQKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 12:10:42 -0400
Date: Wed, 8 Jun 2005 09:09:44 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: Grant Grundler <grundler@parisc-linux.org>, Greg KH <gregkh@suse.de>,
       Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>,
       "Nguyen, Tom L" <tom.l.nguyen@intel.com>, roland@topspin.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] PCI: remove access to pci_[enable|disable]_msi() for drivers - take 2
Message-ID: <20050608090944.A4147@unix-os.sc.intel.com>
References: <20050608133226.GR23831@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050608133226.GR23831@wotan.suse.de>; from ak@suse.de on Wed, Jun 08, 2005 at 06:32:26AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2005 at 06:32:26AM -0700, Andi Kleen wrote:
> 
>    > I also see one minor weakness in the assumption that CPU Vectors
>    > are global. Both IA64/PARISC can support per-CPU Vector tables.

One thing to keep in mind is that since now we have support for CPU hotplug
we need to factor in cases when cpu is removed, the per-cpu vectors would
require migrating to a new cpu far interrupt target. Which would 
possibly require vector-sharing support as well in case the vector is used 
in all other cpus.

Possibly irq balancer might need to be revisited as well, and potentially
might trigger some sharing needs.

A combination of 
 - Not allocating IRQs to pins not used (Which Natalie from Unisys
   submitted) 
   http://marc.theaimsgroup.com/?l=linux-kernel&m=111656957923038&w=2
 - per-cpu vector tables (long back i remember seeing some post from sgi
   on the topic, possibly under intr domains etc.. not too sure)
 - vector sharing

> 
>    x86-64 will eventually too, I definitely plan for it at some point.
>    We need it for very big machines where 255 interrupt vectors
>    are not enough. And as you say with MSI-X it becomes even more
>    important.
> 
>    -Andi
>    -
>    To   unsubscribe   from   this   list:   send  the  line  "unsubscribe
>    linux-kernel" in
>    the body of a message to majordomo@vger.kernel.org
>    More majordomo info at  [1]http://vger.kernel.org/majordomo-info.html
>    Please read the FAQ at  [2]http://www.tux.org/lkml/
> 
> References
> 
>    1. http://vger.kernel.org/majordomo-info.html
>    2. http://www.tux.org/lkml/

-- 
Cheers,
Ashok Raj
- Open Source Technology Center
