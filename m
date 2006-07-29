Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751355AbWG2Tis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbWG2Tis (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 15:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWG2Tis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 15:38:48 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:11711 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751355AbWG2Tir
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 15:38:47 -0400
Subject: Re: [discuss] [Patch] 2/5 in support of hot-add memory x86_64
	create arch_find_node
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: Andi Kleen <ak@suse.de>
Cc: discuss <discuss@x86-64.org>, lkml <linux-kernel@vger.kernel.org>,
       lhms-devel <lhms-devel@lists.sourceforge.net>, andrew <akpm@osdl.org>,
       dave hansen <haveblue@us.ibm.com>,
       kame <kamezawa.hiroyu@jp.fujitsu.com>, konrad <darnok@us.ibm.com>
In-Reply-To: <200607291825.16308.ak@suse.de>
References: <1154141545.5874.146.camel@keithlap>
	 <200607291825.16308.ak@suse.de>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Sat, 29 Jul 2006 12:38:41 -0700
Message-Id: <1154201921.7900.42.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-29 at 18:25 +0200, Andi Kleen wrote:
> On Saturday 29 July 2006 04:52, keith mannthey wrote:
> >   With the advent of the new ACPI hot-plug memory driver and mechanism
> > is needed to deal with ACPI add memory events that do not contain the
> > pxm (node) information. I do not believe that the add-event is required
> > to contain this information so I create a arch_find_node generic layer
> > used in the generic add_memory function.
> >
> >   If add_memory is called with node < 0 arch_find_node is invoked to
> > fine the correct node to add the memory. This created the generic
> > construct of arch_find_node.
> 
> It would be cleaner to always call add_memory from architecture specific
> code instead of such ugly hooks

Since 2.6.18 it goes

acpi (generic calling add_memory)
add_memory (generic)
arch_add_memory (x86_64)
__add_pages (generic)

The generic add_memory call is good as it does the dynamic pgdat
allocation for new nodes.  The generic add_memory call need the correct
node infomation.  

Do you think we should do 

acpi (generic calling add_memory)
arch_pre_add_memory? (x86_64)
add_memory (generic)
arch_add_memory (x86_64)
__add_pages (generic)

? 
It would just create a function hook. 

Thanks, 
  Keith 


