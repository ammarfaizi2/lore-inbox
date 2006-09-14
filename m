Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbWINLnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbWINLnn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 07:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWINLnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 07:43:43 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:54751 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751218AbWINLnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 07:43:42 -0400
Message-ID: <4509408A.3000205@arcor.de>
Date: Thu, 14 Sep 2006 13:44:10 +0200
From: Jan Dinger <jan.dinger@arcor.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.18-rc7 Debian
References: <45092AB8.2050401@arcor.de> <20060914112058.GA28548@fiberbit.xs4all.nl>
In-Reply-To: <20060914112058.GA28548@fiberbit.xs4all.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Very nice, special thanks for super-help :) Ill test it as soon as possible!

So long

Jan

Marco Roeland wrote:
> On Thursday September 14th 2006 at 12:11 Jan Dinger wrote:
>
>   
>> [mostly Debian specific]
>>     
>
>   
>> Ill compiling my own kernel. i?ve downloaded the archive and unpacked 
>> the archive.
>>
>> ...
>>
>> #make menuconfug
>> success
>>     
>
> In general please do not compile the kernel (or anything else) as root,
> but under a normal user account. If you, or some scripts, make a mistake
> it will be rather costly! Strictly speaking it is not an error, and will
> work, but it is a rather dangerous practice.
>
> Under Debian you normally run the "make-kpkg" script with the help of
> the "fakeroot" package:
>
> $ fakeroot make-kpkg ...
>
> Only the final install of the generated .deb package needs you to become
> root or use "sudo".
>
>   
>> Next i will create my debian-package and will include the new patch.
>>
>> # make-kpkg kernel_image --revision=jan-1.0 --append_to_version jan-1.0 
>> --added-patches=patch-2.6.18-rc7
>>     
>
> Specifying a revision can indeed be very handy. Do note however that the
> revision here has to have a dot (.) but normally absolutely _not_ a dash
> (-) in it as you unfortunately did. This will most often lead to problems!
>
> No need for the "--added-patches=" here. You seem to have downloaded
> linux-2.6.18-rc7.tar.gz which is a complete version by itself, no need
> for additional patches here. If you regularly want or have to try
> different kernel versions please check http://www.kernelnewbies.org/FAQ
> on information on how to use patches, or try "git", http://git.or.cz .
> There are Debian packages for git in 'etch' and for 'sarge' on
> http://backports.org.
>
>   
>> The Error: debian/ruleset/misc/patches.mk:104: *** Could not find patch 
>> for patch-2.6.18-rc7.  Stop.
>>     
>
> Ok, it could not find the patches. That's because of the superfluous
> "--added-patches" in this case.
>
>   
>> My patch is under /usr/src/kernel-patches/patch-2.6.18-rc7.
>>
>> If i run the process without --added-patches, then i become this error:
>>
>> ====== making target configure-indep [new prereqs: 
>> stamp-configure-indep]======
>> ====== making target stamp-configure [new prereqs: configure-arch 
>> configure-indep]======
>> Problems ecountered with the version number jan-1.0.
>> The upstream version jan does not contain a digit
>>     
>
> This is because of the dash (-) in the version number.
>
>   
>> Please re-read the README file and try again.
>> exit 2
>> make: *** [sanity_check] Error 2
>>     
>
> After any error and indeed after succesfully making your .deb package,
> please use the 'clean' target before trying again or building a new
> package as the README and the man page for make-kpkg could have told
> you! ;-)
>
> $ fakeroot make-kpkg clean
>
>   
>> Ich habe read the README and man pages again, but i cannt locate my 
>> mistake.
>>     
>
> So please try, optionally as user 'jan' or something and first using
> chown -R jan:jan /usr/src/linux. There is also no need to have this
> under /usr/src. You can also have the kernel source files somewhere
> under your home directory.
>
> $ fakeroot make-kpkg clean
> $ make oldconfig
> $ fakeroot make-kpkg --revision jan.1 kernel_image
>
> and it will probably just work.
>   

