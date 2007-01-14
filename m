Return-Path: <linux-kernel-owner+w=401wt.eu-S1751689AbXANV0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689AbXANV0s (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 16:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751688AbXANV0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 16:26:48 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:39837 "EHLO
	gepetto.dc.ltu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbXANV0q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 16:26:46 -0500
Message-ID: <45AAA090.6010701@student.ltu.se>
Date: Sun, 14 Jan 2007 22:28:48 +0100
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] How to (automatically) find the correct maintainer(s)
References: <45A9092F.7060503@student.ltu.se> <tkrat.428a51215926acac@s5r6.in-berlin.de> <45A93069.5080906@student.ltu.se> <tkrat.343d5eb8f1097532@s5r6.in-berlin.de> <45A96C3F.3090307@student.ltu.se> <tkrat.af9f8565dea59963@s5r6.in-berlin.de>
In-Reply-To: <tkrat.af9f8565dea59963@s5r6.in-berlin.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Richter wrote:
> On 14 Jan, Richard Knutsson wrote:
>   
>> Stefan Richter wrote:
>>     
> [getting a wrong contact from looking at the MAINTAINERS file]
>   
>> Hopefully, but I think it is asking much of the maintainer and then 
>> there will certanly be confused/frustrated submitter who don't know why 
>> they don't get any answer nor patched included. We have already seen a 
>> few asking about what happened with their patches.
>>     
>
> Sure. But such glitches occur due to lack of research by the submitter
> or due to missing information about maintainers. Neither one would be
> made worse nor cured by adding script-readable references to sources or
> config options to the MAINTAINERS file.
>   
I suspect I have misunderstood your idea. Correct me if this is wrong:
if you add:

F:	drivers/pci

Then also the directories hotplug and pcie (and its content) will fall 
to that entry, unless there is someone adding:

F:	drivers/pci/hotplug

in their entry.

With the approach I suggested that is not possible (unless introducing 
wildcards).

Also, a maintainer for the "hotplug" have to add:

F:	drivers/pci/hotplug
F:	drivers/pci/setup-bus
or
C:	HOTPLUG

and what will hinder it from including drivers/pci/hotplug/ other then 
adding the F: on PCI Hotplugs maintainer? (yes, this is no real problem 
since they probably are the same maintainer or just add the F: )
>>>> Can you make a object-file out of 2 c-files? Using Makefile?
>>>>         
>>> Yes, you can, although I don't know if it is directly done in the
>>> kernel build system.
>>>       
> [...]
>   
>> How?:
>> gcc -c test.c test2.c -o test3.o
>> gcc: cannot specify -o with -c or -S with multiple files
>> (with only -c i got test.o and test2.o)
>>     
>
> gcc -o test3.o test.c test.c
>   
That produces just an executable file with a misleading name :) (test 
with two files were neither has a 'main()')
You need the '-c'-flag to tell the gcc just make them to object-files.
>   
>> In the kernel building system, an object-file is made from a c- or 
>> s-file with the same name. Then, of course, they can be put together to 
>> a larger object-file.
>>     
> [...]
> [multiple references in one maintainer record]
>   
>> What about possibility to replace it with:
>>
>> C:	IEEE1394*
>>
>> and use the same system as with the path-approach, "longest wins". (I 
>> don't think just IEEE1394 is appropriate, since then there is 
>> possibility with false-positives again)
>>     
>
> I doubt that wildcards (or maybe regular expressions) are really needed.
> But this can only be found out by going through some non-trivial cases.
>   
Mm, that is just a feature. Best to get the basics straighten out first :)
>>> On the other hand, we could write
>>>
>>> IEEE 1394 SUBSYSTEM
>>> F:	drivers/ieee1394
>>> L:	linux1394-devel@lists.sourceforge.net
>>> P:	Ben and me
>>> [...]
>>> IEEE 1394 IPV4 DRIVER (eth1394)
>>> F:	drivers/ieee1394/eth1394
>>> [...]
>>>
>>> If it was done the latter way, i.e. using F: not C:, it could be
>>> made a rule that the more specific entries come after more generic
>>> entries. Thus the last match of multiple matches is the proper one.
>>> In any case, the longest match is the proper one.
>>>   
>>>       
>> As I wrote in the initial mail, my first idea was like that. But how to 
>> solve when different drivers (with of course different maintainers) lies 
>> in the same directory?
>>     
>
> To continue my above example:
>
> IEEE 1394 PCILYNX DRIVER
> F:	drivers/ieee1394/pcilynx
>
> Should work. Note, the substrings "eth1394" and "pcilynx" do not denote
> subdirectories. They are substrings of the paths to these drivers'
> sources nonetheless.
>   
Absolutely, also it can easily refer to the "include header-files" by:

