Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbVCNQrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbVCNQrg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 11:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261591AbVCNQrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 11:47:35 -0500
Received: from fmr19.intel.com ([134.134.136.18]:38067 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261588AbVCNQrV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 11:47:21 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 3/6] PCI Express Advanced Error Reporting Driver
Date: Mon, 14 Mar 2005 08:47:14 -0800
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E50240803A103@orsmsx404.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 3/6] PCI Express Advanced Error Reporting Driver
Thread-Index: AcUm2jUNSDAjmfhPR1SBcNXXp9PoLwB2lipw
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Greg KH" <greg@kroah.com>, "long" <tlnguyen@snoqualmie.dp.intel.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-pci@atrey.karlin.mff.cuni.cz>,
       "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 14 Mar 2005 16:47:14.0350 (UTC) FILETIME=[798E7CE0:01C528B5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, March 11, 2005 11:28 PM Greg KH wrote:
>> +
>> +LIST_HEAD(evt_queue);			/* Define Event Queue
List */
>
>Make this static?

Agree, will make this static. Good comment! Thanks.


>> +
>> +/**
>> + * evt_queue_pop - restore an event node from an event log list 
>> + * @where: either from top or bottom of a list
>> + *
>> + * Invoked when an error being consumed
>> + **/
>> +static struct event_node* evt_queue_pop(int where)
>> +{
>> +	struct list_head *head = &evt_queue;
>> +	struct event_node *evt_node = NULL;
>> +
>> +	if (!list_empty(head)) {
>> +		head = ((where == GET_ERR_RECORD_TOP) ? head->prev :
head->>next);
>> +		evt_node = container_of(head, struct event_node,
e_node);
>> +		list_del(&evt_node->e_node);
>> +		records--;
>> +	}
>> +
>> +	return evt_node;
>> +}
>
>The lock is not held in the pop, like it is in the push function.  Any
>reason for this?

The lock is held by its caller, consume_record. I can add a comment at
this function to make it clear.

Thanks,
Long
