Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261731AbVEJSki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbVEJSki (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 14:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVEJSki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 14:40:38 -0400
Received: from fmr18.intel.com ([134.134.136.17]:63913 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261731AbVEJSkJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 14:40:09 -0400
x-mimeole: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 2/4] rt_mutex: add new plist implementation
Date: Tue, 10 May 2005 11:39:45 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A0338B637@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2/4] rt_mutex: add new plist implementation
Thread-Index: AcVVURNQ2V+gWIB9S02VrK0TMwOPmwAPHaJg
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Oleg Nesterov" <oleg@tv-sign.ru>
Cc: "Ingo Molnar" <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
       "Daniel Walker" <dwalker@mvista.com>
X-OriginalArrivalTime: 10 May 2005 18:39:46.0347 (UTC) FILETIME=[A39B37B0:01C5558F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Oleg Nesterov
>"Perez-Gonzalez, Inaky" wrote:
>>
>> >From: Oleg Nesterov
>>
>> >+extern void plist_add(struct pl_node *node, struct pl_head *head);
>> >+extern void plist_del(struct pl_node *node);
>>
>> At least I'd add return codes for this if the head's priority=20
>> changes (or in this case, because head's have no prio, if the=20
>> first node's  prio change).
>
>I am not sure I understand you. Why should we track ->prio=20 changes?
>plist should be generic, I think.

Errr....shut, that was my or your email program screwing
things up...that =20, I mean, that's MIME for line break.

>This could be:
>	int plist_add_and_check_min_prio_changed(node, head)
>	{
>		plist_add(node, head);
>		return plist_next(head) == node;
>	}
>
>Or plist_add() could be easily changed to return -1,0,+1 to indicate
>min/max prio changed/unchanged.

The -1/0/+1 sounds pretty good. 

>Currently these functions are used in void context only. I think
>it is better to add return codes when callers need them.
>
>What do you think?

I guess I am still very biased by my implementation, where returning
that was almost free because of how the functions where implemented
(which steamed from the fact that they had to always compute the
new priority to store it in the head).

So as you say, the best way is wrapping your primitives around. I'd
suggest a shorter postfix, something like _prio() or _chkprio().

Thanks,

-- Inaky
