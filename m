Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264980AbUHVBIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264980AbUHVBIm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 21:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264984AbUHVBIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 21:08:42 -0400
Received: from qfep05.superonline.com ([212.252.122.162]:37336 "EHLO
	qfep05.superonline.com") by vger.kernel.org with ESMTP
	id S264980AbUHVBIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 21:08:38 -0400
From: "Josan Kadett" <corporate@superonline.com>
To: "'Chris Siebenmann'" <cks@utcc.utoronto.ca>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Entirely ignoring TCP and UDP checksum in kernel level
Date: Sun, 22 Aug 2004 04:08:39 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <04Aug21.205911edt.41960@gpu.utcc.utoronto.ca>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcSH40GIonQ78bpfQVGhXh32Uqb8rwACIc2g
Message-Id: <S264980AbUHVBIi/20040822010839Z+1297@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well, the device fails only in one type of operation, that is when it has to
receive packets from an internal port, it sends packets via its external IP
address. 

I have managed to disable IP header checksumming by hacking the kernel (in
file ip_input.c). Now I have to do the same for tcp_input.c and udp.c .
Packet mangling will not be required because when I turn the rp_filter off,
the kernel does not care whether it is coming from the intended source or
not.

Now after disabling IP protocol checksumming, I passed to udp checksumming.
However; now the code is more complicated. And for the TCP there is 100K of
code. Well of course, with correct patch it would work, but as far as I can
see, there are many locations that needs to be changed in order to get this
work.

I also thought about packet mangling, but again something needs to be done
for checksums. By the way, it is not necessary to do as such. Perhaps, I
would later need it in case I see such errors in future but my current
problem has a rather easy solution.

I have received many replies about what to change in these codes. However;
none of them were correct at all. Either they disabled some part of
checksumming or cast the TCP/IP totally unavailable.

Any reference to code would be appreciated.
Regards...

-----Original Message-----
From: Chris Siebenmann [mailto:cks@utcc.utoronto.ca] 
Sent: Sunday, August 22, 2004 2:59 AM
To: Josan Kadett
Subject: Re: Entirely ignoring TCP and UDP checksum in kernel level

 At least with TCP, I believe that if TCP is establishing a circuit
between (IP1, port1) and (IP2, port2), SYN+ACKs from (IP3, port2) will
generally be ignored. So it seems likely that you will not only have
to ignore the checksum failure but also mangle the IP packets that you
receive that claim to be from 'IP3' to claim to be from 'IP2' instead,
so that they match up with what the kernel expects.

 (The alternative approach is to mangle on the outgoing path, such
that the Linux box at the high level thinks it's talking to IP3, but
IP3 is replaced by IP2 as each packet goes out.)

 Has this particular chunk of hardware ever successfully talked to
anything via TCP/IP?

[And just to check: you are entirely 100% certain that the IP checksum
 on incoming packets is incorrect?]
---
	"I shall clasp my hands together and bow to the corners of the
world."
			Number Ten Ox, "Bridge of Birds"
cks@utcc.toronto.edu
utgpu!cks



