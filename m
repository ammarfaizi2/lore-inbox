Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161471AbWHDV0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161471AbWHDV0S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 17:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161479AbWHDV0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 17:26:18 -0400
Received: from gw.goop.org ([64.81.55.164]:35009 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1161471AbWHDV0R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 17:26:17 -0400
Message-ID: <44D3BB7C.4000001@goop.org>
Date: Fri, 04 Aug 2006 14:26:20 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: David Lang <dlang@digitalinsight.com>
CC: Arjan van de Ven <arjan@linux.intel.com>,
       Antonio Vargas <windenntw@gmail.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       jeremy@xensource.com, greg@kroah.com, zach@vmware.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, hch@infradead.org,
       jlo@vmware.com, xen-devel@lists.xensource.com, simon@xensource.com,
       ian.pratt@xensource.com
Subject: Re: A proposal - binary
References: <44D1CC7D.4010600@vmware.com> <20060803190605.GB14237@kroah.com>    <44D24DD8.1080006@vmware.com> <20060803200136.GB28537@kroah.com>    <44D2B678.6060400@xensource.com> <20060803211850.3a01d0cc.akpm@osdl.org>    <1154667875.11382.37.camel@localhost.localdomain>    <20060803225357.e9ab5de1.akpm@osdl.org>    <1154675100.11382.47.camel@localhost.localdomain>    <Pine.LNX.4.63.0608040944480.18902@qynat.qvtvafvgr.pbz>   <69304d110608041146t44077033j9a10ae6aee19a16d@mail.gmail.com>   <Pine.LNX.4.63.0608041150360.18862@qynat.qvtvafvgr.pbz>  <44D39F73.8000803@linux.intel.com>  <Pine.LNX.4.63.0608041239430.18862@qynat.qvtvafvgr.pbz> <44D3A9F3.2000000@goop.org> <Pine.LNX.4.63.0608041325280.18862@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.63.0608041325280.18862@qynat.qvtvafvgr.pbz>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:
> how can I compile in support for Xen4 on my 2.6.18 kernel? after all 
> xen 2 and xen3 are incompatable hypervisors so why wouldn't xen4 (and 
> I realize there is no xen4 yet, but there is likly to be one during 
> the time virtual servers created with 2.6.18 are still running)

Firstly, backwards compatibility is very important; I would guess that 
if there were a Xen4 ABI, the hypervisor would still support Xen3 for 
some time.  Secondly, if someone goes to the effort of backporting a 
Xen4 paravirtops driver for 2.6.18, then you could compile it in.

> I also am missing something here. how can a system be compiled to do 
> several different things for the same privilaged opcode (including 
> running that opcode) without turning that area of code into a 
> performance pig as it checks for each possible hypervisor being present?

Conceptually, the paravirtops structure is a structure of pointers to 
functions which get filled in at runtime to support whatever hypervisor 
we're running over.  But it also has the means to patch inline versions 
of the appropriate code sequences for performance-critical operations.

    J
