Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269787AbRHMDdY>; Sun, 12 Aug 2001 23:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269786AbRHMDdO>; Sun, 12 Aug 2001 23:33:14 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:13576 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S269787AbRHMDdH> convert rfc822-to-8bit; Sun, 12 Aug 2001 23:33:07 -0400
Date: Sun, 12 Aug 2001 23:04:23 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Douglas Gilbert <dougg@torque.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: __alloc_pages: 3-order allocation failed.
In-Reply-To: <3B773967.4A3B426A@torque.net>
Message-ID: <Pine.LNX.4.21.0108122301260.18092-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 12 Aug 2001, Douglas Gilbert wrote:

> Marcelo wrote:
> > > On Sun, 12 Aug 2001, André Dahlqvist wrote:
> > > With recent kernel, 2.4.7 and 2.4.8 my syslog file has been filled with
> > > these messages:
> > > 
> > > Aug 12 02:08:58 sledgehammer kernel: __alloc_pages: 3-order allocation failed.
> > > Aug 12 02:08:58 sledgehammer kernel: __alloc_pages: 2-order allocation failed.
> > > Aug 12 02:08:58 sledgehammer kernel: __alloc_pages: 1-order allocation failed.
> > > Aug 12 02:08:58 sledgehammer kernel: __alloc_pages: 3-order allocation failed.
> > > 
> > > I have not yet found a pattern for when it happens but it doesn't seam to
> > > affect my system all that much. Let me know if you want further info or if
> > > this is a known thing.
> > 
> > Are you using SCSI?
> 
> Marcelo,
> That looks just like the sg driver trying to build a
> scatter gather list, first it tries 32 KB, then 16 KB
> then 8 KB and final gets PAGE_SIZE. This is _not_ an
> error (it just leads to more elements in the scatter
> gather list).

Ok.

> Any chance that printk() in __alloc_pages() can be removed?

Hum, I don't think its a good idea: we _want_ to know if __alloc_pages()
failed in case the allocation being done is critical.

A new allocation flag to indicate if its the allocation being done is just
an "optimization" (which means the VM can be more lazy when trying to free
pages) and not a critical allocation is the way to go, IMO. 

