Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbWBVQIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbWBVQIU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 11:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbWBVQIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 11:08:20 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:13281 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932291AbWBVQIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 11:08:19 -0500
Message-ID: <43FC8C6B.60002@us.ibm.com>
Date: Wed, 22 Feb 2006 11:08:11 -0500
From: "Mike D. Day" <ncmike@us.ibm.com>
User-Agent: Thunderbird 1.5 (Macintosh/20051201)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Heiko Carstens <heiko.carstens@de.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, xen-devel@lists.xensource.com,
       lkml <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: Re: [ PATCH 2.6.16-rc3-xen 3/3] sysfs: export Xen	hypervisor	attributes
 to sysfs
References: <43FB2642.7020109@us.ibm.com>	 <1140542130.8693.18.camel@localhost.localdomain>	 <20060222123250.GB9295@osiris.boeblingen.de.ibm.com>	 <43FC5B1D.5040901@us.ibm.com>	 <1140612969.2979.20.camel@laptopd505.fenrus.org>	 <43FC61C4.30002@us.ibm.com>	 <20060222131918.GC9295@osiris.boeblingen.de.ibm.com>	 <43FC6A86.90901@us.ibm.com> <1140616911.2979.22.camel@laptopd505.fenrus.org>
In-Reply-To: <1140616911.2979.22.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> but again those tools and agents *already* have a way of talking to the
> hypervisor themselves. Why can't they just first ask this info? Why does
> that need to be in the kernel, in unswappable memory?

Currently the two ways to get this data from user space are python via 
xend, the xen control daemon, and through a C library call.

The two arguments for making some data available via sysfs are (1) to 
support scripts and to (2) support efforts to slim down the required 
user space tool stack.

There are alternatives for both arguments. To support scripting one 
could add bindings (perl etc.) to the c library. Another alternative is 
to write a succinct set of utility programs that call the c library and 
invoke those utilities from scripts.

Neither of the above alternatives really help to slim down existing user 
space tools, but on the other hand they don't materially add to the 
problem either.

Sysfs is the simplest way to expose this info to user space. As an 8k 
module it is pretty small. It fits well with convention because Xen 
support is driver-like in the current linux patches. I think a xen sysfs 
module is a reasonable solution. However I understand and agree with the 
desire to keep unnecessary code out of the kernel.

Mike
