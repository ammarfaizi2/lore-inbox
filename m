Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263558AbTETROZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 13:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263798AbTETROZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 13:14:25 -0400
Received: from terminus.zytor.com ([63.209.29.3]:20126 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S263558AbTETROY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 13:14:24 -0400
Message-ID: <3ECA60B0.6040402@zytor.com>
Date: Tue, 20 May 2003 10:06:56 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>
CC: Riley Williams <Riley@Williams.Name>,
       David Woodhouse <dwmw2@infradead.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Recent changes to sysctl.h breaks glibc
References: <BKEGKPICNAKILKJKMHCAGECEDBAA.Riley@Williams.Name> <3ECA3535.7090608@nortelnetworks.com>
In-Reply-To: <3ECA3535.7090608@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> Riley Williams wrote:
> 
>> First, is there anything in include/asm that is actually needed
>> outside the kernel itself? There shouldn't be, and if there is,
>> it needs to be moved to a header under include/linux that is
>> included in the relevant include/asm file.
> 
> It's handy for stuff like getting high res timestamps without having to 
> ifdef the case of building on different architechtures.  Also, there are 
> files under include/linux which end up including asm stuff in turn.
> 
>> The basic rule would be that external software can make free
>> use of headers under include/linux but should never make any
>> use whatsoever of headers under include/kernel or include/asm
>> for any reason.
> 
> 
> What if the include/linux files themselves make use of the asm files?
> 

No, not acceptable.

The thing is, trying to redefine the old namespaces is hopeless at this 
point.  Hence the proposed new namespace <linux/abi/*.h> ... 
<linux/abi/arch/*.h> would be my preference for an arch-specific 
subnamespace.

Thus the rule is:

a) <linux/abi/*> files MUST NOT include files outside <linux/abi/*>

b) <linux/*.h> and <asm/*.h> are legacy namespaces.  They should be 
considered to be completely different in kernel and userspace -- in 
effect, glibc will eventually ship with its own set of these headers.

c) <linux/abi/*> files should be clean for inclusion from either kernel 
or userspace.

	-hpa


