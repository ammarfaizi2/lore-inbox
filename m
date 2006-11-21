Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031403AbWKUU2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031403AbWKUU2q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 15:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031404AbWKUU2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 15:28:46 -0500
Received: from mx1.redhat.com ([66.187.233.31]:21996 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1031403AbWKUU2p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 15:28:45 -0500
Subject: Re: [RFC][PATCH] Fix locking on misrouted interrupts
From: Ingo Molnar <mingo@redhat.com>
To: Pavel Emelianov <xemul@openvz.org>
Cc: Vivek Goyal <vgoyal@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Kirill Korotaev <dev@sw.ru>
In-Reply-To: <4562BD4E.20600@openvz.org>
References: <4562BD4E.20600@openvz.org>
Content-Type: text/plain
Date: Tue, 21 Nov 2006 21:26:00 +0100
Message-Id: <1164140760.15988.52.camel@earth>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-21 at 11:48 +0300, Pavel Emelianov wrote:
> Vivek noted that many places call note_interrupt()
> without desc->lock being held. Since note_interrupt()
> which tries to unlock this lock to handle spurious
> interrupts accodring to
> http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=f72fa707604c015a6625e80f269506032d5430dc
> 
> Looking at note_interrupt() I found that desc->lock
> IS required in this function but all the places that
> call note_interrupt() lock it after the call. One
> exception from this rule is __do_IRQ().
> 
> So I move spin_lock(&desc->lock); before calling
> note_interrupt() in all places.
> 
> Signed-off-bt: Pavel Emelianov <xemul@openvz.org>

indeed - and this is a fallout of the earlier fix in note_interrupt().
Andrew, Linus: i think this is a must-have for 2.6.19 as well.

Acked-by: Ingo Molnar <mingo@redhat.com>

	Ingo

