Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265222AbUHYVeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265222AbUHYVeg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 17:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbUHYVeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 17:34:00 -0400
Received: from mail.tmr.com ([216.238.38.203]:15110 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S268729AbUHYV11 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 17:27:27 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: [PATCH] /dev/crypto for Linux
Date: Wed, 25 Aug 2004 17:28:00 -0400
Organization: TMR Associates, Inc
Message-ID: <cgivru$306$1@gatekeeper.tmr.com>
References: <412BB517.4040204@suse.cz> <Xine.LNX.4.44.0408251025120.25396-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1093468863 3078 192.168.12.100 (25 Aug 2004 21:21:03 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
In-Reply-To: <Xine.LNX.4.44.0408251025120.25396-100000@thoron.boston.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris wrote:
> On Tue, 24 Aug 2004, Michal Ludvig wrote:
> 
> 
>>How does it work?
>>- - Process opens /dev/crypto and with a set of ioctl() commands does what
>>it wants to. I.e. obtains a crypto session, does the {enc,dec}ryption
>>and finally closes the session. The sessions are bound to "struct file"
>>of the open /dev/crypto and thus are automatically removed even if the
>>process dies unexpectedly.
> 
> 
> I don't think this is the way forward for the user crypto API.  Rather 
> than using the openbsd device as a starting point, we need to look at what 
> is the best for Linux and work from there.
> 
> In any case, the openbsd device is the wrong model.  An ioctl() based 
> interface is just a set of backdoor syscalls, but with weak semantics, and 
> a potential maintenance nightmare.
> 
> At this stage, the only real use for the device is to make it easier to 
> test and benchmark the crypto modules, and I'm not sure if this is enough 
> justification for integration with the kernel at this stage.  Currently, 
> the tcrypt module provides a convienient way to test modules on whatever 
> architecture you can boot a kernel on, without the need for external 
> userspace packages.  It also tests some specific scatterlist cases.  So, 
> your crypto dev would not likely be considered a full replacement for 
> tcrypt at this stage.

The use of this would be to provide some access to crypto for portable 
programs which might be usefully run on systems which have not installed 
the big libs needed for usermode crypto. And it also addresses the 
reality that many people update their kernel more often than their libs, 
and new methods are more likely to be available there. For a low-volume 
task like encoding a key or other small chunk of data it might be that 
the overhead of the system call would be no more than the memory 
footprint of loading a lib to do a single operation.

And every time I see a new method in the kernel, I wonder why it's there 
is users can't access it?

Don't take this as a stand to include this, I'm just being devil's 
advocate and bringing up the benefits since multiple people are bringing 
up the drawbacks. If this was actually going to happen it *might* be 
done with a totally different interface and happen in a kernel thread or 
some such. One feature of MULTICS we don't have is the ability to 
execute kernel code in user mode, sort of like a shared library.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
