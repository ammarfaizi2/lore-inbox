Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbVKUJL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbVKUJL7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 04:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbVKUJL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 04:11:59 -0500
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:33211 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932237AbVKUJL6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 04:11:58 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Daniel =?iso-8859-1?q?Marjam=E4ki?= <daniel.marjamaki@comhem.se>
Subject: Re: I made a patch and would like feedback/testers (drivers/cdrom/aztcd.c)
Date: Mon, 21 Nov 2005 20:11:47 +1100
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <5aZsv-3CJ-17@gated-at.bofh.it> <200511211919.11429.kernel@kolivas.org> <43818880.8080800@comhem.se>
In-Reply-To: <43818880.8080800@comhem.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200511212011.48122.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2005 19:42, Daniel Marjamäki wrote:
> Con Kolivas wrote:
> > Convention in the kernel would be
> > 	aztTimeOut =  HZ / 100 ? : 1;
> > to be at least one tick (works for HZ even below 100) and is at least
> > 10ms. If you wanted 2 ms then use
> > 	aztTimeOut =  HZ / 500 ? : 1;
> > which would give you at least 2ms
>
> Thank you Con for the feedback.
>
> Hmm.. The minimum value should be 2, right?
> Otherwise the loop could time out after only a few nanoseconds.. since the
> loop will then timeout immediately on a clock tick. Or am I wrong?

 	aztTimeOut =  HZ / 500 ? : 1;
Would give you a 2ms timeout on 1000Hz and 500Hz
It would give you 5ms on 250Hz and 10ms on 100Hz

ie the absolute minimum it would be would be 2ms, but it would always be at 
least one timer tick which is longer than 2ms at low HZ values.

Cheers,
Con
