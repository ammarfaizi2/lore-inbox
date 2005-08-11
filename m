Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbVHKFx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbVHKFx6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 01:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbVHKFx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 01:53:57 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:3844 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932273AbVHKFx4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 01:53:56 -0400
Message-ID: <42FAE7E7.1000502@vmware.com>
Date: Wed, 10 Aug 2005 22:53:43 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: akpm@osdl.org, chrisl@vmware.com, chrisw@osdl.org, hpa@zytor.com,
       Keir.Fraser@cl.cam.ac.uk, linux-kernel@vger.kernel.org,
       m+Ian.Pratt@cl.cam.ac.uk, mbligh@mbligh.org, pratap@vmware.com,
       virtualization@lists.osdl.org
Subject: Re: [PATCH 8/14] i386 / Add a per cpu gdt accessor
References: <200508110456.j7B4ue56019587@zach-dev.vmware.com> <Pine.LNX.4.61.0508102344060.16483@montezuma.fsmlabs.com>
In-Reply-To: <Pine.LNX.4.61.0508102344060.16483@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Aug 2005 05:54:00.0766 (UTC) FILETIME=[1252ADE0:01C59E39]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:

>On Wed, 10 Aug 2005 zach@vmware.com wrote:
>
>  
>
>>Add an accessor function for getting the per-CPU gdt.  Callee must already
>>have the CPU.
>>    
>>
>
>This one seems superfluous to me, does accessing it indirectly generate 
>better code too?
>  
>

Thanks for the feedback.  I believe the binary compilation is the same.  
It is superfluous in the sense that there is not yet a real use for it, 
but it is needed for later developement.

Xen requires page isolation of system data structures that could be used 
to override privilege.  Since they do not shadow the GDT, they require 
the GDT to be write protected.  A side effect of that is that the GDT 
must be moved to an isolated page.  Thus, the accessors to allow 
transparently moving the GDT for a paravirtual build.  There is 
deliberately no effect on the standard build.

Zach

P.S. Sorry I got your mail address wrong earlier.  I mistyped it from 
the update to the CREDITS patch.
