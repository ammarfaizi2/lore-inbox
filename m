Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265066AbSK1BuF>; Wed, 27 Nov 2002 20:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265074AbSK1BuF>; Wed, 27 Nov 2002 20:50:05 -0500
Received: from h-64-105-35-74.SNVACAID.covad.net ([64.105.35.74]:63626 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S265066AbSK1BuE>; Wed, 27 Nov 2002 20:50:04 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 27 Nov 2002 17:54:36 -0800
Message-Id: <200211280154.RAA07955@baldur.yggdrasil.com>
To: kaos@ocs.com.au
Subject: Re: Modules with list
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-11-27 22:42:46 GMT, Keith Owens wrote:
>On Wed, 27 Nov 2002 10:19:02 -0800, 
>"Adam J. Richter" <adam@yggdrasil.com> wrote:
>>       Hmm.  We could certainly have a binary editing tool to remove
>>what was the .exit{,func} sections after the link...
>>       In this scenario, the .exit{,func} section would be linked
>>in and then discarded by the module loader, by the process of the
>>kernel releasing its .init{,data} areas, or, if you wanted to build
>>a bzImage without CONFIG_HOTPLUG, by using a binary editing tool or
>>perhaps an ld script as I mentioned earlier in this response.
>>
>>       The point of the .devexit_p_refs section would just be to
>>set those references to NULL if that was useful.  The kernel module
>>load code would do something like:
>
>You have it back to front.  The real problem is open code that calls
>functions in sections that have been discarded, that code is an oops
>just waiting to happen.  When binutils was changed to detect such
>dangling references, it found a lot of bad code on rarely tested error
>paths.  Your method would stop binutils finding the dangling references
>and open the kernel up to bad code again.

	Currently, for __devexit{,func}, this is only detected on
CONFIG_HOTPLUG=n systems.  Under my scheme we would always build
.devexit.{text,data} sections, so we could actually test this more
widely, although it would require making a binary tool to delete the
relocations at addresses pointed to by the .devexit_p_ptrs entries.
We could have a regession test that would run that tool on every
module, then run an ld script to delete .devexit.{data,text} and see
if there are any dangling references.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
