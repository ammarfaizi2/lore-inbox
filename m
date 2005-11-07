Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbVKGMUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbVKGMUw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 07:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbVKGMUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 07:20:52 -0500
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:27697 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S932337AbVKGMUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 07:20:51 -0500
X-SBRSScore: None
X-IronPort-AV: i="3.97,299,1125871200"; 
   d="scan'208"; a="19219991:sNHT25219496"
Message-ID: <436F469B.3080607@fujitsu-siemens.com>
Date: Mon, 07 Nov 2005 13:20:43 +0100
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Blaisorblade <blaisorblade@yahoo.it>
CC: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>,
       linux-kernel@vger.kernel.org, Allan Graves <allan.graves@oracle.com>
Subject: Re: [uml-devel] [PATCH 8/10] UML - Maintain own LDT entries
References: <200510310439.j9V4dfbw000872@ccure.user-mode-linux.org> <200511022051.24335.blaisorblade@yahoo.it>
In-Reply-To: <200511022051.24335.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Blaisorblade wrote:
> On Monday 31 October 2005 05:39, Jeff Dike wrote:
> 
>>From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
>>
>>Patch imlements full LDT handling in SKAS:
>> * UML holds it's own LDT table, used to deliver data on
>>   modify_ldt(READ)
>> * UML disables the default_ldt, inherited from the host (SKAS3)
>>   or resets LDT entries, set by host's clib and inherited in
>>   SKAS0
>> * A new global variable skas_needs_stub is inserted, that
>>   can be used to decide, whether stub-pages must be supported
>>   or not.
>> * Uses the syscall-stub to replace missing PTRACE_LDT (therefore,
>>   write_ldt_entry needs to be modified)
> 
> Two complaints against this patch (to be fixed afterwards, so I'm not CC'ing 
> akpm):
> 
> *) It reverts my cleanup and consolidation of ldt.c wrt. SKAS vs TT.
> 
> Or at least so I think (I must still give a proper look afterwards, and I'll 
> post patches). Actually it seems that this is done on purpose, but I don't 
> agree too much on this. I will see.

 From the beginning my new code for SKAS included the checks/buffering you later
inserted for TT and SKAS. So this patch is a second version adapted to your changes.
It shifts your improvements into TT path only (where I didn't do any changes in
my old patch), while it uses my own stuff for SKAS. Thus the patch doesn't really
revert your improvements, but restricts it to TT. As in SKAS0 UML now holds its own
LDT data, there is no need for buffering in this case. So I think it makes sense to
have separate code for SKAS.

	Bodo
