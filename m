Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278662AbRJSV2v>; Fri, 19 Oct 2001 17:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278663AbRJSV2m>; Fri, 19 Oct 2001 17:28:42 -0400
Received: from warden.digitalinsight.com ([208.29.163.2]:51678 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S278662AbRJSV2a>; Fri, 19 Oct 2001 17:28:30 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Reid Hekman <reid.hekman@ndsu.nodak.edu>
Cc: linux-kernel@vger.kernel.org
Date: Fri, 19 Oct 2001 13:07:37 -0700 (PDT)
Subject: Re: MODULE_LICENSE and EXPORT_SYMBOL_GPL
In-Reply-To: <3BD0203B.1080407@ndsu.nodak.edu>
Message-ID: <Pine.LNX.4.40.0110191257070.9276-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use this example becouse the question came up a week or so ago and I
don't remember seeing the issue resolved.

the problem posted is that a BSD no adv licence is GPL compatable and
source may be available and therefor BSD no adv modules should not taint
the kernel, on the other hand it's possible to have a BSD no adv licensed
module that the source is not available for and therefor it should taint
the kernel.

just knowing the license doesn't tell you if the source is available
(which is the stated goal of the taint stuff)

if instead of MODULE_LICENSE there was a MODULE_SOURCE tag this would not
be an issue, and the EXPORT_SYMBOL_GPL would obviously be a seperate
issue. as it is they both use the MODULE_LICENSE tag which confuses the
intent of both of them.

if BSD no adv is considered a non-tainting license then what's to stop all
the binary-module vendors from useing it in their modules? it doesn't
requrire that they give the source to anyone so it's no risk to their IP
but it avaids the 'bad press' of the kernel announcing that useing their
stuff taints the kernel.

on the other hand if BSD no adv is considered a taining license then you
are going against the statement that it's compatable with the GPL and you
are telling module programmers who release the source that BSD isn't good
enough they can only work with the linux kernel if they change to the GPL
(or one of the other approved licenses)

again my point is that knowing the license is not enough by itself to know
if the kernel should be considered tainted, so let's not try to do it this
way.

or if the intent really is to force everything to be GPL then just say so
rather then claiming that that's not your intent.

David Lang



On Fri, 19 Oct 2001, Reid Hekman wrote:

> Date: Fri, 19 Oct 2001 07:44:43 -0500
> From: Reid Hekman <reid.hekman@ndsu.nodak.edu>
> To: David Lang <dlang@diginsite.com>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: MODULE_LICENSE and EXPORT_SYMBOL_GPL
>
> David Lang wrote:
>
> > so are you saying that BSD licened modules are not going to be allowed to
> > use any future entry points (assuming they are all put under the the
> > export_symbol_gpl limits)?
> >
> > saying that existing stuff will not change doesn't answer the problem
> > about licences that may have source avilable (tainting) but may not. if
> > you assume either way you will cause a bunch of problems.
> >
> > David Lang
> >
>
>
> That's nonsense. OK, with a strict interpretation on the use of the
> MODULE_LICENSE and depending on the implementation of license strings,
> old BSD licensed code could taint a kernel, but according to
> http://www.gnu.org/licenses/license-list.html modified BSD licensed code
> or code falling under the similar X11 license is GPL compatible.
> Therefore if you distribute or contribute source for a module that is
> BSD licensed, and MODULE_LICENSE is implemented in a remotely sane way
> you will be able to install a BSD licensed module without tainting the
> kernel.
>
> >  On Thu, 18 Oct 2001, John Alvord wrote:
>
> >>Linus said that all existing entry points would remain untagged. Thus
> >>existing modules would not be affected.
> >>
> >>john
>
>
> The GPL includes as derivative works any code, when compiled or
> executed, that is linked with GPL covered code, calls functions or
> shares data structures. Simply fork()ing or exec()ing is not a
> derivative work. FSF states that linking and simply calling main() and
> returning is a border case(1). From that we can extrapolate a number of
> things. Simply doing a syscall is not a derivative work. As I have read
> in the past, Linus, for practical reasons, has stated that modules using
> published interfaces need not qualify as derivative works. Also,
> "modules" in the generic sense, say plugins for example, when written to
> link with GPL code need not be GPL themselves. So long as they are GPL
> compatible, they can be linked without violating the license. Hence,
> MODULE_LICENSE strings may include GPL compatible source distributing
> licenses, eg. newBSD or X11.
>
> MODULE_LICENSE & EXPORT_SYMBOL_GPL are good things. MODULE_LICENSE
> provides an easier way to screen binary only modules from submitted
> bugs. It doesn't prevent someone from running a tainted kernel and it
> also doesn't prevent someone on linux-kernel from investigating the bug
> report if they want to. MODULE_LICENSE also has the potential to educate
> users. EXPORT_SYMBOL_GPL throws a speed bump in front of potentially
> dangerous subsystem modules. The Linux Security Module interface is the
> most recent example of this(2). If modules are allowed to insert hooks
> willy nilly into the kernel, eventually large proprietary functionality
> could result, unfairly taking advantage of Linus' practical foresight.
> EXPORT_SYMBOL_GPL allows us a simple way to define "public" interfaces
> that binary only module writers can use and which symbols are off
> limits. There is no restriction on fair use, as you can still remove the
>   disabling GPL compatible exports for internal, non-released code.
> Also, we are afforded more leeway in the future. If general consesus is
> that we need to let a proprietary vendor use a GPL symbol, we can always
> remove the restriction. Alternatively, if a vendor realizes he could
> write a better module if only he could use GPL-compatible-only symbols
> he may think twice and release the source. In the end, thats a solution
> I can live with.
>
> Regards,
> Reid
>
> 1. From GNU GPL FAQ:
> http://www.gnu.org/licenses/gpl-faq.html#GPLModuleLicense
>
> 2. http://lwn.net/2001/1004/kernel.php3
>
