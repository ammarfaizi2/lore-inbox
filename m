Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbUBYPqo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 10:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbUBYPqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 10:46:44 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:3005 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261365AbUBYPqm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 10:46:42 -0500
In-Reply-To: <1077708874.22213.13.camel@gaston>
References: <1077667227.21201.73.camel@SigurRos.rchland.ibm.com> <20040225012845.GA3909@kroah.com> <opr3woijnwl6e53g@us.ibm.com> <20040225042224.GA5135@kroah.com> <1077708874.22213.13.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v612)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <C4149BD3-67A9-11D8-B826-000A95A0560C@us.ibm.com>
Content-Transfer-Encoding: 7bit
Cc: Ryan Arnold <rsa@us.ibm.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, Dave Boutcher <sleddog@us.ibm.com>
From: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: device/kobject naming
Date: Wed, 25 Feb 2004 09:46:24 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
X-Mailer: Apple Mail (2.612)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 25, 2004, at 5:34 AM, Benjamin Herrenschmidt wrote:
> On Wed, 2004-02-25 at 15:22, Greg KH wrote:
>> I agree.  Is there any reason we _have_ to stick with the OF names?  
>> It
>> seems to me to make more sense here not to, to make it more like the
>> rest of the kernel.
>>
>> That is, if the address after the @ is unique.  Is that always the 
>> case?
>
> One thing though is that it's only unique at a given level of
> hierarchy. The Unit Address in OF has no meaning outside of the
> context of the parent bus. That may be just fine for sysfs, but
> if I take as an example the PCI devices, they do have a globally
> unique ID here with the domain number.

Yes, that's certainly the case. Every unit address on the virtual bus 
will be unique, but device_add() uses dev.bus_id as the kobject name, 
which is system-wide.

Apparently PCI gets away with multiple busses by encoding the domain 
and bus IDs into dev.bus_id along with the slot number. Even then, it's 
just kind of coincidence that nothing else wants to register kobjects 
with names like 0000:00:0b.0, right? Unless we want to start defining 
mandatory "domains" for every type of device and prefixing things like 
that...

At any rate, virtual IO devices effectively have just a slot number and 
nothing else. Do you really want to start registering kobjects with 
names like "30000000"? Or what about "vio:30000000", and then have it 
show up as "/sys/devices/vio/vio:30000000"? Seems redundant to me.

-- 
Hollis Blanchard
IBM Linux Technology Center

