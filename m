Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278762AbRJVMTJ>; Mon, 22 Oct 2001 08:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278770AbRJVMS7>; Mon, 22 Oct 2001 08:18:59 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:64088 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S278762AbRJVMSu>; Mon, 22 Oct 2001 08:18:50 -0400
Date: Mon, 22 Oct 2001 14:19:23 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.nnet
Subject: Re: Knob turning on mtest01 for 2.4.13-pre5aa1
Message-ID: <20011022141923.K26029@athlon.random>
In-Reply-To: <20011021234805.A2824@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011021234805.A2824@earthlink.net>; from rwhron@earthlink.net on Sun, Oct 21, 2001 at 11:48:05PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2001 at 11:48:05PM -0400, rwhron@earthlink.net wrote:
> Kernel	2.4.13-pre5aa1
> 
> Goal:	Measure the affect of changing new vm parameters.
> 
> Test:	Run 2 iterations each of LTP tests mtest01 and mmap001.
> 	mtest01 files 80% of virtual memory and writes to each page.
> 	mmap001 mmaps and writes to 100000 pages.
> 	listen to long playing (50+ minutes) mp3 sampled at 128k.
> 	page-cluster=2 for all tests.  (best value so far for 
> 	non-skipping mp3).
> 
> There was only a second or two of mp3 skipping throughout the entire test.
> 
> Pleasantly, one set of values came up on top for both tests, but the
> overall variance isn't that large.  There could be several good values 
> for these parameters.
> 
> mtest01 (2 iterations) with various settings of 2.4.13-pre5aa1 knobs:
> 
> 105 seconds on mtest01 vm_balance_ratio = 16   vm_mapped_ratio = 1   vm_scan_ratio = 16

Cool. this just proofs the vm_mapped_ratio logic is not worthwhile (I
had similar results here so this just confirms).  So I'm killing it
enterely (Linus was completly right that it wans't worthwhile). I'm also
changing a bit the semantics of vm_balance_ratio (similar to pre3aa1)
and I'm lowering it down due the slight change of semantics, plus I'm
including the PG_launder (that resembles the PG_wait_for_IO logic in
pre3aa1) and slightly modified BH_wait_IO logic from Linus. Hopefully
the end result will be positive.

Thanks very much for this great feedback! :)

Andrea
