Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbUCBUEs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 15:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261758AbUCBUEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 15:04:48 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:2090 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261760AbUCBUEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 15:04:45 -0500
To: root@chaos.analogic.com
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: poll() in 2.6 and beyond
References: <Pine.LNX.4.53.0403021318580.796@chaos>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 02 Mar 2004 12:04:43 -0800
In-Reply-To: <Pine.LNX.4.53.0403021318580.796@chaos>
Message-ID: <527jy3qalg.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 02 Mar 2004 20:04:44.0653 (UTC) FILETIME=[9B2779D0:01C40091]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Richard> Poll in 2.6.0; when a driver routine calls poll_wait() it
    Richard> returns <<immediately>> to somewhere in the kernel, then
    Richard> waits for my wake_up_interuptible(), before returning
    Richard> control to a user sleeping in poll(). This means that the
    Richard> user gets the wrong poll return value! It doesn't get the
    Richard> value it was given as a result of the interrupt, but the
    Richard> value that existed (0) before the interrupt occurred.

Nothing has changed in 2.6 that I know of.  poll_wait() always
returned immediately to the driver.  The driver's poll method is
supposed to call poll_wait() on the wait queues that indicate a change
in poll status, and then return with the current status.

Read the description of "poll and select" in LDD:
    <http://www.xml.com/ldd/chapter/book/ch05.html#t3>

 - Roland

