Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965085AbVINIb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965085AbVINIb0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 04:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965086AbVINIb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 04:31:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24780 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965085AbVINIb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 04:31:26 -0400
Date: Wed, 14 Sep 2005 01:30:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mathieu Fluhr <mfluhr@nero.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13 brings buffer underruns when recording DVDs in 16x (was
 Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1)
Message-Id: <20050914013053.0c2b302c.akpm@osdl.org>
In-Reply-To: <1126685479.2010.14.camel@localhost.localdomain>
References: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org>
	<1126608030.3455.23.camel@localhost.localdomain>
	<1126630878.2066.6.camel@localhost.localdomain>
	<Pine.LNX.4.58.0509131010010.3351@g5.osdl.org>
	<1126635160.2183.6.camel@localhost.localdomain>
	<Pine.LNX.4.58.0509131210090.3351@g5.osdl.org>
	<1126685479.2010.14.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Fluhr <mfluhr@nero.com> wrote:
>
> According to the MMC documentation, you can thoeriticaly send at most
>  65535 (16 bits int) blocks in one WRITE(10) CDB. This would means
>  sending a buffer of ~127 MB on case of writing a mode 1 data track (2048
>  bytes per block)...
> 
>  Now, practically, it is really not safe to send more than 64 KB per CDB
>  (Mostly device related). And with such values, you have the following:
>   - at 100 Hz  -> 64 KB * 100  = 6400 KB/s  <=> ~4.62x  DVD 
>   - at 250 Hz  -> 64 KB * 250  = 16000 KB/s <=> ~11.55x DVD 
>   - at 1000 Hz -> 64 KB * 1000 = 64000 KB/s <=> ~46.20x DVD

But that implies that there's some piece of code somewhere (could be
userspace, could be kernel) which is doing a timer-based sleep() in between
each CDB.  It shouldn't do that - it should be using the disk
controller's completion interrupt for synchronisation.

What userspace application are you using to write the DVDs, and is it
possible to test a different one?

