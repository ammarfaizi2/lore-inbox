Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129870AbQK1VEX>; Tue, 28 Nov 2000 16:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130245AbQK1VEN>; Tue, 28 Nov 2000 16:04:13 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:47622 "HELO mail.ocs.com.au")
        by vger.kernel.org with SMTP id <S129801AbQK1VEB>;
        Tue, 28 Nov 2000 16:04:01 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Kurt Garloff <garloff@suse.de>
cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: modutils-2.3.21: modprobe looping 
In-Reply-To: Your message of "Tue, 28 Nov 2000 20:22:59 BST."
             <20001128202259.E27219@garloff.etpnet.phys.tue.nl> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 29 Nov 2000 07:33:53 +1100
Message-ID: <3301.975443633@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2000 20:22:59 +0100, 
Kurt Garloff <garloff@suse.de> wrote:
>Find attached the modules.dep that caused this: There is a circular
>dependency of pppoe on pppox on pppoe on ....

The kernel code is broken.  Circular dependencies make no sense, the
pppoe maintainer agrees and I thought that bug was fixed.

>modprobe has code to detect this in build_stack(), but it seems to not work.
>The old dep is thrown away and the new one is taken. And checked for
>dependencies again :-(
>Of course, one could also think of depmod making sure that such circular
>dependencies do not occur, but I guess, it's more robust if depmod has a
>working test in any case.

Circular dependencies are not supported, nor are they correrctly
detected.  The existing code to walk the inter module relationships,
including dependencies, alias, probe, probeall, before and after
statements is a mess.  It just grew over the years with special cases
being added and is not robust.

In modutils 2.5 the entire code will be discarded and replaced with a
standard graph walking algorithm with loop detection and back tracking
instead of special case code.  That might change some modutils
behaviour in rare cases and I do not want to change its behaviour just
before kernel 2.4 is released.  I have a list of changes that might
break backwards compatibility waiting for modutils 2.5, this is just
one of them.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
