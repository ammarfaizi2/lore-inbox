Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263118AbRFECkg>; Mon, 4 Jun 2001 22:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263124AbRFECkZ>; Mon, 4 Jun 2001 22:40:25 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:44812 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S263118AbRFECkS>; Mon, 4 Jun 2001 22:40:18 -0400
Date: Mon, 4 Jun 2001 22:04:22 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Zlatko Calusic <zlatko.calusic@iskon.hr>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Comment on patch to remove nr_async_pages limit
Message-ID: <Pine.LNX.4.21.0106042142550.2521-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Zlatko, 

I've read your patch to remove nr_async_pages limit while reading an
archive on the web. (I have to figure out why lkml is not being delivered
correctly to me...)

Quoting your message: 

"That artificial limit hurts both swap out and swap in path as it
introduces synchronization points (and/or weakens swapin readahead),
which I think are not necessary."

If we are under low memory, we cannot simply writeout a whole bunch of
swap data. Remember the writeout operations will potentially allocate
buffer_head's for the swapcache pages before doing real IO, which takes
_more memory_: OOM deadlock. 


