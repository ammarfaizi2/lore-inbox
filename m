Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317559AbSGXVCt>; Wed, 24 Jul 2002 17:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317560AbSGXVCt>; Wed, 24 Jul 2002 17:02:49 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:53443 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S317559AbSGXVCs>; Wed, 24 Jul 2002 17:02:48 -0400
Subject: Re: [PATCH 2/2] move slab pages to the lru, for 2.5.27
From: Steven Cole <elenstev@mesatop.com>
To: Craig Kulesa <ckulesa@as.arizona.edu>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Ed Tomlinson <tomlins@cam.org>,
       Steven Cole <scole@lanl.gov>
In-Reply-To: <1027542523.7518.108.camel@spc9.esa.lanl.gov>
References: <Pine.LNX.4.44.0207221520301.14311-100000@loke.as.arizona.edu> 
	<1027434665.12588.78.camel@spc9.esa.lanl.gov> 
	<1027542523.7518.108.camel@spc9.esa.lanl.gov>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 24 Jul 2002 15:02:29 -0600
Message-Id: <1027544549.7446.119.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-24 at 14:28, Steven Cole wrote:
[snipped]
> I finally got some time for more testing, and I booted this very same
> 2.5.25-rmap-slablru kernel on the same machine, and this time it booted
  2.5.27-rmap-slablru I meant to say.
> just fine. Then I began to exercise the box a little by running dbench
> with increasing numbers of clients.  At 28 clients, I got this:
On closer inspection, these errors began at 6 clients.
> 
> (31069) open CLIENTS/CLIENT16/~DMTMP/WORDPRO/BENCHS1.PRN failed for handle 4148 (Cannot allocate memory)
> (31070) nb_close: handle 4148 was not open
> (31073) unlink CLIENTS/CLIENT16/~DMTMP/WORDPRO/BENCHS1.PRN failed (No such file or directory)
> 
> Right after starting 32 dbench clients, the box locked up, no longer
> responding to the keyboard.  It did respond to pings, but nothing else.
> 
> This hardware does run other kernels successfully, most recently
> 2.4.19-rc3-ac3 and dbench 128 (load over 100).

I then tried rebooting 2.5.27-rmap-slablru with /home mounted as ext3,
and immediately after starting dbench 1, I got this message about 10
times or so:

ENOMEM in do_get_write_access, retrying.

And the box was locked up.  Next time, I'll have CONFIG_MAGIC_SYSRQ=y.
Meanwhile, it is running the dbench 1 to 64 series under 2.4.19-rc3 with
no problems at all.

Steven

