Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261542AbUKIOjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbUKIOjn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 09:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbUKIOjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 09:39:43 -0500
Received: from [213.146.154.40] ([213.146.154.40]:57571 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261542AbUKIOjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 09:39:22 -0500
Subject: Re: [PATCH] Correctly flush 8250 buffers, notify ldisc of line
	status changes.
From: David Woodhouse <dwmw2@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, rmk@arm.linux.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1099998926.15462.21.camel@localhost.localdomain>
References: <1099659997.20469.71.camel@localhost.localdomain>
	 <20041109012212.463009c7.akpm@osdl.org>
	 <1099998437.6081.68.camel@localhost.localdomain>
	 <1099998926.15462.21.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1100011155.4542.139.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Tue, 09 Nov 2004 14:39:15 +0000
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-09 at 11:15 +0000, Alan Cox wrote:
> This is the wrong way to do it. I've been trying this and discarded it.
> The problem is that data arrival is asynchronous to the event which
> means you've not got a clue how to combine the status change and the
> data stream. This in itself makes the whole feature useless.
> 
> Modem changes have to go inline with the data just like break and
> parity.

That's not the problem I'm trying to solve. I'm interested in the
transmission path. I have a shared bus, much like CAN, with automatic
contention detection -- if I transmit a 0 while someone else transmits a
1, the adapter automatically aborts its transmission and asserts CTS for
a while. I need to respond to CTS by immediately stopping my own
transmission -- otherwise when the adapter goes back into the normal
state it'll start transmitting again half way through my original
packet.

-- 
dwmw2

