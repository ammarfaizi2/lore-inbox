Return-Path: <linux-kernel-owner+w=401wt.eu-S1422812AbXAMXbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422812AbXAMXbO (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 18:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422819AbXAMXbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 18:31:14 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:59635 "EHLO
	gepetto.dc.ltu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422812AbXAMXbN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 18:31:13 -0500
Message-ID: <45A96C3F.3090307@student.ltu.se>
Date: Sun, 14 Jan 2007 00:33:19 +0100
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] How to (automatically) find the correct maintainer(s)
References: <45A9092F.7060503@student.ltu.se> <tkrat.428a51215926acac@s5r6.in-berlin.de> <45A93069.5080906@student.ltu.se> <tkrat.343d5eb8f1097532@s5r6.in-berlin.de>
In-Reply-To: <tkrat.343d5eb8f1097532@s5r6.in-berlin.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Richter wrote:
> On 13 Jan, Richard Knutsson wrote:
>   
>> Stefan Richter wrote:
>>     
>>> On 13 Jan, Richard Knutsson wrote:
>>> [...]
>>>   
>>>       
>>>> SUPERCOOL ALPHA CARD
>>>>
>>>> P:	Clark Kent
>>>> M:	superman@krypton.kr
>>>> L:	some@thing.com
>>>> C:	SUPER_A
>>>> S:	Maintained
>>>> (C: for CONFIG. Any better idea?)
>>>>
>>>> then if someone changes a file who are built with CONFIG_SUPER_A, can 
>>>> easily backtrack it to the correct maintainer(s).
>>>>     
>>>>         
>>> [...]
>>>   
>>>       
>>>> My first idea was to use the pathway and define that directories above 
>>>> the specified (if not specified by another) would fall to the current 
>>>> maintainer. It would work, but requires that all pathways be specified 
>>>> at once, or a few maintainers with "short" pathways would get much of 
>>>> the patches (and it is not as correct/easy to maintain as looking for 
>>>> the CONFIG_flag).
>>>>
>>>>
>>>> Any thoughts on this is very much appreciated (is there any flaws with 
>>>> this?).
>>>>     
>>>>         
>>>  - What about drivers which have no MAINTAINER entry but reside in a
>>>    subsystem with MAINTAINER entry?
>>>   
>>>       
>> Hmm, how are those drivers built? Can you please point me to one?
>>     
>
> I believe you read too quickly what I wrote, didn't you? :-)
> The MAINTAINER file doesn't influence how drivers are built.
>   
What the... now I have no idea why I deleted the previous text... oh 
well, I tried 'grep -Er "^M\:" */*' but did not find any such entries. 
Or did you mean files just stating "I maintaining this file"?
At least I know so much about the building-process that I don't think 
MAINTAINER is involved :). It was meant as: how is a driver build 
without some CONFIG_-flag set, but not sure now what I wanted with that 
(blaming low blood-suger, got a pizza since then).
>   
>>>  - What if these drivers depend on two subsystems?
>>>   
>>>       
>> Not sure if I understand the problem. I don't see the maintainers for 
>> the subsystems too interested in a driver, and it is the drivers 
>> maintainer we want.
>>     
>
> I am specifically thinking of drivers which are maintained by the
> subsystem maintainers. (Well, see below...)
>   
More then one subsystem maintainers that is maintainers to a driver? I 
would think one off those would quite naturally become the maintainer of 
the driver and then accepting patches from the rest.
> Besides, the subsystem maintainer could point the submitter to a
> more appropriate channel or ignore the submitter. (A submitter who
> feels ignored is hopefully doing some more research then.) Also,
> a driver maintainer certainly reads the mailinglist to which the
> submitter posted.
>   
Hopefully, but I think it is asking much of the maintainer and then 
there will certanly be confused/frustrated submitter who don't know why 
they don't get any answer nor patched included. We have already seen a 
few asking about what happened with their patches.
>>>  - Config options map to object files but do not map directly to source
>>>    files. Diffstats show source files.
>>>   
>>>       
>> Can you make a object-file out of 2 c-files? Using Makefile?
>>     
>
> Yes, you can, although I don't know if it is directly done in the
> kernel build system. Of course what is often done is to make n object
> files out of n c files, then link them to make 1 object file.
>   
How?:
gcc -c test.c test2.c -o test3.o
gcc: cannot specify -o with -c or -S with multiple files
(with only -c i got test.o and test2.o)

In the kernel building system, an object-file is made from a c- or 
s-file with the same name. Then, of course, they can be put together to 
a larger object-file.
>>> Example: The sbp2 driver is an IEEE 1394 driver and a SCSI driver.
>>> sbp2.o is enabled by CONFIG_IEEE1394_SBP2 which depends on
>>> CONFIG_IEEE1394 and CONFIG_SCSI. sbp2.c resides in drivers/ieee1394/.
>>> What is the algorithm to look up sbp2's maintainers?
>>>   
>>>       
>> The one listed for CONFIG_IEEE1394_SBP2 :)
>>     
>
> ...OK, we /could/ write
>
> IEEE 1394 SUBSYSTEM
> C:	IEEE1394
> C:	IEEE1394_OHCI1394
> C:	IEEE1394_SBP2
> C:	IEEE1394_DV1394  /* would better be put into a new own entry due to different status of maintenance level */
> C:	IEEE1394_VIDEO1394  /* that one perhaps too */
> L:	linux1394-devel@lists.sourceforge.net
> P:	Ben and me
> [...]
> IEEE 1394 IPV4 DRIVER (eth1394)
> C:	IEEE1394_ETH1394
> [...]
>   
What about possibility to replace it with:

C:	IEEE1394*

and use the same system as with the path-approach, "longest wins". (I 
don't think just IEEE1394 is appropriate, since then there is 
possibility with false-positives again)
> On the other hand, we could write
>
> IEEE 1394 SUBSYSTEM
> F:	drivers/ieee1394
> L:	linux1394-devel@lists.sourceforge.net
> P:	Ben and me
> [...]
> IEEE 1394 IPV4 DRIVER (eth1394)
> F:	drivers/ieee1394/eth1394
> [...]
>
> If it was done the latter way, i.e. using F: not C:, it could be
> made a rule that the more specific entries come after more generic
> entries. Thus the last match of multiple matches is the proper one.
> In any case, the longest match is the proper one.
>   
As I wrote in the initial mail, my first idea was like that. But how to 
solve when different drivers (with of course different maintainers) lies 
in the same directory?
I thought something like include/linux/config.h,autoconf.h could be used 
when referring to a few specific files in a directory. But there is also 
the problem that all mails were the maintainer has no F: will fall in 
the lap of the "good" maintainer with the shorter pathway, and I'm 
afraid this might make people hesitant to add the F:.
>   
>> But what about ex ieee1394_core.o? Is ieee1394-objs "equal" to 
>> ieee1394.o? (Seems I need to read some Makefile docs...)
>>     
>
> Yes and yes. (Documentation/kbuild/makefiles.txt)
>   
Thanks
>> (Btw, what I can see, there is no possibility to get the wrong 
>> maintainer. Just that sometime it can't give you an answer and you have 
>> to do it in the old way).
>>     
>
> Your approach could give a wrong answer if someone implements a
> very "clever" mapping. My approach could give a wrong answer if
> someone takes a generic match while there was a more specific
> match.
>
> Your approach requires to evaluate the diffstat, one or more
> Makefile (taking the Linux Makefile syntax into account), and the
> MAINTAINERS file. My approach just requires to evaluate the
> diffstat and the MAINTAINERS file.
>   
Can't disagree on any. It is just the problems with false-positives and 
picking out specific files that made me reconsider.

