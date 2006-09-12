Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWILKsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWILKsP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 06:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbWILKsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 06:48:15 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:9367 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932071AbWILKsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 06:48:14 -0400
Message-ID: <45069072.4010007@openvz.org>
Date: Tue, 12 Sep 2006 14:48:18 +0400
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: sekharan@us.ibm.com, balbir@in.ibm.com, Srivatsa <vatsa@in.ibm.com>
CC: Dave Hansen <haveblue@us.ibm.com>, Rik van Riel <riel@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       Matt Helsley <matthltc@us.ibm.com>, Hugh Dickins <hugh@veritas.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Kirill Korotaev <dev@sw.ru>,
       Oleg Nesterov <oleg@tv-sign.ru>, devel@openvz.org
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added	user
 memory)
References: <44FD918A.7050501@sw.ru>	<44FDAB81.5050608@in.ibm.com>	 <44FEC7E4.7030708@sw.ru>	<44FF1EE4.3060005@in.ibm.com>	 <1157580371.31893.36.camel@linuxchandra>	<45011CAC.2040502@openvz.org>	 <1157730221.26324.52.camel@localhost.localdomain>	 <4501B5F0.9050802@in.ibm.com> <450508BB.7020609@openvz.org>	 <4505161E.1040401@in.ibm.com>  <45051AC7.2000607@openvz.org> <1158000590.6029.33.camel@linuxchandra>
In-Reply-To: <1158000590.6029.33.camel@linuxchandra>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chandra Seetharaman wrote:
> On Mon, 2006-09-11 at 12:13 +0400, Pavel Emelianov wrote:
>
> <snip>
>   
>>> Don't start the new container or change the guarantees of the existing
>>> ones
>>> to accommodate this one :) The QoS design (done by the administrator)
>>> should
>>> take care of such use-cases. It would be perfectly ok to have a container
>>> that does not care about guarantees to set their guarantee to 0 and set
>>> their limit to the desired value. As Chandra has been stating we need two
>>> parameters (guarantee, limit), either can be optional, but not both.
>>>       
>> If I set up 9 groups to have 100Mb limit then I have 100Mb assured (on
>> 1Gb node)
>> for the 10th one exactly. And I do not have to set up any guarantee as
>> it won't affect
>> anything. So what a guarantee parameter is needed for?
>>     
>
> I do not think it is that simple since
>  - there is typically more than one class I want to set guarantee to
>  - I will not able to use both limit and guarantee
>  - Implementation will not be work-conserving.
>
> Also, How would you configure the following in your model ?
>
> 5 classes: Class A(10, 40), Class B(20, 100), Class C (30, 100), Class D
> (5, 100), Class E(15, 50); (class_name(guarantee, limit))
>   
What's the total memory amount on the node? Without it it's hard to make
any
guarantee.
> "Limit only" approach works for DoS prevention. But for providing QoS
> you would need guarantee.
>   
You may not provide guarantee on physycal resource for a particular group
without limiting its usage by other groups. That's my major idea.
