Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265336AbUBPEKM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 23:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265339AbUBPEKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 23:10:11 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57242 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265336AbUBPEKG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 23:10:06 -0500
Message-ID: <40304290.7090207@pobox.com>
Date: Sun, 15 Feb 2004 23:09:52 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Chip Salzenberg <chip@pobox.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Linux 2.6.3-rc3 - IDE DMA errors on Thinkpad A30
References: <E1AsO6X-0003hW-1u@tytlal> <200402151658.57710.bzolnier@elka.pw.edu.pl> <20040215163438.GC3789@perlsupport.com> <200402151808.42611.bzolnier@elka.pw.edu.pl> <20040216005523.GD3789@perlsupport.com> <40302783.6020505@pobox.com> <20040216033740.GE3789@perlsupport.com>            <40303D59.4030605@pobox.com> <200402160358.i1G3wC6W013389@turing-police.cc.vt.edu>
In-Reply-To: <200402160358.i1G3wC6W013389@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Sun, 15 Feb 2004 22:47:37 EST, Jeff Garzik said:
> 
>>One for the todo list, I suppose...  a useable workaround for this is 
>>probably good ole 'e2fsck -c', i.e. badblocks...  That says "check again 
>>to see if this sector is bad", and -hopefully- will unmark bad blocks 
>>that were incorrectly marked bad.
> 
> 
> Does e2fsck/badblocks issue the right ioctls/etc to make the disk read the
> *original* block, or will the disk simply check the *redirected* block?


I'm not sure your question has meaning.

Consider:  ext2 reads sector 1234.  drive returns "media error", and 
then swaps the bad sector for a good one.  Reboot and run badblocks. 
badblocks reads sector 1234, in whatever manner the drive chooses to 
present sector 1234 to the OS.

"original" versus "redirected" block is invisible to the OS.  The OS 
only knows that an event occured at a single point in time -- the media 
error.

	Jeff



