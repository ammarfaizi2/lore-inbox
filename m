Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290750AbSA3Xib>; Wed, 30 Jan 2002 18:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290747AbSA3XiW>; Wed, 30 Jan 2002 18:38:22 -0500
Received: from w147.z064001233.sjc-ca.dsl.cnc.net ([64.1.233.147]:32641 "EHLO
	funky.gghcwest.COM") by vger.kernel.org with ESMTP
	id <S290748AbSA3Xh0>; Wed, 30 Jan 2002 18:37:26 -0500
Subject: Re: 2.4.17: pwrite destroys block I/O throughput
From: "Jeffrey W. Baker" <jwbaker@acm.org>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1012431302.17074.10.camel@heat>
In-Reply-To: <1012431302.17074.10.camel@heat>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 30 Jan 2002 15:35:53 -0800
Message-Id: <1012433753.17074.15.camel@heat>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-01-30 at 14:55, Jeffrey W. Baker wrote:
> Hi there,
> 
> I've never heard of pwrite and pread before, but htdig apparently makes
> very heavy use of it.  On my 2.4.17 SMP 2GB HIGHMEM + ext3 system,
> running htdig destroys input rates for every other process.  htdig's
> output proceeds at approximately 2MB/s, but input for the entire system
> runs only at about 4KB/s (YES, KB!).  If I suspend htdig, system block
> input increases to the normal rate of 10-50MB/s.  Output still works, as
> a dd from /dev/zero to a 400MB file runs at about 25MB/s.

I looked around a little more and it seems that htdig is doing SYNC I/O
on its db2 files.  This may be the problem.  If so, it seems that sync
I/O is able to DoS all other I/O consumers on the machine.

-jwb

