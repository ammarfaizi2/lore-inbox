Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129104AbRBNUPF>; Wed, 14 Feb 2001 15:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129134AbRBNUOy>; Wed, 14 Feb 2001 15:14:54 -0500
Received: from HSE-Montreal-ppp103309.qc.sympatico.ca ([64.230.176.130]:52743
	"EHLO mx1.lcis.net") by vger.kernel.org with ESMTP
	id <S129104AbRBNUOp>; Wed, 14 Feb 2001 15:14:45 -0500
Date: Wed, 14 Feb 2001 15:14:19 -0500 (EST)
From: "Gord R. Lamb" <glamb@lcis.dyndns.org>
X-X-Sender: <glamb@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
Subject: Samba performance / zero-copy network I/O
Message-ID: <Pine.LNX.4.32.0102141452210.27843-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I'm trying to optimize a box for samba file serving (just contiguous block
I/O for the moment), and I've now got both CPUs maxxed out with system
load.

(For background info, the system is a 2x933 Intel, 1gb system memory,
133mhz FSB, 1gbit 64bit/66mhz FC card, 2x 1gbit 64/66 etherexpress boards
in etherchannel bond, running linux-2.4.1+smptimers+zero-copy+lowlatency)

CPU states typically look something like this:

CPU states:  3.6% user,  94.5% system,  0.0% nice, 1.9% idle

.. with the 3 smbd processes each drawing around 50-75% (according to
top).

When reading the profiler results, the largest consuming kernel (calls?)
are file_read_actor and csum_partial_copy_generic, by a longshot (about
70% and 20% respectively).

Presumably, the csum_partial_copy_generic should be eliminated (or at
least reduced) by David Miller's zerocopy patch, right?  Or am I
misunderstanding this completely? :)

Regards,

- Gord R. Lamb (glamb@lcis.dyndns.org)

