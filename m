Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261846AbUKCUPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbUKCUPl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 15:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbUKCUPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 15:15:39 -0500
Received: from ruby-fe0.getonit.net.au ([202.47.112.2]:57258 "EHLO
	ruby.getonit.net.au") by vger.kernel.org with ESMTP id S261846AbUKCUN1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 15:13:27 -0500
From: "Tim Warnock" <timoid@getonit.net.au>
To: "'Neil Horman'" <nhorman@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: ipv4 arp and linux
Date: Thu, 4 Nov 2004 06:13:18 +1000
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA4+E3P43380+sBshf1RHa98KAAAAQAAAAYtAmuHujdUS5GzoYL+cKTQEAAAAA@getonit.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AcTBpH49+DsPPey1Q7eoY2xUT2kYoAAOvTNg
In-Reply-To: <4188D55D.7000200@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Tim Warnock wrote:
> > What arp packet size does a linux 2.4 series kernel use? 
> > How would it be made bigger?
> > 
> 64 bytes is the minimum packet size of an ethernet frame 
> (which includes the CRC).  ARP requests don't take up that much 
> space so the kernel pads them out to be large enough.
> A tcpdump will show you exactly how it looks.
> 

Invoked:
tcpdump -i eth4 -nn arp -s1500 -XX

05:59:11.438737 arp who-has 203.63.65.194 tell 203.63.65.193
0x0000   0001 0800 0604 0001 000c f1ab 7607 cb3f        ............v..?
0x0010   41c1 0000 0000 0000 cb3f 41c2                  A........?A.

05:59:11.439060 arp reply 203.63.65.194 is-at 0:7:eb:63:40:82
0x0000   0001 0800 0604 0002 0007 eb63 4082 cb3f        ...........c@..?
0x0010   41c2 000c f1ab 7607 cb3f 41c1 0000 0000        A.....v..?A.....
0x0020   0000 0000 0000 0000 0000 0000 0000             ..............

Those aren't 64 bytes, but would tcpdump show the padding?

> 802.3 stipulates 64 bytes for all ethernet frames.  If you have a 
> program that is somehow sending frames smaller than that, 
> yes, you (or something) is broken.  How exactly are you sending frames 
> that you think are too small?

I havent done anything (just stock kernels), but the network operators claim
they have seen this before out of linux boxes and that it was caused by
illegally short arp frames.

I've used linux for years and this is the first time that I have had any
issues with any switch/router.

The problem that im facing is that the other side is learning my mac
address, but I fail to learn theirs and end up with packet loss. (I see lots
of arp who-has) but the other end never receive it.

Hard coding their mac address in solved the issue.

Thanks
Tim

> Neil
> /***************************************************
>   *Neil Horman
>   *Software Engineer
>   *Red Hat, Inc.
>   *nhorman@redhat.com
>   *gpg keyid: 1024D / 0x92A74FA1
>   *http://pgp.mit.edu
>   ***************************************************/

