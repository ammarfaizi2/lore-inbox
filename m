Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313255AbSDJPwg>; Wed, 10 Apr 2002 11:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313260AbSDJPwg>; Wed, 10 Apr 2002 11:52:36 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:49937 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S313255AbSDJPwe>; Wed, 10 Apr 2002 11:52:34 -0400
Message-Id: <200204101552.g3AFq5927622@aslan.scsiguy.com>
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.19-pre6 standardize {aic7xxx,aicasm}/Makefile 
In-Reply-To: Your message of "Wed, 10 Apr 2002 12:41:43 +1000."
             <2317.1018406503@kao2.melbourne.sgi.com> 
Date: Wed, 10 Apr 2002 09:52:05 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Sun, 07 Apr 2002 22:27:40 -0600, 
>"Justin T. Gibbs" <gibbs@scsiguy.com> wrote:
>>kaos wrote
>>>Having multiple conglomerates gets messy, especially if you allow a
>>>mixture of built in and modular selection and if it is possible for
>>>everything to be a module with no built in stubs.  The generic case
>>>looks like this
>>
>>Since this is the case, and the Makefile will return to this format
>>as soon as the U320 driver is released, can we come up with an
>>interrim Makefile that assumes the new driver will show up shortly?
>
>I renew my standing offer that goes back to June 2001.  If you agree to
>
>* use the standard Linux kernel build methods

This is already true of the aic7xxx/Makefile for 2.4 since it will
have a second target shortly.  I even spent yesturday changing the
file from AIC7XXX-OBJ to obj-aic7xxx to better follow your example.
In the next release, scsi/Makefile will also include aic7xxx.o instead
of aic7xxx_drv.o as you requested.

I have not looked at 2.5.

>* stop shipping files and overwriting them at run time
>* make the decision about firmware generation automatic instead of
>  manual

Not this again.

>From my own soapbox on this matter:

SHIPPING GENERATED FILES

In general, it is bad practice to even attempt to ship generated files
in the Linux kernel build with the source of the utilities to build those
files as in Linux you can't know what miss-match of tools the user is going
to have.  If you're lucky, they have a compiler with bugs that won't affect
you, but since there is no "standard toolset" that userland distributions
include, you cannot rely on even the tools that are necessary to rebuild the
compiler: lex and yacc.  Even if the tools to build the tools to generate
your files exist in all cases (toungue twister), triggering the tool build
from within the kernel build can be "interesting" as you try and dissassociate
the tool make environment from the kernel build environment which may make
assumptions that don't apply to your tool.

The whole reliance on using patches as a general purpose upgrade tool
in Linux is left for another discussion.  My only hope is that with the
move to using bitkeeper, this reliance will fade.

So, we are left with three options:

1) Don't bother shipping the code to regenerate the file.
2) Make it manually selectable for the .00000001% of users that
   might want or need to modify the generated files.
3) Make the makefiles rely on sed, md5, and cmp in addition to
   gmake and sh, an additional generated file and a script to automate
   a process that really doesn't benefit from being automated.

Option #3 is simply complicated and overengineered.

The mechanism we have in place today works.  Other than one mixup in
May or June of 2001, during the early adoption of this driver, it has
always worked.

The old driver included the firmware source but no tools to rebuild it.
I will happily do the same if this is more aesthetically pleasing.
Considering that this is an open source project, it just seems silly to
me to not ship the tools too as there is already a simple mechanism to
allow their use in place already.

>* remove the BSD'isms from the Linux aic7xxx Makefiles

Are you talking about aic7xxx/aicasm/Makefile?  That makefile
does not use kbuild mecanisms becaues it is building a userland
application.  The aic7xxx/Makefile (at least for 2.4 - again haven't
even looked at 2.5) seems to follow your own suggestions assuming
there will be two targets.

>then I will happily write clean aic7xxx makefiles and support them.
>But if you insist on doing it your own way that does not match the
>Linux kernel build, then I am afraid that you are on your own.

Then why bother sending a patch to Marcello?

--
Justin
