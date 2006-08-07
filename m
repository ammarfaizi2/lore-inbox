Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbWHGQc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWHGQc4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 12:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWHGQc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 12:32:56 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:6789 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932212AbWHGQcz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 12:32:55 -0400
Message-ID: <44D76B43.5080507@sw.ru>
Date: Mon, 07 Aug 2006 20:33:07 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@mbligh.org>
CC: vatsa@in.ibm.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>, mingo@elte.hu, nickpiggin@yahoo.com.au,
       sam@vilain.net, linux-kernel@vger.kernel.org, dev@openvz.org,
       efault@gmx.de, balbir@in.ibm.com, sekharan@us.ibm.com,
       nagar@watson.ibm.com, haveblue@us.ibm.com, pj@sgi.com,
       Andrey Savochkin <saw@sw.ru>
Subject: Re: [RFC, PATCH 0/5] Going forward with Resource Management - A cpu
 controller
References: <20060804050753.GD27194@in.ibm.com> <20060803223650.423f2e6a.akpm@osdl.org> <20060803224253.49068b98.akpm@osdl.org> <1154684950.23655.178.camel@localhost.localdomain> <20060804114109.GA28988@in.ibm.com> <44D35F0B.5000801@sw.ru> <44D388DF.8010406@mbligh.org> <44D6EAFA.8080607@sw.ru> <44D74F77.7080000@mbligh.org>
In-Reply-To: <44D74F77.7080000@mbligh.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> we already have the code to account page fractions shared between 
>> containers.
>> Though, it is quite useless to do so for threads... Since this numbers 
>> have no meaning (not a real usage)
>> and only the sum of it will be a correct value.
>>
> THat sort of accounting poses various horrible problems, which is
> why we steered away from it. If you share pages between containers
> (presumably billing them equal shares per user), what happens
> when you're already at your limit, and one of your sharer's exits?
you come across your limit and new allocations will fail.
BUT! IMPORTANT!
in real life use case with OpenVZ we allow sharing not that much data across containers:
vmas mapped as private, i.e. glibc and other libraries .data section
(and .code if it is writable). So if you use the same glibc and other executables
in the containers then your are charged only a fraction of phys memory used by it.
This kind of sharing is not that huge (<< memory limits usually),
so the situation you described is not a problem
in real life (at least for OpenVZ).

> Plus, are you billing by vma or address_space?
not sure what you mean. we charge pages. first by whole vma.
but as page gets more used by other containers your usage decreases.

Thanks,
Kirill

