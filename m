Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270138AbTGaPAJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 11:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272500AbTGaPAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 11:00:09 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:30848 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S270138AbTGaPAE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 11:00:04 -0400
Date: Thu, 31 Jul 2003 15:59:37 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       Johoho <johoho@hojo-net.de>, wodecki@gmx.de, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O10int for interactivity
Message-ID: <20030731145937.GD6410@mail.jlokier.co.uk>
References: <200307280112.16043.kernel@kolivas.org> <20030728143545.1d989946.akpm@osdl.org> <3F28B8D5.4040600@cyberone.com.au> <200307311743.17370.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307311743.17370.kernel@kolivas.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> On Thu, 31 Jul 2003 16:36, Nick Piggin wrote:
> > Oh, and the process scheduler can definitely be a contributing factor.
> > Even if it looks like your process is getting enough cpu, if your
> > process doesn't get woken in less than 5ms after its read completes,
> > then AS will give up waiting for it.
> 
> This part interests me. It would seem that either 
> 1. The AS scheduler should not bother waiting at all if the process is not 
> going to wake up in that time

How about something as simple as: if process sleeps, and AS scheduler
is waiting since last request from that process, AS scheduler stops
waiting immediately?

In other words, a hook in the process scheduler when a process goes to
sleep, to tell the AS scheduler to stop waiting.

Although this would not always be optimal, for many cases the point of
AS is that the process is continuing to run, not sleeping, and will
issue another request shortly.

-- Jamie

