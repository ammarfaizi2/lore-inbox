Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278381AbRJSMqQ>; Fri, 19 Oct 2001 08:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278382AbRJSMqG>; Fri, 19 Oct 2001 08:46:06 -0400
Received: from smtp1.ndsu.NoDak.edu ([134.129.111.146]:48397 "EHLO
	smtp1.ndsu.nodak.edu") by vger.kernel.org with ESMTP
	id <S278381AbRJSMpx>; Fri, 19 Oct 2001 08:45:53 -0400
Message-ID: <3BD0203B.1080407@ndsu.nodak.edu>
Date: Fri, 19 Oct 2001 07:44:43 -0500
From: Reid Hekman <reid.hekman@ndsu.nodak.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011018
X-Accept-Language: en-us
MIME-Version: 1.0
To: David Lang <dlang@diginsite.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: MODULE_LICENSE and EXPORT_SYMBOL_GPL
In-Reply-To: <Pine.LNX.4.40.0110181655340.1380-100000@dlang.diginsite.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:

> so are you saying that BSD licened modules are not going to be allowed to
> use any future entry points (assuming they are all put under the the
> export_symbol_gpl limits)?
> 
> saying that existing stuff will not change doesn't answer the problem
> about licences that may have source avilable (tainting) but may not. if
> you assume either way you will cause a bunch of problems.
> 
> David Lang
> 


That's nonsense. OK, with a strict interpretation on the use of the 
MODULE_LICENSE and depending on the implementation of license strings, 
old BSD licensed code could taint a kernel, but according to 
http://www.gnu.org/licenses/license-list.html modified BSD licensed code 
or code falling under the similar X11 license is GPL compatible. 
Therefore if you distribute or contribute source for a module that is 
BSD licensed, and MODULE_LICENSE is implemented in a remotely sane way 
you will be able to install a BSD licensed module without tainting the 
kernel.

>  On Thu, 18 Oct 2001, John Alvord wrote:

>>Linus said that all existing entry points would remain untagged. Thus
>>existing modules would not be affected.
>>
>>john


The GPL includes as derivative works any code, when compiled or 
executed, that is linked with GPL covered code, calls functions or 
shares data structures. Simply fork()ing or exec()ing is not a 
derivative work. FSF states that linking and simply calling main() and 
returning is a border case(1). From that we can extrapolate a number of 
things. Simply doing a syscall is not a derivative work. As I have read 
in the past, Linus, for practical reasons, has stated that modules using 
published interfaces need not qualify as derivative works. Also, 
"modules" in the generic sense, say plugins for example, when written to 
link with GPL code need not be GPL themselves. So long as they are GPL 
compatible, they can be linked without violating the license. Hence, 
MODULE_LICENSE strings may include GPL compatible source distributing 
licenses, eg. newBSD or X11.

MODULE_LICENSE & EXPORT_SYMBOL_GPL are good things. MODULE_LICENSE 
provides an easier way to screen binary only modules from submitted 
bugs. It doesn't prevent someone from running a tainted kernel and it 
also doesn't prevent someone on linux-kernel from investigating the bug 
report if they want to. MODULE_LICENSE also has the potential to educate 
users. EXPORT_SYMBOL_GPL throws a speed bump in front of potentially 
dangerous subsystem modules. The Linux Security Module interface is the 
most recent example of this(2). If modules are allowed to insert hooks 
willy nilly into the kernel, eventually large proprietary functionality 
could result, unfairly taking advantage of Linus' practical foresight. 
EXPORT_SYMBOL_GPL allows us a simple way to define "public" interfaces 
that binary only module writers can use and which symbols are off 
limits. There is no restriction on fair use, as you can still remove the 
  disabling GPL compatible exports for internal, non-released code. 
Also, we are afforded more leeway in the future. If general consesus is 
that we need to let a proprietary vendor use a GPL symbol, we can always 
remove the restriction. Alternatively, if a vendor realizes he could 
write a better module if only he could use GPL-compatible-only symbols 
he may think twice and release the source. In the end, thats a solution 
I can live with.

Regards,
Reid

1. From GNU GPL FAQ: 
http://www.gnu.org/licenses/gpl-faq.html#GPLModuleLicense

2. http://lwn.net/2001/1004/kernel.php3

