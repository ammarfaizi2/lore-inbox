Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932527AbVL1LAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527AbVL1LAH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 06:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbVL1LAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 06:00:07 -0500
Received: from 213-140-2-73.ip.fastwebnet.it ([213.140.2.73]:37296 "EHLO
	aa006msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932527AbVL1LAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 06:00:06 -0500
Date: Wed, 28 Dec 2005 12:01:29 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Con Kolivas <kernel@kolivas.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [SCHED] Totally WRONG prority calculation with specific
 test-case (since 2.6.10-bk12)
Message-ID: <20051228120129.2a8d1199@localhost>
In-Reply-To: <200512281027.00252.kernel@kolivas.org>
References: <20051227190918.65c2abac@localhost>
	<20051227224846.6edcff88@localhost>
	<200512281027.00252.kernel@kolivas.org>
X-Mailer: Sylpheed-Claws 2.0.0-rc1 (GTK+ 2.6.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Dec 2005 10:26:58 +1100
Con Kolivas <kernel@kolivas.org> wrote:

> Looking at your top output I see that transcode command generates 7 processes 
> all likely to be using cpu, and your DD slowdown is almost 7 times... I 
> assume it all goes away if you nice the transcode up by 3 or more.

Yes, if I nice everything to 3 or more (nice -n 3 dvdrip ...) it works,
but I would prefer a less weak scheduler (see the other email, with
results for various schedulers).

Another thing that I've noticed is that things tends to get worse when
"transcode" is running for long time (some hours). It happened to me
some times (with ingosched and also with staircase if I remember
correctly):
	after some hours of running transcode (with me away from the
machine) I've found a totally UNUSABLE system. Transcode was the king
of the machine and everything else get almost no CPU time. Switching to
a Text-Console takes something like 10s (or something like that). When
I was finally logged in as root I've reniced transcode and companyto +19
and the system was usable again ;)

To get things even more STRANGE: another time that this happened I've
done the same thing except that I've reniced them to "0" (the same nice
level they were running) ---> And the system became usable again (with
the usual slow down but still usable).

This is what I remember. Now I think we can agree that there is
something wrong... no?

:)

-- 
	Paolo Ornati
	Linux 2.6.15-rc5-plugsched on x86_64
