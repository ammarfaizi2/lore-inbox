Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266547AbUHaEic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266547AbUHaEic (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 00:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266550AbUHaEic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 00:38:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13805 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266547AbUHaEi3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 00:38:29 -0400
Message-ID: <413400B6.6040807@pobox.com>
Date: Tue, 31 Aug 2004 00:38:14 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Tom Vier <tmv@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: silent semantic changes with reiser4
References: <20040825163225.4441cfdd.akpm@osdl.org> <20040825233739.GP10907@legion.cup.hp.com> <20040825234629.GF2612@wiggy.net> <1093480940.2748.35.camel@entropy> <20040826044425.GL5414@waste.org> <1093496948.2748.69.camel@entropy> <20040826053200.GU31237@waste.org> <20040826075348.GT1284@nysv.org> <20040826163234.GA9047@delft.aura.cs.cmu.edu> <Pine.LNX.4.58.0408260936550.2304@ppc970.osdl.org> <20040831033950.GA32404@zero> <Pine.LNX.4.58.0408302055270.2295@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408302055270.2295@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 30 Aug 2004, Tom Vier wrote:
> 
> 
>>On Thu, Aug 26, 2004 at 09:48:04AM -0700, Linus Torvalds wrote:
>>
>>> - safely synchronize globally visible data structures
>>>That's quite fundamental. 99% of what a kernel does is exactly that. TCP
>>>would be in user space too, if it wasn't for _exactly_ this issue. A lot
>>
>>What about microkernels? They do tcp in userspace.
> 
> 
> No they don't. They do TCP in a separate address space from user space, 
> that just also happens to be separate from the "microkernel address 
> space".
> 
> So a microkernel will have _more_ address spaces, and they won't be "user
> space". They'll be "server deamon space" or something. Now, that's also
> why they tend to have performance problems - because you need to copy the
> data between different address spaces, and switch the CPU context etc
> around.


Man, this thread came a long way.  I peek in and see a pet topic...


_My_ own definition of microkernel, which differs from traditional CS, 
is where I would love to see Linux go:  move as much as humanly possible 
to userspace, such that, the kernel only contains pagecache operations, 
driver fast paths, and security checks.  Move slow paths, including ACPI 
probing, PCI bus walking, driver init/reset paths, some of the ioctl 
handling, to userspace.  Be willing to accept extra context switches as 
a cost in all but the fast paths.

What you have left after you move all the slow paths to userspace is my 
version of a microkernel.  The kernel is still monolithic and a single 
address space, but a lot smaller.

Now this (a) is likely just a pipe dream and (b) will increase 
complexity because each driver will _require_ a userspace component, but 
hey... you gotta have goals in life.

	Jeff


