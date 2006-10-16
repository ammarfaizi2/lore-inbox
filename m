Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161029AbWJPRsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161029AbWJPRsJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 13:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161032AbWJPRsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 13:48:09 -0400
Received: from dhost002-90.dex002.intermedia.net ([64.78.20.228]:15399 "EHLO
	dhost002-90.dex002.intermedia.net") by vger.kernel.org with ESMTP
	id S1161029AbWJPRsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 13:48:07 -0400
Message-ID: <4533C596.5060804@qlusters.com>
Date: Mon, 16 Oct 2006 19:47:02 +0200
From: Constantine Gavrilov <constg@qlusters.com>
Reply-To: Constantine Gavrilov <constg@qlusters.com>
Organization: Qlusters
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.7.13) Gecko/20060501 Fedora/1.7.13-1.1.fc5
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Would SSI clustering extensions be of interest to kernel community?
References: <45337FE3.8020201@qlusters.com> <4533B177.7030004@gmail.com>
In-Reply-To: <4533B177.7030004@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Oct 2006 17:48:00.0153 (UTC) FILETIME=[38A0A090:01C6F14B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please see inline...

Aneesh Kumar K.V wrote:

>
> I am interested in seeing the changes. I am right now working on 
> getting parts of OpenSSI (www.openssi.org)
> changes merged  upstream. Bruce Walker of the OpenSSI project have a 
> design of implementing cluster wide procs. The
> same doc can be found on www.openssi.org website. The paper talks 
> about how to implement cluster wide proccess model
> without requiring home/deputy concept. But yes it require some core 
> kernel changes. But should be Conditionally enabled
> like selinux. So overhead for non cluster users should be nill.

I am personally not interested in making intrusive kernel changes even 
if it yields in true "single-system image". I want very small changes 
(preferrably none).

>
> Regarding my work you can see the status here
> http://git.openssi.org/~kvaneesh/gitweb.cgi?p=ci-to-linus.git;a=summary
>
> It only gets the ICS changes. That means it introduce a transport 
> independent kernel cluster framework. Right now it supports two 
> interconnect IPV4 and infiniband verbs.

We also have transport abstraction layer and transport plugins for 
TCP/IP, SDP (Infiniband and possibly others), and SCI (Dolphin).

> I am planning on taking the CFS changes. That should bring in 
> clusterwide shared memory too. The way it was done in OpenSSI
> was to hook a new nopage() function for CFS so that when we page 
> fault, we bring the pages from other node.So i am not sure whether
> one need a VM hook for getting clusterwide shared memory. But without 
> seeing the code i am clueless.
>
Nopage will be called if there is no pte. That means, with just nopage 
you cannot implement RO-RW transition. If you use nopage only, you 
cannot have multiple readers, because you cannot invalidate all other 
readers if one reader goes read-write. Thus nopage allows single reader 
or single writer whle the page fault hook allows multiple readers and 
single writer.

-- 
----------------------------------------
Constantine Gavrilov
Kernel Developer
Qlusters Software Ltd
1 Azrieli Center, Tel-Aviv
Phone: +972-3-6081977
Fax:   +972-3-6081841
----------------------------------------

