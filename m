Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129552AbQLACBQ>; Thu, 30 Nov 2000 21:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130775AbQLACBG>; Thu, 30 Nov 2000 21:01:06 -0500
Received: from duck.doc.ic.ac.uk ([146.169.1.46]:49423 "EHLO duck.doc.ic.ac.uk")
	by vger.kernel.org with ESMTP id <S129552AbQLACA7>;
	Thu, 30 Nov 2000 21:00:59 -0500
To: linux-kernel@vger.kernel.org
Subject: x86 local timer interrupts getting lost
From: David Wragg <dpw@doc.ic.ac.uk>
Date: 01 Dec 2000 01:30:31 +0000
Message-ID: <y7r8zq12aiw.fsf@sytry.doc.ic.ac.uk>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've noticed that on dual processor machines, the two values in the
LOC: line of /proc/interrupts are not in lockstep -- the difference
between them varies.  Using a perl script (below) to print out the
difference every second, I see it wander around (by much more than the
+/-1 error that /proc/interrupts involves).  Sometimes the difference
will jump, usually when the machine is under heavier interrupt load.
I've seen jumps of more than 10, up and down on the same machine.

The machines I've been testing this on are a dual PPro and a dual
Celeron, both running 2.4.0-test11.

Looking at the APIC documentation, it seems unlikely that the
frequency of the local timer interrupts could be wandering differently
on the two processors, so I suspect that the interrupts are actually
getting lost.  Does anyone know how this could be happening?


The perl script:

perl -e 'while(1) { open(IN, "</proc/interrupts") ; while (<IN>) { next unless /LOC:/; ($a, $b, $c) = split; } close(IN); print (($b - $c) . "\n"); sleep(1); }'



David Wragg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
