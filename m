Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbVDJMEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbVDJMEF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 08:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbVDJMEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 08:04:05 -0400
Received: from mx1.elte.hu ([157.181.1.137]:12005 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261482AbVDJMEA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 08:04:00 -0400
Date: Sun, 10 Apr 2005 14:03:31 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Jackson <pj@engr.sgi.com>
Cc: Chris Wedgwood <cw@f00f.org>, torvalds@osdl.org, davem@davemloft.net,
       andrea@suse.de, mbp@sourcefrog.net, linux-kernel@vger.kernel.org,
       dlang@digitalinsight.com
Subject: Re: Kernel SCM saga..
Message-ID: <20050410120331.GA8878@elte.hu>
References: <1112939769.29544.161.camel@hope> <Pine.LNX.4.58.0504072334310.28951@ppc970.osdl.org> <20050408083839.GC3957@opteron.random> <Pine.LNX.4.58.0504081647510.28951@ppc970.osdl.org> <20050409022701.GA14085@opteron.random> <Pine.LNX.4.58.0504082240460.28951@ppc970.osdl.org> <20050409155511.7432d5c7.davem@davemloft.net> <Pine.LNX.4.58.0504091611570.1267@ppc970.osdl.org> <20050410001435.GA23401@taniwha.stupidest.org> <20050409185636.0945abdf.pj@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050409185636.0945abdf.pj@engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul Jackson <pj@engr.sgi.com> wrote:

> These 16817 files consume:
> 
> 	224 MBytes uncompressed and
> 	 95 MBytes compressed
> 
> (using zlib's minigzip, on a 4 KB page reiserfs.)

that's a 42.4% compressed size. Using a (much) more CPU-intense 
compression method (bzip -9), the compressed size is down to 45 MBytes.  
(a ratio of 20.2%)

using default 'gzip' i get 57 MB compressed.

> Since each change will get its own copy of the file, multiplying these
> two sizes (224 and 95) by 12.2 changes per file means the disk cost
> would be:
> 
> 	2.73 GByte uncompressed, or
> 	1.16 GBytes compressed.

with bzip2 -9 it would be 551 MBytes. It might as well be practical on 
faster CPUs, a full tree (224 MBytes, 45 MBytes compressed) decompresses 
in 24 seconds on a 3.4GHz P4 - single CPU. (and with dual core likely 
becoming the standard, we might as well divide that by two) With default 
gzip it's 3.3 seconds though, and that still compresses it down to 57 
MB.

	Ingo
