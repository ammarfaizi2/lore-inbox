Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965595AbWIRI4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965595AbWIRI4R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 04:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965594AbWIRI4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 04:56:17 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:8884 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S965593AbWIRI4R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 04:56:17 -0400
Message-ID: <450E5F2E.2070809@openvz.org>
Date: Mon, 18 Sep 2006 12:56:14 +0400
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: balbir@in.ibm.com
CC: sekharan@us.ibm.com, Srivatsa <vatsa@in.ibm.com>,
       Rik van Riel <riel@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Dave Hansen <haveblue@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       Matt Helsley <matthltc@us.ibm.com>, Hugh Dickins <hugh@veritas.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Kirill Korotaev <dev@sw.ru>,
       Oleg Nesterov <oleg@tv-sign.ru>, devel@openvz.org
Subject: Re: [ckrm-tech] [PATCH] BC: resource beancounters (v4) (added	user
 memory)
References: <44FD918A.7050501@sw.ru>	<44FDAB81.5050608@in.ibm.com>		<44FEC7E4.7030708@sw.ru>	<44FF1EE4.3060005@in.ibm.com>		<1157580371.31893.36.camel@linuxchandra>	<45011CAC.2040502@openvz.org>		<1157730221.26324.52.camel@localhost.localdomain>		<4501B5F0.9050802@in.ibm.com> <450508BB.7020609@openvz.org>		<4505161E.1040401@in.ibm.com> <45051AC7.2000607@openvz.org>		<1158000590.6029.33.camel@linuxchandra>	<45069072.4010007@openvz.org>		<1158105488.4800.23.camel@linuxchandra>	<4507BC11.6080203@openvz.org>		<1158186664.18927.17.camel@linuxchandra>	<45090A6E.1040206@openvz.org>	<1158277364.6357.33.camel@linuxchandra>	<450A5325.6090803@openvz.org> <450A6A7A.8010102@sw.ru> <450A8B61.7040905@openvz.org> <450E5813.2040804@in.ibm.com>
In-Reply-To: <450E5813.2040804@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:

[snip]

> This approach has the following disadvantages
>  1. Lets consider initialization - When we create 'n' groups
> initially, we need
>     to spend O(n^2) time to assign guarantees.

1. Not guarantees - limits. If you do not need guarantees - assign
   overcommited limits. Most of OpenVZ users do so and nobody claims.
2. If you start n groups at once then limits are calculated in O(n)
   time, not O(n^2).

>  2. Every time a limit or a guarantee changes, we need to recalculate
> guarantees
>     and ensure that the change will not break any guarantees

The same.

>  3. The same thing as stated above, when a resource group is created
> or deleted
>
> This can lead to some instability; a change in one group propagates to
> all other groups.

Let me cite a part of your answer on my letter from 11.09.2006:
"...
  xemul> I have a node with 1Gb of ram and 10 containers with 100Mb
  xemul> guarantee each. I want to start one more.
  xemul> What shall I do not to break guarantees?

 Don't start the new container or change the guarantees of the
 existing ones to accommodate this one ... It would be perfectly
 ok to have a container that does not care about guarantees to
 set their guarantee to 0 and set their limit to the desired value
..."

The same for the limiting - either do not start new container, or
recalculate limits to meet new requirements. You may not take care of
guarantees as weel and create an overcommited configuration.

And one more thing. We've asked it many times and I ask it again -
please, show us the other way for providing guarantee rather than
limiting or reserving.
