Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129562AbRAIEeR>; Mon, 8 Jan 2001 23:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129771AbRAIEeI>; Mon, 8 Jan 2001 23:34:08 -0500
Received: from mlx3.unm.edu ([129.24.8.189]:23828 "HELO mlx3.unm.edu")
	by vger.kernel.org with SMTP id <S129562AbRAIEd6>;
	Mon, 8 Jan 2001 23:33:58 -0500
Date: Mon, 8 Jan 2001 21:33:56 -0700 (MST)
From: Todd <todd@unm.edu>
To: <linux-kernel@vger.kernel.org>
Subject: UDP performance drop from -test9 to 2.4.0 (fwd)
Message-ID: <Pine.A41.4.31.0101082132160.15112-100000@aix07.unm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.A41.4.31.0101082132162.15112@aix07.unm.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sorry for the resend. i sent this earlier today but still haven't seen it,
so i'm resending without attachments.

the originally attached netperf results are at:

http://www.unm.edu/~todd/udp.2.4.0-test9.9000mtu
http://www.unm.edu/~todd/udp.2.4.0-test9.1500mtu
http://www.unm.edu/~todd/udp.2.4.0.9000mtu
http://www.unm.edu/~todd/udp.2.4.0.1500mtu

---------- Forwarded message ----------
Date: Mon, 8 Jan 2001 09:38:24 -0700 (MST)
From: Todd <todd@unm.edu>
To: linux-kernel@vger.kernel.org
Subject: UDP performance drop from -test9 to 2.4.0

folx,

i'm seeing a signficant performance decline between the -test9 and the
release version 2.4.0 on udp on acenic gig-e cards.  i should say that
the performance is startlingly better than it was under 2.2.14 (where the
best we could get was 150+ Mbps on udp) but it still represents a
signficant decline.

i'm attaching netperf numbers with 1500 and 9000 byte mtus for both kernel
versions (with interrupt coalescing and everything else as default--this
is just a compile/boot/test scenario with no tuning in particular).
standard kernel, standard /proc settings, standard acenic firmware and
driver that shipped with the version in question.

the summary of results:  12% reduction in performance at 1500-byte mtu, 6%
reduction at 9000.  when looking at the results remember that the second
line in each case is the 'receive bandwith' line, which is the only useful
number to report.

kernel version		max udp bandwith	mtu	message size
==============		================	===	============
2.4.0-test9		554.9			1500	1470
2.4.0-test9		636.7			9000	8870
2.4.0			489.4			1500	1470
2.4.0			597.3			9000	7270

both versions show the horrible effect that the reassembly of fragments
has on receive bandwith, but that's not really my question for the day
:-).

any info would be helpful.  i'd be happy to run any further tests to get
at the bottom of this.

todd

=========================================================
	Todd Underwood, todd@unm.edu
=========================================================


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
