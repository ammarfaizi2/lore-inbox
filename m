Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968421AbWLEQTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968421AbWLEQTg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 11:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968423AbWLEQTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 11:19:35 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:56222 "EHLO
	mailout1.vmware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968421AbWLEQTf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 11:19:35 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [Openipmi-developer] [PATCH 9/12] IPMI: add pigeonpoint poweroff
Date: Tue, 5 Dec 2006 08:19:34 -0800
Message-ID: <FE74AC4E0A23124DA52B99F17F44159701DBC068@PA-EXCH03.vmware.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Openipmi-developer] [PATCH 9/12] IPMI: add pigeonpoint poweroff
Thread-Index: AccYg+eP9IsYYt30SeuDMUJ/Un6T9gABHSV4
References: <20061202043746.GE30531@localdomain><20061203132618.d7d58f59.akpm@osdl.org> <45738959.1000209@acm.org> <20061203185442.33faf1c0.randy.dunlap@oracle.com> <FE74AC4E0A23124DA52B99F17F44159701DBC05B@PA-EXCH03.vmware.com> <45739DB4.6000806@oracle.com> <4573A04A.2030909@oracle.com> <45757BD2.7020706@acm.org>
From: "Bela Lubkin" <blubkin@vmware.com>
To: "Corey Minyard" <minyard@acm.org>,
       "Randy Dunlap" <randy.dunlap@oracle.com>
Cc: "Andrew Morton" <akpm@osdl.org>,
       "OpenIPMI Developers" <openipmi-developer@lists.sourceforge.net>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Joseph Barnett" <jbarnett@motorola.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corey Minyard wrote: 
> Randy Dunlap wrote:
>> Randy Dunlap wrote:
>>> Bela Lubkin wrote:
>>>> Andrew Morton wrote:
>>>>
>>>>>> Sometime, please go through the IPMI code looking for all these
>>>>>> statically-allocated things which are initialised to 0 or NULL
>>>>>> and remove all those intialisations?  They're unneeded, they
>>>>>> increase the vmlinux image size and there are quite a number of
>>>>>> them.  Thanks.
>>>>
>>>> Randy Dunlop replied:
>>>>
>>>>> I was just about to send that patch.  Here it is,
>>>>> on top of the series-of-12.
>>>> ...
>>>>> -static int bt_debug = BT_DEBUG_OFF;
>>>>> +static int bt_debug;
>>>>
>>>> Is it wise to significantly degrade code readability to work around
>>>> a minor compiler / linker bug?
>>>
>>> Is that the only one that is a problem?
>>>
>>> I don't think it's a problem.  We *know* that static data areas
>>> are init to 0.  Everything depends on that.  If that didn't work
>>> it would all break.
>>>
>>> I could say that it's a nice coincidence that BT_DEBUG_OFF == 0,
>>> but I think that it's more than coincidence.
>>
>> It's Corey's decision.  However, while code readability is also very
>> important to me, I disagree with "significantly" above.
>
> I think the optimizations are probably important enough that this
> should be done.  Let's take Randy's patch and I will add a comment to
> BT_DEBUG_OFF that says that the value must be zero to correspond to
> the default uninitialized value.

Patch the declaration to:

  static int bt_debug;  /* 0 == BT_DEBUG_OFF */

Then any sort of grep / cscope / patch excerpts / etc. are self-
documenting.

>Bela<
