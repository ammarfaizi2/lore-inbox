Return-Path: <linux-kernel-owner+w=401wt.eu-S1750957AbXANBBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbXANBBN (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 20:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbXANBBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 20:01:12 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:41456 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957AbXANBBH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 20:01:07 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sun, 14 Jan 2007 02:00:41 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [RFC] How to (automatically) find the correct maintainer(s)
To: Richard Knutsson <ricknu-0@student.ltu.se>
cc: linux-kernel@vger.kernel.org
In-Reply-To: <45A96C3F.3090307@student.ltu.se>
Message-ID: <tkrat.af9f8565dea59963@s5r6.in-berlin.de>
References: <45A9092F.7060503@student.ltu.se>
 <tkrat.428a51215926acac@s5r6.in-berlin.de> <45A93069.5080906@student.ltu.se>
 <tkrat.343d5eb8f1097532@s5r6.in-berlin.de> <45A96C3F.3090307@student.ltu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Jan, Richard Knutsson wrote:
> Stefan Richter wrote:
[getting a wrong contact from looking at the MAINTAINERS file]
> Hopefully, but I think it is asking much of the maintainer and then 
> there will certanly be confused/frustrated submitter who don't know why 
> they don't get any answer nor patched included. We have already seen a 
> few asking about what happened with their patches.

Sure. But such glitches occur due to lack of research by the submitter
or due to missing information about maintainers. Neither one would be
made worse nor cured by adding script-readable references to sources or
config options to the MAINTAINERS file.

>>> Can you make a object-file out of 2 c-files? Using Makefile?
>>
>> Yes, you can, although I don't know if it is directly done in the
>> kernel build system.
[...]
> How?:
> gcc -c test.c test2.c -o test3.o
> gcc: cannot specify -o with -c or -S with multiple files
> (with only -c i got test.o and test2.o)

gcc -o test3.o test.c test.c

> In the kernel building system, an object-file is made from a c- or 
> s-file with the same name. Then, of course, they can be put together to 
> a larger object-file.
[...]
[multiple references in one maintainer record]
> What about possibility to replace it with:
> 
> C:	IEEE1394*
> 
> and use the same system as with the path-approach, "longest wins". (I 
> don't think just IEEE1394 is appropriate, since then there is 
> possibility with false-positives again)

I doubt that wildcards (or maybe regular expressions) are really needed.
But this can only be found out by going through some non-trivial cases.

>> On the other hand, we could write
>>
>> IEEE 1394 SUBSYSTEM
>> F:	drivers/ieee1394
>> L:	linux1394-devel@lists.sourceforge.net
>> P:	Ben and me
>> [...]
>> IEEE 1394 IPV4 DRIVER (eth1394)
>> F:	drivers/ieee1394/eth1394
>> [...]
>>
>> If it was done the latter way, i.e. using F: not C:, it could be
>> made a rule that the more specific entries come after more generic
>> entries. Thus the last match of multiple matches is the proper one.
>> In any case, the longest match is the proper one.
>>   
> As I wrote in the initial mail, my first idea was like that. But how to 
> solve when different drivers (with of course different maintainers) lies 
> in the same directory?

To continue my above example:

IEEE 1394 PCILYNX DRIVER
F:	drivers/ieee1394/pcilynx

Should work. Note, the substrings "eth1394" and "pcilynx" do not denote
subdirectories. They are substrings of the paths to these drivers'
sources nonetheless.

> I thought something like include/linux/config.h,autoconf.h could be used 
> when referring to a few specific files in a directory. But there is also 
> the problem that all mails were the maintainer has no F: will fall in 
> the lap of the "good" maintainer with the shorter pathway, and I'm 
> afraid this might make people hesitant to add the F:.

1. The same can be said about the C: method, or about the status quo.
2. The patches will typically be Cced to the respective mailinglist
   where the driver maintainer can harvest the patch or can send an ACK
   or NAK as a signal to the subsystem maintainer whether to pick it up.
3. When people notice that patches are misdirected too often, they will
   update MAINTAINERS.

[...]
> It is just the problems with false-positives and picking out specific
> files that made me reconsider.

May I remind that whoever uses scripts to figure out contacts should
better double-check what the script found out for him. (Regardless
whether the script grepped for config options or for path components.)
There are carbon-based lifeforms on the receiving end.

BTW, it seems to me like the F: approach is easier than the C: one when
it comes to patches which touch only .h files. It is already somewhat
costly to backtrack .c files from .o files from config options, but
considerably more so with .h files.
-- 
Stefan Richter
-=====-=-=== ---= -===-
http://arcgraph.de/sr/



