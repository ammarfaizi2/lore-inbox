Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135313AbREHUXh>; Tue, 8 May 2001 16:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135314AbREHUX1>; Tue, 8 May 2001 16:23:27 -0400
Received: from mail2.megatrends.com ([155.229.80.11]:52745 "EHLO
	mail2.megatrends.com") by vger.kernel.org with ESMTP
	id <S135313AbREHUXJ>; Tue, 8 May 2001 16:23:09 -0400
Message-ID: <1355693A51C0D211B55A00105ACCFE6402B9DEE0@ATL_MS1>
From: Venkatesh Ramamurthy <Venkateshr@ami.com>
To: "'Pete Wyckoff'" <pw@osc.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ken Nicholson <knicholson@corp.iready.com>,
        Venkatesh Ramamurthy <Venkateshr@ami.com>,
        pollard@tomcat.admin.navo.hpc.mil, linux-kernel@vger.kernel.org
Subject: RE: [RFC] Direct Sockets Support??
Date: Tue, 8 May 2001 16:18:01 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	> But in the case of an application which fits in main memory, and
	> has been running for a while (so all pages are present and
	> dirty), all you'd really have to do is verify the page tables are
	> in the proper state and skip the TLB flush, right?

	We really cannot assume this. There are two cases 
		a. when a user app wants to receive some data, it allocates
memory(using malloc) and waits for the hw to do zero-copy read. The kernel
does not allocate physical page frames for the entire memory region
allocated. We need to lock the memory (and locking is expensive due to
costly TLB flushes) to do this

		b. when a user app wants to send data, he fills the buffer
and waits for the hw to transmit data, but under heavy physical memory
pressure, the swapper might swap the pages we want to transmit. So we need
to lock the memory to be 100% sure.



