Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbUFVKX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbUFVKX7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 06:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbUFVKX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 06:23:59 -0400
Received: from zero.aec.at ([193.170.194.10]:52742 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261987AbUFVKX6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 06:23:58 -0400
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new device support for forcedeth.c fourth try
References: <29ACK-1wm-17@gated-at.bofh.it> <29B5I-1QM-3@gated-at.bofh.it>
	<29QeD-5kp-11@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Tue, 22 Jun 2004 12:23:55 +0200
In-Reply-To: <29QeD-5kp-11@gated-at.bofh.it> (Carl-Daniel Hailfinger's
 message of "Tue, 22 Jun 2004 12:00:19 +0200")
Message-ID: <m3llifevr8.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net> writes:

> Known Bug: You will get a "bad: scheduling while atomic" message because
> of the msleep(500) in PHY reset.
>
> Any suggestions how I can avoid this message? Using mdelay(500) has its
> share of problems too, because it will cause lost time.

Use schedule_work() to push it into a worker thread.
While letting a worker thread sleep for 500ms is also not nice,
it's better than doing it in an interrupt. The best but also
most complicated solution is to set up a timer using add_timer
for this, but this quickly gets you into state machine hell.

-Andi

