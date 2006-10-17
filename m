Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422935AbWJQK4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422935AbWJQK4o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 06:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422954AbWJQK4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 06:56:44 -0400
Received: from main.gmane.org ([80.91.229.2]:3822 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1422935AbWJQK4n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 06:56:43 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: Re: Would SSI clustering extensions be of interest to kernel community?
Date: Tue, 17 Oct 2006 16:26:18 +0530
Message-ID: <4534B6D2.80801@gmail.com>
References: <45337FE3.8020201@qlusters.com> <4533B177.7030004@gmail.com> <4533C596.5060804@qlusters.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
Cc: linux-kernel@vger.kernel.org
X-Gmane-NNTP-Posting-Host: palrel2.hp.com
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
In-Reply-To: <4533C596.5060804@qlusters.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Constantine Gavrilov wrote:
> Please see inline...
> 
> Aneesh Kumar K.V wrote:
> 
>>
>> I am interested in seeing the changes. I am right now working on 
>> getting parts of OpenSSI (www.openssi.org)
>> changes merged  upstream. Bruce Walker of the OpenSSI project have a 
>> design of implementing cluster wide procs. The
>> same doc can be found on www.openssi.org website. The paper talks 
>> about how to implement cluster wide proccess model
>> without requiring home/deputy concept. But yes it require some core 
>> kernel changes. But should be Conditionally enabled
>> like selinux. So overhead for non cluster users should be nill.
> 
> I am personally not interested in making intrusive kernel changes even 
> if it yields in true "single-system image". I want very small changes 
> (preferrably none).
> 
>>
>> Regarding my work you can see the status here
>> http://git.openssi.org/~kvaneesh/gitweb.cgi?p=ci-to-linus.git;a=summary
>>
>> It only gets the ICS changes. That means it introduce a transport 
>> independent kernel cluster framework. Right now it supports two 
>> interconnect IPV4 and infiniband verbs.
> 
> We also have transport abstraction layer and transport plugins for 
> TCP/IP, SDP (Infiniband and possibly others), and SCI (Dolphin).


I would really like to see this code. Is it available on the web some where ?



> 
>> I am planning on taking the CFS changes. That should bring in 
>> clusterwide shared memory too. The way it was done in OpenSSI
>> was to hook a new nopage() function for CFS so that when we page 
>> fault, we bring the pages from other node.So i am not sure whether
>> one need a VM hook for getting clusterwide shared memory. But without 
>> seeing the code i am clueless.
>>
> Nopage will be called if there is no pte. That means, with just nopage 
> you cannot implement RO-RW transition. If you use nopage only, you 
> cannot have multiple readers, because you cannot invalidate all other 
> readers if one reader goes read-write. Thus nopage allows single reader 
> or single writer whle the page fault hook allows multiple readers and 
> single writer.
> 

With the nopage changes CFS also have a token based synchronization mechanism. 
The token code now works at the granularity of file. But very well can be made to work with file data ranges (range tokens).

To kind of explain how it works with CFS, When you want to map a page you request token server and token server grant
you token. Now somebody when trying to do a write map will result in the above mapped page being unmapped and shipped to the 
other node. So as long as all are readers there can be multiple nodes sharing the same page. 

When one of the node is in writer mode, Then token server will force to unmap the page from  other nodes when ever there
is a page access.

All these code is opensourced as a part of OpenSSI project. BTW I am only saying that the code at www.openssi.org may be
of interest to you. 

-aneesh 

