Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129282AbRDTUUj>; Fri, 20 Apr 2001 16:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130317AbRDTUU3>; Fri, 20 Apr 2001 16:20:29 -0400
Received: from goat.cs.wisc.edu ([128.105.166.42]:42761 "EHLO goat.cs.wisc.edu")
	by vger.kernel.org with ESMTP id <S129282AbRDTUUO>;
	Fri, 20 Apr 2001 16:20:14 -0400
To: root@chaos.analogic.com
Cc: Ulrich Drepper <drepper@cygnus.com>, linux-kernel@vger.kernel.org,
        pcroth@cs.wisc.edu, epaulson@cs.wisc.edu
Subject: Re: BUG: Global FPU corruption in 2.2
In-Reply-To: <Pine.LNX.3.95.1010420153006.12968A-100000@chaos.analogic.com>
From: Victor Zandy <zandy@cs.wisc.edu>
Date: 20 Apr 2001 15:20:05 -0500
In-Reply-To: "Richard B. Johnson"'s message of "Fri, 20 Apr 2001 15:37:07 -0400 (EDT)"
Message-ID: <cpxwv8fxr0q.fsf@goat.cs.wisc.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It looks to me like the kernel sets a trap for FP operations when a
process is switched in.  Then when the process executes an FP op, the
kernel clears the trap and either loads the FP context or initializes
it, depending on whether it is the process' first FP operation.  So no
help is need from anything in user space.

Vic

"Richard B. Johnson" <root@chaos.analogic.com> writes:
> On 20 Apr 2001, Ulrich Drepper wrote:
> 
> > "Richard B. Johnson" <root@chaos.analogic.com> writes:
> > 
> > > If it "fixes" it, there is no problem with the FPU, but with the
> > > 'C' runtime library which doesn't initialize the FPU to a known
> > > state before it uses it.
> > 
> > It's the kernel which initializes the FPU.  This was always the case
> > and necessary to implement the fast lazy FPU saving/restoring.
> > Processes which never use the FPU never initialize it.
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> The kernel doesn't know if a process is going to use the FPU when
> a new process is created. Only the user's code, i.e., the 'C' runtime
> library knows. If the user is using 'asm' or whatever, the user must

