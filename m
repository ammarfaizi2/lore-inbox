Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262489AbVAUT2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262489AbVAUT2O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 14:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262565AbVAUT1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 14:27:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:25015 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262489AbVAUT12 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 14:27:28 -0500
Date: Fri, 21 Jan 2005 11:27:25 -0800 (PST)
From: Bryce Harrington <bryce@osdl.org>
To: <dev@osdl.org>, <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@osdl.org>, <stp-devel@lists.sourceforge.net>,
       <ltp-list@lists.sourceforge.net>, <hanrahat@osdl.org>
Subject: Kernel Panic with LTP on 2.6.11-rc1 (was Re: LTP Results for 2.6.x
 and 2.4.x)
In-Reply-To: <Pine.LNX.4.33.0501181540480.11396-100000@osdlab.pdx.osdl.net>
Message-ID: <Pine.LNX.4.33.0501211058080.32650-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jan 2005, Bryce Harrington wrote:
> Here's an updated summary of our LTP regression test runs against the
> 2.6.x and 2.4.x kernels on RedHat 9.0:
>
>     http://developer.osdl.org/bryce/ltp/
>
> I've run into some issues with patch-2.6.11-rc1 and the latest LTP, but
> will post numbers when I've sorted those out.

Okay, it looks like there is a regression of Linux 2.6.11-rc1 on LTP.

I've run a bunch of tests to narrow down and rule things out:

   * Other tests (e.g. open_posix) run ok on this kernel
   * This version of LTP is working fine on other kernels
   * Not a hardware problem; same issue occurs on all of our 2-ways
   * Not distro-dependent; problem occurs for me on RH 9.0, and SuSE 9.0
     and 9.2

Here is the output from the test causing the panic:

<<<test_start>>>
tag=gf13 stime=1106333359
cmdline="mkfifo gffifo18; growfiles -b -W gf13 -e 1 -u -i 0 -L 30 -I r
-r 1-4096 gffifo18"
contacts=""
analysis=exit
initiation_status="ok"
<<<test_output>>>
growfiles(gf13): 17094 DEBUG1 Using random seed of 1106350453
Kernel panic - not syncing: Out of memory and no killable processes...


The full output are available at these links:

FAIL   LTP  2.6.11-rc1  SuSE 9.0  2-way  http://khack.osdl.org/stp/300213/
FAIL   LTP  2.6.11-rc1  SuSE 9.2  2-way  http://khack.osdl.org/stp/300219/
FAIL   LTP  2.6.11-rc1  SuSE 9.2  1-way  http://khack.osdl.org/stp/300209/

OK     LTP  2.6.10      SuSE 9.2  2-way  http://khack.osdl.org/stp/300230
OK     LTP  2.6.10      SuSE 9.0  2-way  http://khack.osdl.org/stp/300229
OK     LTP  2.6.10      RH 9.0    2-way  http://khack.osdl.org/stp/300228
OK     OPTS 2.6.11-rc1  RH 9.2    2-way  http://khack.osdl.org/stp/300227


These are all run on the December version of LTP (20041203).
growfiles.c is in ltp-full-20041203/testcases/kernel/fs/doio.

Bryce


