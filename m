Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274062AbRJQCg1>; Tue, 16 Oct 2001 22:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274064AbRJQCgH>; Tue, 16 Oct 2001 22:36:07 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:22896 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S274062AbRJQCft>; Tue, 16 Oct 2001 22:35:49 -0400
Date: Wed, 17 Oct 2001 04:31:03 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net
Subject: Re: VM test on 2.4.13-pre3aa1 (compared to 2.4.12-aa1 and 2.4.13-pre2aa1)
Message-ID: <20011017043103.D2380@athlon.random>
In-Reply-To: <20011016081639.A209@earthlink.net> <20011017021242.S2380@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011017021242.S2380@athlon.random>; from andrea@suse.de on Wed, Oct 17, 2001 at 02:12:42AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2001 at 02:12:42AM +0200, Andrea Arcangeli wrote:
> >  3  3  0  47424   3788   1172   1412 860 40228   892 40236  789   819  12  23  66
> >  0  5  1  90244   1656   1184   1416 1032 39568  1076 39572  653   425   6   5  89
> 
> those swapins could be due mp3blast that is getting swapped out
> continously while it sleeps.  Not easy for the vm to understand it has

I noticed that anotehr thing that changed between vanilla 2.4.13pre2 and
2.4.13pre3 is the setting of page_cluster on machine with lots of ram.

You'll now find the page_cluster set to 6, that means "1 << 6 << 12"
bytes will be paged in at each major fault, while previously only "1 <<
4 << 12" bytes were paged in.

So I'd suggest to try again after "echo 4 > /proc/sys/vm/page-cluster"
to see if it makes any difference.

Andrea
