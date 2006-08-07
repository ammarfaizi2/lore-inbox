Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbWHGOej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWHGOej (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 10:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWHGOej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 10:34:39 -0400
Received: from dvhart.com ([64.146.134.43]:25539 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S932116AbWHGOeh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 10:34:37 -0400
Message-ID: <44D74F77.7080000@mbligh.org>
Date: Mon, 07 Aug 2006 07:34:31 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
Cc: vatsa@in.ibm.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>, mingo@elte.hu, nickpiggin@yahoo.com.au,
       sam@vilain.net, linux-kernel@vger.kernel.org, dev@openvz.org,
       efault@gmx.de, balbir@in.ibm.com, sekharan@us.ibm.com,
       nagar@watson.ibm.com, haveblue@us.ibm.com, pj@sgi.com
Subject: Re: [RFC, PATCH 0/5] Going forward with Resource Management - A cpu
 controller
References: <20060804050753.GD27194@in.ibm.com> <20060803223650.423f2e6a.akpm@osdl.org> <20060803224253.49068b98.akpm@osdl.org> <1154684950.23655.178.camel@localhost.localdomain> <20060804114109.GA28988@in.ibm.com> <44D35F0B.5000801@sw.ru> <44D388DF.8010406@mbligh.org> <44D6EAFA.8080607@sw.ru>
In-Reply-To: <44D6EAFA.8080607@sw.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:

>>> OpenVZ assumes that tasks can't move between task-groups for a 
>>> single reason:
>>> user shouldn't be able to escape from the container.
>>> But this have no implication on the design/implementation.
>>
>>
>>
>> It does, for the memory controller at least. Things like shared
>> anon_vma's between tasks across containers make it somewhat harder.
>> It's much worse if you allow threads to split across containers.
>
> we already have the code to account page fractions shared between 
> containers.
> Though, it is quite useless to do so for threads... Since this numbers 
> have no meaning (not a real usage)
> and only the sum of it will be a correct value.
>
THat sort of accounting poses various horrible problems, which is
why we steered away from it. If you share pages between containers
(presumably billing them equal shares per user), what happens
when you're already at your limit, and one of your sharer's exits?

Plus, are you billing by vma or address_space?

M.


