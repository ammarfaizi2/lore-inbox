Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946386AbWKJKgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946386AbWKJKgf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 05:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946384AbWKJKgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 05:36:35 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:39758 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1946386AbWKJKgb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 05:36:31 -0500
Message-ID: <4554552E.8050300@openvz.org>
Date: Fri, 10 Nov 2006 13:32:14 +0300
From: Pavel Emelianov <xemul@openvz.org>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: balbir@in.ibm.com
CC: Pavel Emelianov <xemul@openvz.org>, dev@openvz.org,
       ckrm-tech@lists.sourceforge.net, haveblue@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux MM <linux-mm@kvack.org>, rohitseth@google.com
Subject: Re: [ckrm-tech] [RFC][PATCH 6/8] RSS controller shares allocation
References: <20061109193523.21437.86224.sendpatchset@balbir.in.ibm.com>	<20061109193619.21437.84173.sendpatchset@balbir.in.ibm.com> <45544240.80609@openvz.org> <45545429.7080903@in.ibm.com>
In-Reply-To: <45545429.7080903@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[snip]

>>> +	for_each_child(child, res->rgroup) {
>>> +		child_res = get_memctlr(child);
>>> +		BUG_ON(!child_res);
>>> +		recalc_and_propagate(child_res, res);
>> Recursion? Won't it eat all the stack in case of a deep tree?
> 
> The depth of the hierarchy can be controlled. Recursion is needed
> to do a DFS walk

That's another point against recursion - bad root can
crash the kernel... If we are about to give container's
users ability to make their own subtrees then we *must*
avoid recursion. There's an algorithm that allows one
to walk the tree like this w/o recursion.

[snip]

>> I didn't find where in this patches this callback is called.
> 
> It's a part of the resource groups infrastructure. It's been ported
> on top of Paul Menage's containers patches. The code can be easily
> adapted to work directly with containers instead of resource groups
> if required.


Could you please give me a link to the patch where this
is called?
