Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266459AbRGLR7K>; Thu, 12 Jul 2001 13:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266479AbRGLR7A>; Thu, 12 Jul 2001 13:59:00 -0400
Received: from cs.columbia.edu ([128.59.16.20]:21960 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S266459AbRGLR6v>;
	Thu, 12 Jul 2001 13:58:51 -0400
Message-Id: <200107121758.NAA06629@razor.cs.columbia.edu>
X-Mailer: exmh version 2.1.1 10/15/1999
To: kaih@khms.westfalen.de (Kai Henningsen)
cc: linux-kernel@vger.kernel.org
Subject: Re: Switching Kernels without Rebooting? 
In-Reply-To: Your message of "12 Jul 2001 09:23:00 +0200."
             <84jaVrwXw-B@khms.westfalen.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 12 Jul 2001 13:58:52 -0400
From: Hua Zhong <huaz@cs.columbia.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-> kaih@khms.westfalen.de (Kai Henningsen)  wrote:
> riel@conectiva.com.br (Rik van Riel)  wrote on 11.07.01 in <Pine.LNX.4.33L.0107111913010.9899-100000@imladris.rielhome.conectiva>: 
> I suspect to do this right would need a means of storing per-process state  
> controlled by the process (because only that process knows what needs to  
> be saved, and what can easily be reconstructed - for example, open file  
> descriptors to a place where we store cookies don't need to be saved, just  
> routinely reopened), and then every user-visible non-transient program  
> needs to implement it - and I don't see *that* happen in the next ten  
> years.

This would be the easiest way to do in the sense that application authors take care of their own stuff, and kernel developpers only need to define rules/interfaces.

One scheme is that we can define a new signal number (e.g., SIGCKPT).  When we send the signal to the process, it checkpoints itself (saves everything it needs for a restart).  Then we define another signal (e.e., SIGRSUM).  When we send the signal to it, it then knows that it should resume from the last checkpointed point.  This is user-level checkpoint/restart, and there are already certain packages available (Condor, libckpt, etc).

If we want total transparency (i.e., applications don't need to be aware and everything is taken care of by the kernel), then the kernel needs substantial changes (I've written a kernel module to do this).

