Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbVAXWg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbVAXWg0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 17:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261701AbVAXWfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 17:35:18 -0500
Received: from mta02.pge.com ([131.89.129.72]:50131 "EHLO mta02.pge.com")
	by vger.kernel.org with ESMTP id S261668AbVAXWcm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 17:32:42 -0500
Date: Mon, 24 Jan 2005 14:24:49 -0800
From: Edward Peschko <esp5@pge.com>
To: gcc@gcc.gnu.org, libc-alpha@sources.redhat.com,
       binutils@sources.redhat.com, linux-kernel@vger.kernel.org
Subject: forestalling GNU incompatibility - proposal for binary relative dynamic linking
Message-ID: <20050124222449.GB16078@venus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hey all,

Forgive the crosspost in advance, but I had an idea that touched many 
areas, and would need input from multiple groups associated with the 
gnu build chain, and perhaps the kernel itself.

After spending *two weeks* on various ways of building glibc, 
I'm convinced that the gnu/linux toolchain is in great danger of 
losing interoperability.

The main problem is that the glibc's supplied with each commercial 
system are *heavily* patched. My Suse 9.2 system has a rpm for 
glibc with fifty patches.  Fifty patches! 

Fifty patches which make the SuSE glibc binarily incompatible 
with the redhat, and so on.  And everything is incompatible
with the vanilla flavor.

All this makes me very skeptical that I'm ever going to get 
to a 'standard' out of the box glibc build. I build a standard 
glibc, and then all the supplied programs that come with SuSE 
break. And each vendor has the same problem - new that they are 
stuck with a heavily patched glibc, what chance do *they* have 
of getting back to a standard with the need to have old programs 
still work with the upgrades?









What IMO is desperately needed is a backwards compatibility 
hack or hacks. And of course the will of the different linux 
distribution providers to migrate back to the standard gnu 
toolchain.

Below is such a hack that lets providers do this, and 
solves quite a few problems in the process - the basic problem 
being that one currently can't get from a nonstandard glibc to
a standard one without quite a bit of pain - for migrating back 
breaks all the legacy binaries out there.


What is needed is the ability to reference multiple versions of the 
glibc WITHOUT changing my environment to do so.


Ie: If I set up my LD_LIBRARY_PATH to reference:

	setenv LD_LIBRARY_PATH /system/path/to/libc:.....


then the SuSE executables work fine but my new executables break, 
and if I set up my LD_LIBRARY_PATH to reference:

	setenv LD_LIBRARY_PATH /new/path/to/libc:.....

then my new executables work, but my *old* executables break.


What I'd like to do is be able to set up my LD_LIBRARY_PATH 
so that I can reference it from the point of view of the 
*executable*:

	setenv LD_LIBRARY_PATH   "*/../lib:....."




Here, read "* == full path of dirname of executable".

So if gcc was installed in say, "/opt/tools/bin/gcc", 
LD_LIBRARY_PATH would become at runtime "/opt/tools/bin/../lib" 
or "/opt/tools/lib". And hence if I had a libc.so installed 
there, it would pick it up and use it. 



Anyways, I have no idea whether or not this idea is being considered
or has been considered in the past, but AFAICT it would save me the 
trouble of having hundreds of wrapper scripts. And I would like to 
get an idea of what adding something like this to the gnu toolset would 
require. Discussion is welcome..


Ed
