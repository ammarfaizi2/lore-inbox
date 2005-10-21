Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964926AbVJUNAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbVJUNAS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 09:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964936AbVJUNAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 09:00:18 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:55523 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964926AbVJUNAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 09:00:17 -0400
Subject: Re: Understanding Linux addr space, malloc, and heap
From: Arjan van de Ven <arjan@infradead.org>
To: "Vincent W. Freeh" <vin@csc.ncsu.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4358E339.20608@csc.ncsu.edu>
References: <4358E339.20608@csc.ncsu.edu>
Content-Type: text/plain
Date: Fri, 21 Oct 2005 15:00:02 +0200
Message-Id: <1129899603.2786.16.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-21 at 08:46 -0400, Vincent W. Freeh wrote:
> I am trying to understand the Linux addr space.  I figured someone might 
> be able to shed some light on it.  Or at least point me to some sources 
> that will help.
> 
> I don't understand what is happening with malloc and the heap in my 
> process. According to /proc/<pid>/maps the memory from heap to stack 
> initially looks like that.  I only show the four "maps" from the heap 
> and above.  (This is a slightly altered form consisting of start_addr, 
> end_addr, size_in_pgs, permissions, and path_if_one):
> 
> 0x08d42000 - 0x08d63000 (33 pgs) rw-p   path `[heap]'
> 0xb7ef8000 - 0xb7ef9000 (1 pgs) rw-p
> 0xb7f09000 - 0xb7f0b000 (2 pgs) rw-p
> 0xbfaf5000 - 0xbfb0b000 (22 pgs) rw-p   path `[stack]'
> 
> First, please fix any erroneous statements/assumptions above.  Next I 
> have many questions.  A few follow.
> 
> * How does the heap work?  I learned/teach that heap is a contiguous 
> chunk of memory that holds dynamically-allocated memory.  Doesn't appear 
> to be the case.

that's the old school 1970's stuff

the "heap" is still brk in linux, however there is no 1:1 relation
between heap and malloc. malloc in glibc is implemented both using brk
and mmap, depending on the size of your allocation.


> 
> * Man pg says can only mprotect mmap-able pages.  But what are these? 
> How can I tell?

you need to mmap these yourself to be sure.. eg you cannot mprotect the
output of malloc, at least not reliably. Only of mmap.

> 
> * Why does mprotect silently fail?

no it has sideeffects; eg it most likely affects more memory than just
your malloc()'d part


> * I thought brk indicated the top of the heap and that all dynamic 
> memory would be between bss end and brk.  That's not true.  What is brk 
> for then?

see definition of heap vs malloc above


