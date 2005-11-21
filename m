Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbVKUITk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbVKUITk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 03:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbVKUITk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 03:19:40 -0500
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:30701 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932211AbVKUITj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 03:19:39 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Daniel =?iso-8859-1?q?Marjam=E4ki?= <daniel.marjamaki@comhem.se>
Subject: Re: I made a patch and would like feedback/testers (drivers/cdrom/aztcd.c)
Date: Mon, 21 Nov 2005 19:19:11 +1100
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, 7eggert@gmx.de, nish.aravamudan@gmail.com
References: <5aZsv-3CJ-17@gated-at.bofh.it> <E1EdwGs-0000qv-NL@be1.lrz> <438180C0.2030503@comhem.se>
In-Reply-To: <438180C0.2030503@comhem.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200511211919.11429.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2005 19:09, Daniel Marjamäki wrote:
> Bodo Eggert wrote:
> > Daniel Marjamäki <daniel.marjamaki@comhem.se> wrote:
> >>-     aztTimeOutCount = 0;
> >>+     aztTimeOut = jiffies + 2;
> >
> > Different timeout based on HZ seems wrong.
>
> Yes, but..
>
> If I'd say "HZ/100", then all systems that uses my driver must have
> HZ>=200.
>
> The way I do it:
> All systems will give me a delay for at least a few ms.
> I get the shortest timeout possible on each computer.

Convention in the kernel would be 
	aztTimeOut =  HZ / 100 ? : 1;
to be at least one tick (works for HZ even below 100) and is at least 10ms. If 
you wanted 2 ms then use
	aztTimeOut =  HZ / 500 ? : 1;
which would give you at least 2ms

Cheers,
Con
