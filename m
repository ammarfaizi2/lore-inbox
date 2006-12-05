Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968314AbWLEPln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968314AbWLEPln (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 10:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968319AbWLEPln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 10:41:43 -0500
Received: from mta15.mail.adelphia.net ([68.168.78.77]:35217 "EHLO
	mta15.adelphia.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S968314AbWLEPlm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 10:41:42 -0500
Message-ID: <45757BD2.7020706@acm.org>
Date: Tue, 05 Dec 2006 08:01:54 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: Randy Dunlap <randy.dunlap@oracle.com>
CC: Bela Lubkin <blubkin@vmware.com>, Andrew Morton <akpm@osdl.org>,
       OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Joseph Barnett <jbarnett@motorola.com>
Subject: Re: [Openipmi-developer] [PATCH 9/12] IPMI: add pigeonpoint poweroff
References: <20061202043746.GE30531@localdomain><20061203132618.d7d58f59.akpm@osdl.org> <45738959.1000209@acm.org> <20061203185442.33faf1c0.randy.dunlap@oracle.com> <FE74AC4E0A23124DA52B99F17F44159701DBC05B@PA-EXCH03.vmware.com> <45739DB4.6000806@oracle.com> <4573A04A.2030909@oracle.com>
In-Reply-To: <4573A04A.2030909@oracle.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap wrote:
> Randy Dunlap wrote:
>> Bela Lubkin wrote:
>>> Andrew Morton wrote:
>>>
>>>>> Sometime, please go through the IPMI code looking for all these
>>>>> statically-allocated things which are initialised to 0 or NULL and
>>>>> remove
>>>>> all those intialisations?  They're unneeded, they increase the
>>>>> vmlinux
>>>>> image size and there are quite a number of them.  Thanks.
>>>
>>> Randy Dunlop replied:
>>>
>>>> I was just about to send that patch.  Here it is,
>>>> on top of the series-of-12.
>>> ...
>>>> -static int bt_debug = BT_DEBUG_OFF;
>>>> +static int bt_debug;
>>>
>>> Is it wise to significantly degrade code readability to work around
>>> a minor
>>> compiler / linker bug?
>>
>> Is that the only one that is a problem?
>>
>> I don't think it's a problem.  We *know* that static data areas
>> are init to 0.  Everything depends on that.  If that didn't work
>> it would all break.
>>
>> I could say that it's a nice coincidence that BT_DEBUG_OFF == 0,
>> but I think that it's more than coincidence.
>
> It's Corey's decision.  However, while code readability is also very
> important to me, I disagree with "significantly" above.
>
I think the optimizations are probably important enough that this should
be done.  Let's take Randy's patch and I will add a comment to
BT_DEBUG_OFF that says that the value must be zero to correspond to
the default uninitialized value.

-Corey

