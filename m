Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265275AbSKYTKh>; Mon, 25 Nov 2002 14:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265351AbSKYTKg>; Mon, 25 Nov 2002 14:10:36 -0500
Received: from h-64-105-35-74.SNVACAID.covad.net ([64.105.35.74]:36993 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265275AbSKYTKf>; Mon, 25 Nov 2002 14:10:35 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 25 Nov 2002 11:16:32 -0800
Message-Id: <200211251916.LAA01830@baldur.yggdrasil.com>
To: rusty@rustcorp.com.au
Subject: Re: Patch?: module-init-tools/modprobe.c - use modules.dep
Cc: dwmw2@infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
>In message <20021121073912.A15349@adam.yggdrasil.com> you [Adam Richter] write:
>> 
>> --xHFwDpU9dbj6ez1V
>> Content-Type: text/plain; charset=us-ascii
>> Content-Disposition: inline
>> 
>> 	The following patch changes modprobe in module-init-tools-0.8
>> to use modules.dep.
>> 
>> 	Benefits:
>> 
>> 	- deletes a net of 594 lines of source code
>> 
>> 	- shrinks modprobe from 14kB to 10kB (stripped, dynamically linked),
>> 	  which is useful for boot images
>> 
>> 	- should make modprobe as fast on systems with a lot of modules as
>> 	  it was with the user level module loader,
>> 
>> 	- Restores the "include" command to the aliases file, which makes
>> 	  it simpler to have separate files for automatically generated
>> 	  aliases and user customizations.
>> 
>> 	- minor: eliminates ELF dependence from modprobe user level code

>Hmm, I like it.  But I prefer to pull the depmod code into the source
>too, to keep it all under one roof.

	I have been thinking about splitting depmod into two programs:
the program as originally designed that generates modules.dep and one
that generates hardware support files.  The latter could be
distributed in the Linux kernel tree and perhaps installed in
/lib/modules/<version>/bin/ to make it easy to change support table
formats as needed.

>The ELF dependence will go back in eventually, but that's trivial.

	I'm guessing this is for symbols.  If it's for something other
reason, I'd be curious to know it.

>Hmm, Adam, do you want to reverse positions and become
>module-init-tools maintainer?  I'll send patches to you, instead of
>vice versa.  I'll release a 0.8 with the patches I have so far, then
>hand it over if you want.

>Thoughts?
>Rusty.

	I'm honored by the offer, but I have not seen any convincing
accounting of real benefits and costs that shows that it is a win to
have the module loader in kernel memory.  I might be interested in
maintaining a small modutils that could be compiled to support either
the in-kernel module load or a user level method (or both) so as to
avoid unnecessary differences between the user level and in-kernel
methods, given that the code that is specific to the kernel module
loader would be small.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
