Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136380AbREDNkv>; Fri, 4 May 2001 09:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136388AbREDNkm>; Fri, 4 May 2001 09:40:42 -0400
Received: from [64.64.109.142] ([64.64.109.142]:14090 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S136380AbREDNkW>; Fri, 4 May 2001 09:40:22 -0400
Message-ID: <3AF2B0EC.F576090F@didntduck.org>
Date: Fri, 04 May 2001 09:38:52 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Schwab <schwab@suse.de>
CC: Keith Owens <kaos@ocs.com.au>, Todd Inglett <tinglett@vnet.ibm.com>,
        Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: SMP races in proc with thread_struct
In-Reply-To: <8541.988980403@ocs3.ocs-net> <jer8y52r92.fsf@hawking.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab wrote:
> 
> Keith Owens <kaos@ocs.com.au> writes:
> 
> |> On Fri, 04 May 2001 07:34:20 -0500,
> |> Todd Inglett <tinglett@vnet.ibm.com> wrote:
> |> >But this is where hell breaks loose.  Every process has a valid parent
> |> >-- unless it is dead and nobody cares.  Process N has already exited and
> |> >released from the tasklist while its parent was still alive.  There was
> |> >no reason to reparent it.  It just got released.  So N's task_struct has
> |> >a dangling ptr to its parent.  Nobody is holding the parent task_struct,
> |> >either.  When the parent died memory for its task_struct was released.
> |> >This is ungood.
> |>
> |> Wrap the reference to the parent task structure with exception table
> |> recovery code, like copy_from_user().
> 
> Exception tables only protect accesses to user virtual memory.  Kernel
> memory references must always be valid in the first place.
> 
> Andreas.

The virtual address being accessed is irrelevant.  It's the address of
the faulting instruction that determines what the kernel will do if it
can't deal with a page fault.  If the access was made from kernel mode
the exception handler (if there is one) always gets invoked, otherwise
it oopses.

--

				Brian Gerst
