Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbTFJBIB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 21:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbTFJBIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 21:08:01 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:40689 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262427AbTFJBH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 21:07:59 -0400
Date: Mon, 9 Jun 2003 18:22:13 -0700
From: Andrew Morton <akpm@digeo.com>
To: george anzinger <george@mvista.com>
Cc: linux-kernel@vger.kernel.org, Eric.Piel@Bull.Net
Subject: Re: [PATCH] Some clean up of the time code.
Message-Id: <20030609182213.2072ca24.akpm@digeo.com>
In-Reply-To: <3EE52CA7.9010007@mvista.com>
References: <3EE52CA7.9010007@mvista.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jun 2003 01:21:40.0055 (UTC) FILETIME=[A4EC4E70:01C32EEE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger <george@mvista.com> wrote:
>
> -void do_settimeofday(struct timeval *tv)
>  +int do_settimeofday(struct timespec *tv)
>   {
>  +	if ((unsigned long)tv->tv_nsec > NSEC_PER_SEC)
>  +		return -EINVAL;
>  +

Should that be ">="?

Is there any reasonable way to avoid breaking existing
do_settimeofday() implementations? That's just more grief all round.
