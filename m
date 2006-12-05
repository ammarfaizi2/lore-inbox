Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968307AbWLEPlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968307AbWLEPlg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 10:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968316AbWLEPlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 10:41:36 -0500
Received: from mta11.adelphia.net ([68.168.78.205]:48382 "EHLO
	mta11.adelphia.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968314AbWLEPlf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 10:41:35 -0500
Message-ID: <45757937.3030307@acm.org>
Date: Tue, 05 Dec 2006 07:50:47 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>,
       Carol Hebert <cah@us.ibm.com>
Subject: Re: [Patch 2/12] IPMI: remove interface number limits
References: <20061202042422.GB30214@localdomain> <20061203132605.ee8028a5.akpm@osdl.org>
In-Reply-To: <20061203132605.ee8028a5.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Fri, 1 Dec 2006 22:24:22 -0600
> Corey Minyard <minyard@acm.org> wrote:
>
>   
>> This patch removes the arbitrary limit of number of IPMI interfaces.
>> This has been tested with 8 interfaces.
>>
>> Signed-off-by: Corey Minyard <minyard@acm.org>
>> Cc: Carol Hebert <cah@us.ibm.com>
>>
>> ..
>>
>> +struct watcher_entry {
>> +	struct list_head link;
>> +	int intf_num;
>> +};
>> +
>>  int ipmi_smi_watcher_register(struct ipmi_smi_watcher *watcher)
>>  {
>> -	int           i;
>> -	unsigned long flags;
>> +	ipmi_smi_t intf;
>> +	struct list_head to_deliver = LIST_HEAD_INIT(to_deliver);
>> +	struct watcher_entry *e, *e2;
>> +
>> +	mutex_lock(&ipmi_interfaces_mutex);
>> +
>> +	list_for_each_entry_rcu(intf, &ipmi_interfaces, link) {
>> +		if (intf->intf_num == -1)
>> +			continue;
>> +		e = kmalloc(sizeof(*e), GFP_KERNEL);
>> +		if (!e)
>> +			goto out_err;
>>     
>
> You miss a mutex_unlock(&ipmi_interfaces_mutex) here
>   
This is actually fixed in patch 4 (ipmi-system-interface-hotplug.patch)

-Corey

