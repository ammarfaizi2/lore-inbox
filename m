Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290355AbSAPEsK>; Tue, 15 Jan 2002 23:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290359AbSAPEsA>; Tue, 15 Jan 2002 23:48:00 -0500
Received: from gear.torque.net ([204.138.244.1]:27410 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S290358AbSAPEr4>;
	Tue, 15 Jan 2002 23:47:56 -0500
Message-ID: <3C4505C4.37EBD193@torque.net>
Date: Tue, 15 Jan 2002 23:47:00 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.3-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: linux 2.5 and ppa.c
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Weber <weber@nyc.rr.com> wrote:

> This is one of those drivers still broken due to 
> the BIO changes (it still calls io_request_lock()).
>
> Unfortunately, I only know enough to
> s/io_request_lock/host->host_lock/g.
> 
> I am afraid this requires a little more than this.

John,
The ppa_detect() must _not_ take the host_lock semaphore
as it is already taken by the mid level before it calls
ppa_detect(). [This will cause a lock up on an SMP
machine.]

The ppa_interrupt() should take the host_lock semaphore
before it calls scsi_done() (which calls up the scsi
driver stack).

The imm driver has been built by the same firm (Tim Waugh?)
and it looks correctly patched.

Doug Gilbert
-
To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
