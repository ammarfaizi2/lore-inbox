Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274603AbRIYVg0>; Tue, 25 Sep 2001 17:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274653AbRIYVgQ>; Tue, 25 Sep 2001 17:36:16 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:53520 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S274603AbRIYVgE>; Tue, 25 Sep 2001 17:36:04 -0400
Message-ID: <3BB0F8DF.21FC75F0@zip.com.au>
Date: Tue, 25 Sep 2001 14:36:31 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "DICKENS,CARY (HP-Loveland,ex2)" <cary_dickens2@hp.com>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "HABBINGA,ERIK (HP-Loveland,ex1)" <erik_habbinga@hp.com>
Subject: Re: 2.4.10 still slow compared to 2.4.5pre1
In-Reply-To: <C5C45572D968D411A1B500D0B74FF4A80418D549@xfc01.fc.hp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"DICKENS,CARY (HP-Loveland,ex2)" wrote:
> 
> We have run 2.4.10 under a heavy nfs load and kswapd now appears to be under
> control ( never went above 88.5%cpu and then only for a short time), but the
> nfs performance is about 45% of what it had been for the 2.4.5pre1 kernel.
> The response time grows steadily throughout the test until the test goes
> invalid.
> 
> Hardware:
> 4 processors, 4GB ram
> 45 fibre channel drives, set up in hardware RAID 0/1
> 2 direct Gigabit Ethernet connections between SPEC SFS prime client and
> system under test
> reiserfs
> all NFS filesystems exported with sync,no_wdelay to insure O_SYNC writes to
> storage
> NFS v3 UDP
> 
> I can provide top logs if anyone would like to see what is happening at any
> particular time.  Also, if you would like to see some results from a
> particular test, please let me know what test it would be.
> 

With a synchronous NFS export, I'd expect the disk throughput
to be lowered to such an extent that VM issues were not
significant in throughput.  But you have been seeing kswapd
problems so hmmm...

Conceivably this is a networking problem, and not an FS/VM
problem.  There were significant changes to the softirq
handling between 2.4.5 and 2.4.10, for example.

Could I suggest that you split these variables apart?  Perform
some comparative FS/VM testing between the kernels, and then
some comparative network testing?

Is it possible to run the SFS clients on the same machine,
over loopback?