F:	include/linux/pci.h

which is not as easily done in "my" way. The local headers are ok I 
think as the c-files that includes it should have the same maintainer, 
but ex pci.h are used by _quite_ many drivers. But is the headers in the 
include/-directory just a matter for the maintainer since they are 
globally reachable. But I think this is _the_ downside of that approach.
>> I thought something like include/linux/config.h,autoconf.h could be used 
>> when referring to a few specific files in a directory. But there is also 
>> the problem that all mails were the maintainer has no F: will fall in 
>> the lap of the "good" maintainer with the shorter pathway, and I'm 
>> afraid this might make people hesitant to add the F:.
>>     
>
> 1. The same can be said about the C: method, or about the status quo.
>   
No, since it is either a hit or it is not. Without wildcards, an entry like:

C:	CONFIG_IEEE1394

would not pick up ex CONFIG_IEEE1394_RAWIO.
> 2. The patches will typically be Cced to the respective mailinglist
>    where the driver maintainer can harvest the patch or can send an ACK
>    or NAK as a signal to the subsystem maintainer whether to pick it up.
> 3. When people notice that patches are misdirected too often, they will
>    update MAINTAINERS.
>   
You mean they update other maintainers entries? That would be good...
> [...]
>   
>> It is just the problems with false-positives and picking out specific
>> files that made me reconsider.
>>     
>
> May I remind that whoever uses scripts to figure out contacts should
> better double-check what the script found out for him. (Regardless
> whether the script grepped for config options or for path components.)
> There are carbon-based lifeforms on the receiving end.
>   
During development, that's a given. But I would hope that when its more 
stable it will always find the right answer or no answer at all (if 
there is errors in ex MAINTAINERS, even the human will bother the receiver)
> BTW, it seems to me like the F: approach is easier than the C: one when
> it comes to patches which touch only .h files. It is already somewhat
> costly to backtrack .c files from .o files from config options, but
> considerably more so with .h files.
>   
I think it is to early to be thinking about what is easier, first a 
"algorithm" that does what we want is needed, then I'm more then happy 
to write a script/program for it :)
Costly?? It is even simple in bash:
C_FILE=${O_FILE/'.o'/'.c'}
this have then just to be checked if existing, otherwise it is a 
.s-file. And this is just a userspace-application, if it takes a minute 
to go throe 200 files I think that is no problem, just gives the 
programmer time to drink another Jolt Cola.


The main reason I hold on my idea is that I would like to use the 
build-system to insure any changes with filenames or such, do not mean 
any changing to MAINTAINERS (aka, can you build the driver, you will 
find the maintainer if they have added it to their entry). But was just 
thinking, what about using something like (this may be the best of the two):

C:	THE_CONFIG_FLAG
I:	linux/global-header.h
(I: for "include". Btw, what is F: standing for? Is it instead of P:?)

I: may be extended for other headers also but I can't think of any use 
since a header included by a file in the same directory or a directory 
above (shorter pathway) (have seen use of special h-directories just for 
the header-files. It may cost a cycle or two, but as I said: userspace 
and I think the programmer will waste many more when just 
correct-reading the patch :)

