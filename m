Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262842AbVGNSDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262842AbVGNSDH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 14:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262857AbVGNSDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 14:03:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31699 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262842AbVGNSCm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 14:02:42 -0400
Date: Thu, 14 Jul 2005 11:00:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: arjan@infradead.org, torvalds@osdl.org, rlrevell@joe-job.com,
       dean-list-linux-kernel@arctic.org, cw@f00f.org, len.brown@intel.com,
       dtor_core@ameritech.net, david.lang@digitalinsight.com,
       davidsen@tmr.com, kernel@kolivas.org, linux-kernel@vger.kernel.org,
       mbligh@mbligh.org, diegocg@gmail.com, azarah@nosferatu.za.org,
       christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-Id: <20050714110059.42244b64.akpm@osdl.org>
In-Reply-To: <20050714121340.GA1072@ucw.cz>
References: <d120d50005071312322b5d4bff@mail.gmail.com>
	<1121286258.4435.98.camel@mindpipe>
	<20050713134857.354e697c.akpm@osdl.org>
	<20050713211650.GA12127@taniwha.stupidest.org>
	<Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org>
	<20050714005106.GA16085@taniwha.stupidest.org>
	<Pine.LNX.4.63.0507131810430.13193@twinlark.arctic.org>
	<1121304825.4435.126.camel@mindpipe>
	<Pine.LNX.4.58.0507131847000.17536@g5.osdl.org>
	<1121326938.3967.12.camel@laptopd505.fenrus.org>
	<20050714121340.GA1072@ucw.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> wrote:
>
> A note on the relaive timer API: There needs to be a way to say
>  "x milliseconds from the time this timer should have triggered" instead
>  of "x milliseconds from now", to avoid skew in timers that try to be
>  strictly periodic.

	mod_timer(timer, timer->expires + N) ?

(add_timer() will treat a negative `expires' as "right now", so we'll dtrt
if the time now has overrun (timer->expires + N))
