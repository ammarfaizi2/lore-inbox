Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbVCTNEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVCTNEY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 08:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261197AbVCTNEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 08:04:24 -0500
Received: from fire.osdl.org ([65.172.181.4]:46010 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261196AbVCTNEV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 08:04:21 -0500
Date: Sun, 20 Mar 2005 05:04:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Short sleep precision
Message-Id: <20050320050403.672bf30a.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0503201316320.18044@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0503201316320.18044@yvahk01.tjqt.qr>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
>
> I have found that FreeBSD has a very good precision of small sleeps --

Linux nanosleep() used to have a busywait loop for sleeps less than two
milliseconds.  2.4.x still does.

We thought it was stupid and took it out.

>  what's holding Linux back from doing the same? Using the code snippet below, 
>  FBSD yields between 2 and 80 us on the average while Linux is at 
>  "constantly" ~100 (with HZ=1000) and ~1000 (HZ=100).
> 

You can spin on the gettimeofday() result in userspace.
