Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262192AbREQWFe>; Thu, 17 May 2001 18:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262194AbREQWFY>; Thu, 17 May 2001 18:05:24 -0400
Received: from [213.96.224.204] ([213.96.224.204]:50958 "HELO manty.net")
	by vger.kernel.org with SMTP id <S262192AbREQWFN>;
	Thu, 17 May 2001 18:05:13 -0400
Date: Fri, 18 May 2001 00:04:50 +0200
From: Santiago Garcia Mantinan <manty@udc.es>
To: linux-kernel@vger.kernel.org
Cc: Jens David <dg1kjd@afthd.tu-darmstadt.de>
Subject: 8139too on 2.2.19 doesn't close file descriptors
Message-ID: <20010518000450.A3755@man.beta.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I was tracking down a problem with Debian installation freezing when doing
the ifconfig of the 8139too driver on 2.2.19 kernel, and found that this was
caused by 8139too for 2.2.19 not closing it's file descriptors.

The original code by Jeff for the 2.4 series is ok, and searching for the
cause of the problem I have found a difference in the way rtl8139_thread
exits on both versions:

2.2 version:
        up (&tp->thr_exited);
        return 0;

2.4 version:
        up_and_exit (&tp->thr_exited, 0);

I think the problem must be there, not doing the do_exit on the 2.2 version,
but I may be wrong, can anybody look this up?

Thanks in advance!

Regards...
-- 
Manty/BestiaTester -> http://manty.net
