Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262097AbUKPXYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262097AbUKPXYP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 18:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbUKPXWC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 18:22:02 -0500
Received: from mx1.uidaho.edu ([129.101.155.248]:33158 "EHLO mx1.uidaho.edu")
	by vger.kernel.org with ESMTP id S261910AbUKPXUt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 18:20:49 -0500
Date: Tue, 16 Nov 2004 15:20:42 -0800 (PST)
From: Thomas DuBuisson <dubu0874@uidaho.edu>
Subject: XFRM / DF Flag / Fragmentation Needed
X-X-Sender: dubu0874@hurricane.csrv.uidaho.edu
To: linux-kernel@vger.kernel.org
Message-id: <Pine.GSO.4.56.0411161447340.7679@hurricane.csrv.uidaho.edu>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
X-SpamDetails: rule=notspam policy= score=0 mlx=0 adultscore=0 adjust=0 engine=2.5.0-04111100 definitions=2.5.0-04111100
X-SpamScore: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know this sounds like the same Black Hole topic you have heard before
but I couldn't find a case like mine online so please hear me out.

I am having a problem when I am tunneling packets (in this case
large scp packets) through an IPsec tunnel and I am getting ICMP
'Fragmentation Needed' after this point in time the application (cvs
update) stalls.  The setup is effectively A<--2 ipsec tunnels-->B<-->C
After A establishes an SSH connection with C and tries to transfer the
patches the size of a packet from A destined for C is quickly reaches 1500
while the MTU
to A is ~1400.  At this point A sends an ICMP 'Fragmentation Needed'
packet to its self (see xfrm_output.c xfrm4_tunnel_check_size(...)).  It
seems this packet is never acted on - it just disappears into the
loopback interface.  The proper mtu trial/error process never takes
place.

Hasily formed theory:
Could xfrm, seeing an IP(actually, esp) packet, expects the app to handle
it(returning EMSGSIZE) while SSH, using TCP, expects the kernel to handle
it?

If not, can something throw me a suggestion or a link?

Please CC me as I am not on this list.

Thanks for any replies, if you want any more information feel free to ask.
Tom
