Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310289AbSCPMAB>; Sat, 16 Mar 2002 07:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310288AbSCPL7v>; Sat, 16 Mar 2002 06:59:51 -0500
Received: from mail.bstc.net ([63.90.24.2]:17 "HELO mail.bstc.net")
	by vger.kernel.org with SMTP id <S310289AbSCPL7h>;
	Sat, 16 Mar 2002 06:59:37 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15507.12988.581489.554212@argo.ozlabs.ibm.com>
Date: Sat, 16 Mar 2002 22:55:40 +1100 (EST)
To: torvalds@transmeta.com (Linus Torvalds)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
In-Reply-To: <a6te11$si7$1@penguin.transmeta.com>
In-Reply-To: <20020313085217.GA11658@krispykreme>
	<20020314112725.GA2008@krispykreme>
	<87wuwfxp25.fsf@fadata.bg>
	<E16la2m-0000SX-00@starship>
	<a6te11$si7$1@penguin.transmeta.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> But more importantly than that, the whole point really is that the page
> table tree as far as Linux is concerned is nothing but an _abstraction_
> of the VM mapping hardware. It so happens that a tree format is the only
> sane format to keep full VM information that works well with real loads.

Is that still true when we get to wanting to support a full 64-bit
address space?  Given that we can already tolerate losing PTEs for
resident pages from the page tables quite happily (since they can be
reconstructed from the information in the vm_area_structs and the page
cache), I don't see that the fact that a hash table will sometimes
lose PTEs because of a hash bucket filling up is all that much of a
problem.  (We would need to find some other way of dealing with swap
entries of course.)

IMHO it would be interesting to compare the size and complexity of
using a hash table for the page tables with a 5-level tree.  For a
32-bit address space I think the tree wins hands down but for a full
64-bit address space I am not convinced either way at present.

Paul.
