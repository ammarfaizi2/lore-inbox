Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261700AbTCHAxf>; Fri, 7 Mar 2003 19:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261655AbTCHAwn>; Fri, 7 Mar 2003 19:52:43 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:29335 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S261576AbTCHAvx>;
	Fri, 7 Mar 2003 19:51:53 -0500
Date: Sat, 8 Mar 2003 02:02:23 +0100 (MET)
From: Mikael Pettersson <mikpe@user.it.uu.se>
Message-Id: <200303080102.h2812N2O022971@harpo.it.uu.se>
To: albert@users.sourceforge.net
Subject: Re: [Perfctr-devel] perfctr and Linus' tree?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07 Mar 2003 15:14:15 -0500, Albert Cahalan wrote:
>Mikael Pettersson writes:
>
>> I'm planning to simplify the kernel <--> user-space
>> interface in perfctr-2.6 (drop /proc/pid/perfctr and
>> go back to /dev/perfctr), and then I _think_ I can
>> do a version that doesn't require patching kernel
>> source. (It will do binary code patching at module
>> load-time instead. Horrible as that sounds, it's
>> easier to deal with for users.)
>
>That would make porting more difficult. I don't think
>these changes will help you gain acceptance.

I don't like patching kernel object code at all. But the #1
usability problem I'm facing is that to use the stuff, people
_must_ patch and rebuild their kernels, due to the callbacks
from switch_to and a few other places, and the task_struct
layout change. That scares away some people, and some try it
but get it wrong with confusing (and hard to debug) results.

(Besides, patching and recompiling the kernel doesn't always work.
There are examples of binary-only HW vendor modules that are
specific to certain versions of certain vendors' binary kernels.)

Naturally, the normal procedure of rebuilding the kernel from
patched sources would remain as the default. The object code
patching approach (which is what I'd use for a plug-and-play
binary .rpm for example) would basically use System.map and a
glue module to do the patching (installing callbacks), and then
the stock driver module would be inserted as usual.

With Linus ignoring the patch, the driver needing callbacks from
process scheduling/fork/exit/execve points, and users having
problems with kernel recompiles, what do you expect me to do?

/Mikael
