Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262655AbRFMJQX>; Wed, 13 Jun 2001 05:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262659AbRFMJQM>; Wed, 13 Jun 2001 05:16:12 -0400
Received: from ns.suse.de ([213.95.15.193]:27914 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S262655AbRFMJP5>;
	Wed, 13 Jun 2001 05:15:57 -0400
To: Scott Long <smlong@teleport.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Threads and the LDT (Intel-specific)?
In-Reply-To: <01061011532900.01126@abacus.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 13 Jun 2001 11:15:53 +0200
In-Reply-To: Scott Long's message of "10 Jun 2001 20:59:15 +0200"
Message-ID: <ouplmmwloza.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scott Long <smlong@teleport.com> writes:

> I can also use the LDT to point to thread-specific segments. IMHO this 
> is much better than the stack trick used by linuxthreads. The problem 

Modern LinuxThreads (glibc 2.2) also uses modify_ldt for thread local data
(much to the pain of the IA64 and x86-64 ports who have to emulate it..) 

> is, I don't fully understand how to use modify_ldt(). Is anyone 
> knowledgeable about this?

modify_ldt() works like a memcpy to/from the ldt. See the man page. On the
layout of the LDT see the intel IA32 architecture manual from http://developer.intel.com
 
> If anyone has any other suggestions, please let me know. If you are 
> confused as to why I would ever want to do this in the first place, I'd 
> be willing to go over it off the list.

I can imagine, but it'll cost you. Most modern CPUs have heavy penalties for
non-zero-based or limited segments (a few cycles for every memory access) and LDT
switching also makes the context switch slower.

An portable alternative is to use multiple processes with a shared memory area.

-Andi
