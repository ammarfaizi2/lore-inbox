Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261807AbULGNL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbULGNL3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 08:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261805AbULGNL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 08:11:28 -0500
Received: from mx2.elte.hu ([157.181.151.9]:7618 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261808AbULGNKP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 08:10:15 -0500
Date: Tue, 7 Dec 2004 14:10:06 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Michael Buesch <mbuesch@freenet.de>
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org, kernel@kolivas.org
Subject: Re: [PATCH, RFC] protect call to set_tsk_need_resched() by the rq-lock
Message-ID: <20041207131006.GB3710@elte.hu>
References: <200412062339.52695.mbuesch@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412062339.52695.mbuesch@freenet.de>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Michael Buesch <mbuesch@freenet.de> wrote:

> The two attached patches (one against vanilla kernel and one against
> ck patchset) moves the rq-lock a few lines up in scheduler_tick() to
> also protect set_tsk_need_resched().
> 
> Is that neccessary?

scheduler_tick() is a special case, 'current' is pinned and cannot go
away, nor can it get off the runqueue. So the patch is not needed.

	Ingo
