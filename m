Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbWJHRTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWJHRTX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 13:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWJHRTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 13:19:22 -0400
Received: from main.gmane.org ([80.91.229.2]:14488 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751278AbWJHRTV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 13:19:21 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: Re: [PATCH] Minor coding style fix
Date: Sun, 08 Oct 2006 22:48:45 +0530
Message-ID: <452932F5.7090601@gmail.com>
References: <452913DB.4010409@gmail.com> <9a8748490610080829r54053e14ud8c7b02c8f39476c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
Cc: linux-kernel@vger.kernel.org
X-Gmane-NNTP-Posting-Host: 59.92.176.9
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
In-Reply-To: <9a8748490610080829r54053e14ud8c7b02c8f39476c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> On 08/10/06, Aneesh Kumar K.V <aneesh.kumar@gmail.com> wrote:
>> Kernel generally follow the style
>>
>> if (func()) {
>> /* failed case */
>> } else {
>> /* success */
>> }
>>
>>
> 
> Please submit patches inline, having to copy them from attachments to
> be able to reply is a pain.
> 
>>
>> diff --git a/kernel/sys.c b/kernel/sys.c
>> index 98489d8..55cb77c 100644
>> --- a/kernel/sys.c
>> +++ b/kernel/sys.c
>> @@ -517,7 +517,7 @@ EXPORT_SYMBOL_GPL(srcu_notifier_call_cha
>>  void srcu_init_notifier_head(struct srcu_notifier_head *nh)
>>  {
>>      mutex_init(&nh->mutex);
>> -    if (init_srcu_struct(&nh->srcu) < 0)
>> +    if (init_srcu_struct(&nh->srcu))
>>          BUG();
>>      nh->head = NULL;
>>  }
> 
> I really liked the old code better. If in the future
> init_srcu_struct() is changed to also return >0 for some conditions,
> then that would not previously have triggered BUG(), but after your
> changes it will. The code, as it were, perfectly expressed what it
> wanted to happen - if it returns less than zero it's a BUG().
> I say leave it alone.
> 
> 


As per Documentation/CodingStyle 

"Functions can return values of many different kinds, and one of the
most common is a value indicating whether the function succeeded or
failed.  Such a value can be represented as an error-code integer
(-Exxx = failure, 0 = success) or a "succeeded" boolean (0 = failure,
non-zero = success)."

That means if the function need to indicate success it should be made to return 0. 
I don't see any other value being returned from init_srcu_struct. Also having a consistent
style of if() check make code reading easier.

-aneesh 

