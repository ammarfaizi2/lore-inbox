Return-Path: <linux-kernel-owner+w=401wt.eu-S1759125AbWLJFPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759125AbWLJFPX (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 00:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759147AbWLJFPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 00:15:23 -0500
Received: from gw.goop.org ([64.81.55.164]:40471 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759064AbWLJFPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 00:15:23 -0500
Message-ID: <457B97EA.3080609@goop.org>
Date: Sat, 09 Dec 2006 21:15:22 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: xu feng <xu_feng_xu@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: virtual cache, TLB, and OS
References: <20061210022951.440.qmail@web58306.mail.re3.yahoo.com>
In-Reply-To: <20061210022951.440.qmail@web58306.mail.re3.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

xu feng wrote:
> I am just confused about the author:
> 1- first point, why the cache has to be bothered by
> the change in the address logical-physical mapping
> since it is a virtual cache??
>   

If you:

   1. mmap file A at virtual address X
   2. use memory at X
   3. mmap file B at X
   4. look at X

If its a virtual cache, and it wasn't flushed at step 3, then step 4
will see A's contents rather than B's.

> 2- could you please give me a situation where two
> virtual addresses from the same process are mapped to
> the same physical address? 
>
> i can't see this happening since each process page is
> allocated a dedicated frame. 
>   

If you mmap a file multiple times, then the kernel will assign multiple
different virtual addresses for the same page cache page(s).


    J
