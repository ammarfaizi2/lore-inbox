Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbUBYT6P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 14:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbUBYT6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 14:58:15 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:16614 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S261273AbUBYT6H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 14:58:07 -0500
Message-ID: <403CFE48.8090009@matchmail.com>
Date: Wed, 25 Feb 2004 11:58:00 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grigor Gatchev <grigor@zadnik.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: A Layered Kernel: Proposal
References: <Pine.LNX.4.44.0402251112180.16939-100000@lugburz.zadnik.org>
In-Reply-To: <Pine.LNX.4.44.0402251112180.16939-100000@lugburz.zadnik.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grigor Gatchev wrote:
> 
> On Tue, 24 Feb 2004, Mike Fedyk wrote:
>>Not true.  What you are asking for is userspace protection to kernel
>>modules.  You won't get that unless you use a micro-kernel approach, or
>>run different parts of the kernel on different (to be i386 arch
>>specific) ring in the processor.  Once you get there, you have to deal
>>with the various processor errata since not many OSes use rings besides
>>0 and 3 (maybe ring 1?).
> 
> 
> These are two possible approaches. Still another is to have the lowest
> layer export functions for memory handling - thus only the lowest layer
> will have to run in ring 0 (almost all arch that support Linux have a
> corresponding ability), and will handle the protection requests from the
> upper layers... Other approaches exist, too. A discussion may help to
> clarify which is the best.
> 

And you get an effective "context switch" even if you're not crossing 
process boundaries.  (it could be argued that different layers on 
seperate rings are effectively now a "process"...)

> 
>>>User nesting: The traditional Unix user management model has two levels:
>>>superuser (root) and subusers (ordinary users). Subusers cannot create
>>>and administrate their subusers, install system-level resources, etc.
>>>Running, however, a subuser in their own virtual machine and Personality
>>>layer as its root, will allow tree-like management of users and resources
>>>usage/access. (Imagine a much enhanced chroot.)
>>
>>That is differing security models, and it's being worked on with (I
>>forget the term) the security module framework.
> 
> 
> Within a layered kernel scheme, this tree-like model is very natural and
> simple: all protection is provided by the standard kernel mechanisms. Of
> course, it maybe can be improved; that is what the discussion is for.
> 
> 
>>>Platforming: It is much easier to write only a Personality layer than an
>>>entire kernel, esp. if you have a layer interface open standard as a
>>>base. Respectively, it's easier to write only a Resources layer, adding a
>>>new hardware to the "Supported by Linux" list. This will help increasing
>>>supported both hardware and platforms. Also, thus you may run any
>>>platform on any hardware, or many platforms concurrently on the same
>>>hardware.
>>
>>There is arch specific, and generic setions of the kernel source tree
>>already.  How do you want to improve upon that?
> 
> 
> Currently, Linux supports (actually, is) only one, Unix-descended
> platform. With a layered model, an emulator, eg. Wine, could be easily
> rewritten as a Personality layer, and this would turn it instantly into
> a free Windows. A modification of the Linux sofware and tools could
> produce a free Solaris. Some people may like a free OS/2, QNX, VxWorks
> etc. Other platforms will became easier to create and test, thus helping
> the free software evolution. On most architectures, you will be able to
> emulate another processor right in the kernel, either directly, or by a
> code emulator: all other will go then much easier. Much more advantages
> exist...
> 

One way or another, you'd have to have a "personality".  With Linux 
there is one in the kernel, and possibly many in userspace.  You won't 
find many here that will agree it should be any other way.

