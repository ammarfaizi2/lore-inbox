Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWBLLLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWBLLLu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 06:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbWBLLLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 06:11:50 -0500
Received: from smtpout.mac.com ([17.250.248.85]:62404 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750702AbWBLLLu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 06:11:50 -0500
In-Reply-To: <43EEF711.2010409@gmail.com>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602101337.22078.rjw@sisk.pl> <20060210233507.GC1952@elf.ucw.cz> <200602111136.56325.merka@highsphere.net> <B5780C33-81CE-4B8A-9583-B9B3973FCC11@mac.com> <43EEF711.2010409@gmail.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <43833C9D-40A2-42B3-83D9-3C9D3EB7C434@mac.com>
Cc: Jan Merka <merka@highsphere.net>, Pavel Machek <pavel@ucw.cz>,
       suspend2-devel@lists.suspend2.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Flames over -- Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Sun, 12 Feb 2006 06:11:38 -0500
To: Alon Bar-Lev <alon.barlev@gmail.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 12, 2006, at 03:51, Alon Bar-Lev wrote:
> 1. Store state on files

This is not a "feature", it's just something that causes a lot of  
downsides (chew up disk space, fragment files, add code complexity,  
etc).

> this allow you to resume your machine into a different OS.

This is the "feature".  On the other hand, I'm going to argue that  
this isn't really what we want to be doing for complexity reasons.   
We want to implement the container and userspace-freeze code  
described in the virtualization thread, then implement software- 
suspend-and-resume-into-different-OS as freeze-userspace-container,  
shutdown.  Then you could trivially have different sets of working  
data/processes, load up multiple sets at once, selectively freeze,  
etc, with far less kernel complexity.

> 2. Encrypt state - this allow you to be sure that your data is  
> stored encrypted. (Yes... You can encrypt the memory... but then  
> you need a whole initramfs clone in order to allow the user to  
> specify how he want to encrypt/decrypt).

Why the hell would you even _want_ to encrypt data in RAM?  If you  
have a secure OS install and a passworded screensaver that starts  
before suspend, then there is _nothing_ an attacker could do to the  
contents of RAM without hard-booting, which would just completely  
erase it, or without extremely specialized hardware and expertise.   
Picking up a machine suspended to RAM is just as secure as picking up  
one that is on, no more or less.

> 3. Network resume - this allow you to resume a network machine (Not  
> implemented yet, but cannot be done if
> suspend-to-RAM is the sole implementation).
>
> 4. Support desktops/servers - this allow you to  suspend/resume  
> hardware that is not designed to sleep, in  order to minimize  
> downtime on power failure.

This again is covered by the container-freeze stuff being implemented  
as described above, and is unrelated to the suspend-to-RAM.  When I  
want suspend-to-RAM, I want something that will work instantly with  
no overhead, so I can close my laptop and have it asleep 2 seconds  
later, or open it and be able to use it within 2 seconds.  That's an  
extremely different use-case than the above two.

> And another fact: Suspend-to-RAM implementation can be derived form  
> suspend-to-disk but not the other way around.

No, the two are _entirely_ independent.  Suspend-to-RAM does not need  
to copy memory at all, whereas suspend-to-disk requires it.  That  
very fact means that suspend-to-RAM is orders of magnitude faster  
than suspend-to-disk could ever be, especially as RAM gets  
exponentially larger.

> So let's invert the initial "fact"...  Suspend-to-RAM is basically  
> for people that don't need the full  functionality of suspend-to- 
> disk, after I got suspend-to-disk to work reliably here (suspend2),  
> I *NEVER* use suspend-to-RAM.

No, suspend-to-ram is for people who need instant response times,  
suspend-to-disk should be an extension or simplification of "Freeze a  
process tree and all associated system status so we can completely  
give up the hardware for a while".  IMHO, the fact that both are  
called "suspend" is just due to historical quirk as opposed to any  
real similarity.

Cheers,
Kyle Moffett

--
There is no way to make Linux robust with unreliable memory  
subsystems, sorry.  It would be like trying to make a human more  
robust with an unreliable O2 supply. Memory just has to work.
   -- Andi Kleen


