Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965085AbWILKY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965085AbWILKY1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 06:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965148AbWILKY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 06:24:27 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:35412 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S965085AbWILKY0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 06:24:26 -0400
Message-ID: <45068AD9.50308@openvz.org>
Date: Tue, 12 Sep 2006 14:24:25 +0400
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: vatsa@in.ibm.com, sekharan@us.ibm.com
CC: Rik van Riel <riel@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Dave Hansen <haveblue@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       Matt Helsley <matthltc@us.ibm.com>, Hugh Dickins <hugh@veritas.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Kirill Korotaev <dev@sw.ru>,
       Oleg Nesterov <oleg@tv-sign.ru>, devel@openvz.org
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added user
 memory)
References: <44FD918A.7050501@sw.ru> <1157478392.3186.26.camel@localhost.localdomain> <44FED3CA.7000005@sw.ru> <1157579641.31893.26.camel@linuxchandra> <44FFCA4D.9090202@openvz.org> <1157656616.19884.34.camel@linuxchandra> <45011A47.1020407@openvz.org> <1157742442.19884.47.camel@linuxchandra> <450509EE.9010809@openvz.org> <20060911130428.GA16404@in.ibm.com>
In-Reply-To: <20060911130428.GA16404@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:
> On Mon, Sep 11, 2006 at 11:02:06AM +0400, Pavel Emelianov wrote:
>   
>> Sure. At the beginning I have one task with one BC. Then
>> 1. A thread is spawned and new BC is created;
>>     
>
> Why do we have to create a BC for every new thread? A new BC is needed
> for every new service level instead IMO. And typically there wont be
> unlimited service levels.
>   
That's the scenario we started from - each domain is served in a separate
BC with *threaded* Apache.
>   
>> 2. New thread touches a new page (e.g. maps a new file) which is charged
>> to new BC
>>     (and this means that this BC's must stay in memory till page is
>> uncharged);
>> 3. Thread exits after serving the request, but since it's mm is shared
>> with parent
>>     all the touched pages stay resident and, thus, the new BC is still
>> pinned in memory.
>> Steps 1-3 are done multiple times for new pages (new files).
>> Remember that we're discussing the case when pages are not recharged.
>>     
>
>
>   

