Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281719AbRLQRt0>; Mon, 17 Dec 2001 12:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281739AbRLQRtQ>; Mon, 17 Dec 2001 12:49:16 -0500
Received: from dnai-216-15-110-218.cust.dnai.com ([216.15.110.218]:14556 "EHLO
	mail.3pardata.com") by vger.kernel.org with ESMTP
	id <S281719AbRLQRtA>; Mon, 17 Dec 2001 12:49:00 -0500
Date: Mon, 17 Dec 2001 09:48:53 -0800 (PST)
From: Castor Fu <castor@3pardata.com>
X-X-Sender: <castor@marais>
To: <linux-kernel@vger.kernel.org>
Subject: i386 machine_restart unsafe in interrupt context
Message-ID: <Pine.LNX.4.33.0112170935520.1623-100000@marais>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a problem where systems fail to reboot on panic().  I've resolved
it by changing smp_send_stop() to use an NMI (like the KDB patch does to
manage communication).

The source of the problem is that the panic path has the following:

    panic()
        machine_restart()
            machine_real_restart()
                smp_send_stop()
                    smp_call_function()

and smp_call_function() is not safe in an interrupt context.

I imagine people might want to handle this differently, but I'd be
happy to diffs if there's interest.  It may be that there are enough
cases like this that smp_call_function might want a version that
uses an NMI. . .

    -Castor Fu
    castor@3par.com

