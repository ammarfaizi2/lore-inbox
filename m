Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269763AbRHMDC2>; Sun, 12 Aug 2001 23:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269760AbRHMDCI>; Sun, 12 Aug 2001 23:02:08 -0400
Received: from gear.torque.net ([204.138.244.1]:41995 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S269756AbRHMDB6>;
	Sun, 12 Aug 2001 23:01:58 -0400
Message-ID: <3B773967.4A3B426A@torque.net>
Date: Sun, 12 Aug 2001 22:20:23 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: __alloc_pages: 3-order allocation failed.
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo wrote:
> > On Sun, 12 Aug 2001, André Dahlqvist wrote:
> > With recent kernel, 2.4.7 and 2.4.8 my syslog file has been filled with
> > these messages:
> > 
> > Aug 12 02:08:58 sledgehammer kernel: __alloc_pages: 3-order allocation failed.
> > Aug 12 02:08:58 sledgehammer kernel: __alloc_pages: 2-order allocation failed.
> > Aug 12 02:08:58 sledgehammer kernel: __alloc_pages: 1-order allocation failed.
> > Aug 12 02:08:58 sledgehammer kernel: __alloc_pages: 3-order allocation failed.
> > 
> > I have not yet found a pattern for when it happens but it doesn't seam to
> > affect my system all that much. Let me know if you want further info or if
> > this is a known thing.
> 
> Are you using SCSI?

Marcelo,
That looks just like the sg driver trying to build a
scatter gather list, first it tries 32 KB, then 16 KB
then 8 KB and final gets PAGE_SIZE. This is _not_ an
error (it just leads to more elements in the scatter
gather list).

Any chance that printk() in __alloc_pages() can be removed?

Doug Gilbert


