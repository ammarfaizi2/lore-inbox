Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265288AbUATA3i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 19:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264591AbUATA2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 19:28:01 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:55945 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S265248AbUATA0C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 19:26:02 -0500
In-Reply-To: <20040120000405.GA5656@kroah.com>
References: <3FC7B008-487C-11D8-AED9-000A95A0560C@us.ibm.com> <20040117001739.GB3840@kroah.com> <400C3D87.3010502@us.ibm.com> <20040120000405.GA5656@kroah.com>
Mime-Version: 1.0 (Apple Message framework v609)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1DFA0D5A-4ADF-11D8-B557-000A95A0560C@us.ibm.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: kobj_to_dev ?
Date: Mon, 19 Jan 2004 18:25:14 -0600
To: Greg KH <greg@kroah.com>
X-Mailer: Apple Mail (2.609)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 19, 2004, at 6:04 PM, Greg KH wrote:

> On Mon, Jan 19, 2004 at 02:26:47PM -0600, Hollis Blanchard wrote:
>> Greg KH wrote:
>>>
>>> How about just adding a find_device() function to the driver core, 
>>> where
>>> you pass in a name and a type, so that others can use it?
>>
>> Something like this?
>
> Very nice, yes.  But I'll rename it to device_find() to keep the
> namespace sane.  Sound ok?

Sure. I'm having a problem inside kset_find_obj() when actually using 
it though, and I'm not sure if it's my fault or not. It seems there are 
kobjects present for which kobject_name() returns NULL.

kset_find_obj:
	list_for_each(entry,&kset->list) {
		struct kobject * k = to_kobj(entry);
		if (!strcmp(kobject_name(k),name)) {
			ret = k;
			break;
		}
	}

where "kset" above is "&my_bus_type.devices". strcmp doesn't like NULL 
and panics. I've registered 11 devices in my_bus_type, and all of them 
have names (device_add() makes sure of that).

Does this sound like my fault?

-- 
Hollis Blanchard
IBM Linux Technology Center

