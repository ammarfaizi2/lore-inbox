Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422719AbWJPQV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422719AbWJPQV4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 12:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422723AbWJPQV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 12:21:56 -0400
Received: from main.gmane.org ([80.91.229.2]:36052 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1422719AbWJPQVz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 12:21:55 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: Re: Would SSI clustering extensions be of interest to kernel community?
Date: Mon, 16 Oct 2006 21:51:11 +0530
Message-ID: <4533B177.7030004@gmail.com>
References: <45337FE3.8020201@qlusters.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 59.92.190.251
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
In-Reply-To: <45337FE3.8020201@qlusters.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Constantine Gavrilov wrote:
> I have implemented SSI (single system image) clustering extensions to 
> Linux kernel in the form of a loadable module.
> 
> It roughly mimics OpenMosix model of deputy/remote split (migrated 
> processes leave a stub on the node where they were born and depend on 
> the "home" node for IO).
> 
> The implementation shares no code with Mosix/Open Mosix (was written 
> from scratch), is much smaller, and is easily portable to multiple 
> architectures.
> 
> We are considering publication of this code and forming an open source 
> project around it.
> 
> I have two questions to the community:
> 
> 1) Is community interested in using this code? Do users require SSI 
> product in the era when everybody is talking about partitioning of 
> machines and not clustering?
> 2) Are kernel maintainers interested in clustering extensions to Linux 
> kernel? Do they see any value in them? (Our code does not require kernel 
> changes, but we are willing to submit it for inclusion if there is 
> interest.)
> 
> Please CC me and the list when replying.
> 



I am interested in seeing the changes. I am right now working on getting parts of OpenSSI (www.openssi.org)
changes merged  upstream. Bruce Walker of the OpenSSI project have a design of implementing cluster wide procs. The
same doc can be found on www.openssi.org website. The paper talks about how to implement cluster wide proccess model
without requiring home/deputy concept. But yes it require some core kernel changes. But should be Conditionally enabled
like selinux. So overhead for non cluster users should be nill.

Regarding my work you can see the status here
http://git.openssi.org/~kvaneesh/gitweb.cgi?p=ci-to-linus.git;a=summary

It only gets the ICS changes. That means it introduce a transport independent kernel cluster framework. Right now it supports two interconnect IPV4 and infiniband verbs. 

I am planning on taking the CFS changes. That should bring in clusterwide shared memory too. The way it was done in OpenSSI
was to hook a new nopage() function for CFS so that when we page fault, we bring the pages from other node.So i am not sure whether
one need a VM hook for getting clusterwide shared memory. But without seeing the code i am clueless.


-aneesh

