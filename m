Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130209AbRCGFUY>; Wed, 7 Mar 2001 00:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130225AbRCGFUO>; Wed, 7 Mar 2001 00:20:14 -0500
Received: from servo.isi.edu ([128.9.160.111]:18695 "EHLO servo.isi.edu")
	by vger.kernel.org with ESMTP id <S130209AbRCGFUK>;
	Wed, 7 Mar 2001 00:20:10 -0500
Message-Id: <200103070519.f275JSw05855@servo.isi.edu>
To: linux-kernel@vger.kernel.org
cc: jelson@circlemud.org
Subject: Mapping a piece of one process' addrspace to another?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5852.983942368.1@servo.isi.edu>
Date: Tue, 06 Mar 2001 21:19:28 -0800
From: Jeremy Elson <jelson@circlemud.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Is there some way to map a piece of process X's address space into
process Y, without X's knowledge or cooperation?  (The non-cooperating
nature of process X is why I can't use plain old shared memory.)

Put another way, I need to grant Process Y permission to write into a
private buffer owned by process X.  X doesn't know this is happening,
and I don't know where X's buffer even lives (X's stack, heap, etc.).
X just passes a pointer to the kernel via a system call (e.g., like
sys_read).

In the system I currently have implemented, Y writes a buffer to the
kernel, and the kernel relays it to X on behalf of Y.  But, for
performance reasons, I want to try to get Y to write its data directly
to X instead.  X might be any process calling read() (e.g., "cat"),
but Y is in collusion with the kernel.

If this is possible at all, is it also possible on a granularity down
to one byte (as opposed to an entire page)?

Sorry if this seems like a strange thing to do - but, I hope to
document and release my code soon, in which case its purpose should be
clearer :-).

Regards,
Jeremy
