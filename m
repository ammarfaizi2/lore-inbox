Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264085AbUFVORS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264085AbUFVORS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 10:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263932AbUFVONl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 10:13:41 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:3369 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S263928AbUFVONG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 10:13:06 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andi Kleen <ak@muc.de>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new device support for forcedeth.c fourth try
X-Message-Flag: Warning: May contain useful information
References: <29ACK-1wm-17@gated-at.bofh.it> <29B5I-1QM-3@gated-at.bofh.it>
	<29QeD-5kp-11@gated-at.bofh.it>
	<m3llifevr8.fsf@averell.firstfloor.org> <40D837AB.2000104@pobox.com>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 22 Jun 2004 06:54:48 -0700
In-Reply-To: <40D837AB.2000104@pobox.com> (Jeff Garzik's message of "Tue, 22
 Jun 2004 09:44:11 -0400")
Message-ID: <52d63rpujb.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 22 Jun 2004 13:54:48.0881 (UTC) FILETIME=[7BB57210:01C45860]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jeff" == Jeff Garzik <jgarzik@pobox.com> writes:

    > Andi Kleen wrote:
    >> Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
    >> writes:

    >>> Known Bug: You will get a "bad: scheduling while atomic"
    >>> message because of the msleep(500) in PHY reset.

    >>> Any suggestions how I can avoid this message? Using
    >>> mdelay(500) has its share of problems too, because it will
    >>> cause lost time.

    >> Use schedule_work() to push it into a worker thread.

    > Agreed.  This is what I am moving net drivers to, for slow
    > path stuff like chip reset or twiddling the phy.

In this case is it possible to use schedule_delayed_work() to avoid
stalling keventd for half a second?

 - R.
