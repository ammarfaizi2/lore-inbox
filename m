Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262042AbVCTHlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbVCTHlJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 02:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbVCTHlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 02:41:09 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:2568 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262042AbVCTHlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 02:41:06 -0500
Date: Sun, 20 Mar 2005 08:41:00 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Ioan Ionita <opslynx@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unreliable TCP?
Message-ID: <20050320074100.GH30052@alpha.home.local>
References: <df47b87a050319185918be6c19@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df47b87a050319185918be6c19@mail.gmail.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 19, 2005 at 09:59:16PM -0500, Ioan Ionita wrote:
> Hello.  I apologize if this may sound stupid/unknowledgeable.  I'm
> currently fooling around with real time voice conferencing
> applications which use the UDP protocol.  However, certain firewalls
> don't allow UDP traffic, therefore I tried UDP over TCP as a
> workaround.

I don't agree with this reason. One more valid reason could have been the
non-connected aspect of UDP which is not easy to manage through all
firewalls (timeouts, etc...). But all firewalls support UDP (eg: DNS).
If the firewall you're trying to bypass supports DNS, then encapsulate
your voice in DNS requests/responses, and when the admin complains, then
ask him to open another port.

>  This failed miserably, as the ACK aspect of TCP, which
> delays everything when a packet is lost or received out of order makes
> voice conferencing anything but real time.  So I was wondering if
> there's any way to disable the whole reliability checking of TCP in
> the linux kernel. Maybe configure the kernel to never request the
> retransmission of a packet, even if it detects packet loss/bad order?

If you disable retransmission, then some firewalls will sometimes block
because some packets will be out of window. And not only data are sent
in TCP, but control bits (SYN, FIN, RST) must not be lost. Some TCP
options such as window scaling will have a terrible impact if they are
lost and not retransmitted.

At most, you should lower the retransmit timeout. The 3s initial timeout
is far too high with todays local networks, and prevent real-time
applications from using TCP. However, if you use something like a few
tens or hundreds ms (depending on the RTT), you might get your voice
working on TCP.

Willy

