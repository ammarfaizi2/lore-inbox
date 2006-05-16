Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbWEPXDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWEPXDM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 19:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbWEPXDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 19:03:12 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:31188 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932253AbWEPXDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 19:03:11 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Martin Peschke <mp3@de.ibm.com>
Subject: Re: [RFC] [Patch 7/8] statistics infrastructure - exploitation prerequisite
Date: Wed, 17 May 2006 01:03:08 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, ak@suse.de,
       hch@infradead.org, arjan@infradead.org, James.Smart@emulex.com,
       James.Bottomley@steeleye.com
References: <446A1023.6020108@de.ibm.com> <20060516112824.39b49563.akpm@osdl.org> <446A53DE.6060400@de.ibm.com>
In-Reply-To: <446A53DE.6060400@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605170103.08917.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wednesday 17 May 2006 00:36 schrieb Martin Peschke:
> Any other hints on how to replace my sched_clock() calls are welcome.
> (I want to measure elapsed times in units that are understandable to
> users without hardware manuals and calculator, such as milliseconds.)

There are a number of APIs that allow you to get the time:

- do_gettimeofday
  potentially slow, reliable TOD clock, microsecond resolution
- ktime_get_ts
  monotonic clock, nanosecond resolution
- getnstimeofday
  reliable, nanosecond TOD clock
- xtime
  jiffie accurate TOD clock, with fast reads
- xtime + wall_to_monotonic
  jiffie accurate monotonic clock, almost as fast
- get_cycles
  highest supported resolution and accuracy, highly
  HW-specific behaviour, may overflow.

	Arnd <><
