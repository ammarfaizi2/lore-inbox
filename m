Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266514AbSKUK20>; Thu, 21 Nov 2002 05:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266520AbSKUK20>; Thu, 21 Nov 2002 05:28:26 -0500
Received: from robur.slu.se ([130.238.98.12]:22532 "EHLO robur.slu.se")
	by vger.kernel.org with ESMTP id <S266514AbSKUK2Z>;
	Thu, 21 Nov 2002 05:28:25 -0500
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15836.47295.808423.41648@robur.slu.se>
Date: Thu, 21 Nov 2002 11:43:11 +0100
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: Robert Olsson <Robert.Olsson@data.slu.se>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: e1000 fixes (NAPI)
In-Reply-To: <20021120164319.A26918@vger.timpanogas.org>
References: <15835.56316.564937.169193@robur.slu.se>
	<20021120164319.A26918@vger.timpanogas.org>
X-Mailer: VM 6.92 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff V. Merkey writes:
 > 
 > Need another fix.  You need to reinstrument the tasklet schedule in the 
 > fill_rx_ring instread of doing the whole thing from interrupt.  When the 
 > system is loaded at 100% saturation on gigbit with 300 byte packets or 
 > smaller, the driver does not allow any processes to run, and you cannot 
 > log in via ssh or any user space apps.  This is severely busted.   
 > 
 > The later versions of the driver > 4.3.15 all exhibit this behavior and 
 > are extremely broken.

 Where have you been? :-)

 NAPI does RX processing in softirq. RX interrupts are just used to indicate 
 work. At high loads the consecutive RX polls gets run via ksoftirqd which
 is under scheduler control also the RX softirq breakes for other work. This 
 makes the NAPI network stuff as very well behaved kernel citizen and also 
 gives network performance at any load.

 More details is in the usenix paper;
 http://www.cyberus.ca/~hadi/usenix-paper.tgz

 Cheers.
						--ro

