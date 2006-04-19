Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbWDSVms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWDSVms (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 17:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWDSVms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 17:42:48 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:23706 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S1751175AbWDSVms
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 17:42:48 -0400
Message-ID: <4446AEC9.80407@vilain.net>
Date: Thu, 20 Apr 2006 09:42:33 +1200
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Kirill Korotaev <dev@sw.ru>,
       devel@openvz.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Herbert Poetzl <herbert@13thfloor.at>,
       Mishin Dmitry <dim@sw.ru>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Subject: Re: [Devel] Re: [RFC] [PATCH 0/7] Some basic vserver infrastructure
References: <20060321061333.27638.63963.stgit@localhost.localdomain>	<1142967011.10906.185.camel@localhost.localdomain>	<44206B58.5000404@vilain.net>	<1142976756.10906.200.camel@localhost.localdomain>	<4420885F.5070602@vilain.net>	<m1bqvzq7de.fsf@ebiederm.dsl.xmission.com> <44241214.7090405@sw.ru>	<20060327124517.GA16114@sergelap.austin.ibm.com>	<442A7879.20802@sw.ru>	<20060329134709.GC15745@sergelap.austin.ibm.com>	<1143667844.9969.11.camel@localhost.localdomain> <m1hd4qovg6.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1hd4qovg6.fsf@ebiederm.dsl.xmission.com>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

>>The overlapping is important if you want to pretend that the
>>namespace-able resources are allowed to be specified per-process, when
>>really they are specified per-family.
>>
>>In this way, a process family is merely a grouping of processes with
>>like namespaces, and depending on which way they overlap you get the
>>same behaviour as when processes only have one resource different, and
>>therefore remove the overhead on fork().
>>    
>>
>
>
>I missed this subthread originally.
>
>I think it is important that we can have containers in containers
>if at all possible.  This means large software collections can count
>on them being present.
>  
>

Right. Well, my concept was that that "in"-ness is just a relationship
between two process families, so treat it relationally and not
heirarchically. So, to the kernel, they've all got global unique IDs,
but to the actual userspace within those families, they might see
something different. And the model still supports containers in containers.

>As for having some items inside a namespace show up in both
>a parent and a child namespace I think the case is less clearly
>defined.  If possible that is something we want to avoid as it
>complicates the implementation.
>
>For pids I will be surprised if we can avoid it.
>
>For most other namespaces I think we can, and it is a good thing
>to avoid.
>  
>

Well, let's cross those bridges when we come to them. I agree it should
only be implemented if required for individual numbers. PIDs and process
family IDs seem logical to me, at this point anyway.

Sam.
