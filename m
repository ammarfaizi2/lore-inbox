Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267588AbUIUMAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267588AbUIUMAX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 08:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267592AbUIUMAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 08:00:22 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:731 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267588AbUIUMAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 08:00:19 -0400
Subject: Re: Implementation defined behaviour in read_write.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rainer Weikusat <rainer.weikusat@sncag.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org, akpm@osdl.org
In-Reply-To: <878yb5ey11.fsf@farside.sncag.com>
References: <878yb5ey11.fsf@farside.sncag.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095764243.30748.55.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 21 Sep 2004 11:57:48 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-09-20 at 16:54, Rainer Weikusat wrote:
> The following code is in the function do_readv_writev in the file
> fs/read_write.c (2.6.8.1):

The 2.4.x kernel has part of this fixed. In particular it does the
overflow check differently because gcc 3.x in some forms did appear to
be making use of the undefined nature of the test and that was a
potential security hole. ("its undefined lets say its always false..")

The initial cast and test should be fine. The overflow problem was fixed
in the 2.4 tree and is handled by keeping tot_len unsigned so that the
overflow is a defined operation and then checking versus 0x7FFFFFFF or
0x7FFFFFFFFFFFFFFFUL according to BITS_PER_LONG. I guess the 2.4 code
should be merged into 2.6, perhaps using limits.h instead ?

Alan

