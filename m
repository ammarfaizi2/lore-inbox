Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131927AbRAKNPL>; Thu, 11 Jan 2001 08:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130339AbRAKNPB>; Thu, 11 Jan 2001 08:15:01 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:56330 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130006AbRAKNOx>;
	Thu, 11 Jan 2001 08:14:53 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: dwmw2@infradead.org (David Woodhouse),
        linux-kernel@vger.kernel.org (List Linux-Kernel)
Subject: Re: Where did vm_operations_struct->unmap in 2.4.0 go? 
In-Reply-To: Your message of "Thu, 11 Jan 2001 13:09:13 -0000."
             <E14GhTf-0002CS-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 12 Jan 2001 00:14:44 +1100
Message-ID: <17544.979218884@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jan 2001 13:09:13 +0000 (GMT), 
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> Stick to one method that works for all routines, dynamic registration.
>> If that imposes the occasional need for a couple of extra calls in some
>> routines and for people to think about initialisation order right from
>> the start then so be it, it is a small price to pay for long term
>> stability and ease of maintenance.
>
>What happens when we get a loop in init order because of binding and other init
>order conflicts?

The kernel does not support circular dependencies between providers and
consumers.  It does not matter whether they are built into vmlinux or
loaded as modules, there can be no loops in the directed graph of
dependencies.  It just does not make sense.

A while ago there was accidentally a loop between two ppp related
modules, each needed a routine in the other module.  modprobe would not
load them.  Even if it could have loaded them, it would have been
impossible to unload, both modules would have had a use count on the
other.  The fix was to remove the incorrect loop, it was a programming
error.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
