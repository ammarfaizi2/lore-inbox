Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279639AbRJXX1C>; Wed, 24 Oct 2001 19:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279642AbRJXX0n>; Wed, 24 Oct 2001 19:26:43 -0400
Received: from femail28.sdc1.sfba.home.com ([24.254.60.18]:16772 "EHLO
	femail28.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S279640AbRJXX0j>; Wed, 24 Oct 2001 19:26:39 -0400
Message-ID: <3BD74D77.3B73A446@home.com>
Date: Wed, 24 Oct 2001 19:23:36 -0400
From: John Gluck <jgluckca@home.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: SCSI read performance issues (2.2.19 and 2.4.10)
Content-Type: multipart/mixed;
 boundary="------------098368129F88303742EEE513"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------098368129F88303742EEE513
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit



--------------098368129F88303742EEE513
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

X-Mozilla-Status2: 00000000
Message-ID: <3BD73EC9.C42CFF6E@home.com>
Date: Wed, 24 Oct 2001 18:20:57 -0400
From: John Gluck <jgluckca@home.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: gdth / SCSI read performance issues (2.2.19 and 2.4.10)
In-Reply-To: <3BD6B278.3070300@geizhals.at> <3BD6ECE6.8C9435C4@zip.com.au> <3BD729B6.6030902@geizhals.at> <3BD73280.7FC6526D@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi

Just my experience with 2.4.13

SCSI disk performance. I tested with hdparm  peaks at 17 meg /sec. My SCSI
controller and HD are capable of up to 40 meg /sec.
IDE disks on an ATA 33 contoller peak at 20 to 23 megs depending on which disk.

If there's any test you'd like me to try I'll be more than happy to.

John


>

[snip]

> Really?  Are you saying that on a controller which can
> do 85 megs/second, you can't read files through the filesystem
> at greater than 17?  Which filesystem?
>
> > The result (last 4 lines):
> > c01388fc try_to_free_buffers                          55   0.1511
> > c0128b10 file_read_actor                            1179  14.0357
> > c01053b0 default_idle                               6784 130.4615
> > 00000000 total                                      8695   0.0065
>
> OK, that's normal and proper.  Almost all the kernel time
> is spent copying data.
>
> > Does this suggest that the kernel isn't the bottleneck?
>
> Well...   We seem to have three issues here:
>
> 1: Why isn't the controller achieving the manufacturer's
>    claimed throughput?
>
>    Don't know.  Maybe it's the software copy.  Maybe it's the
>    device driver.  Maybe they lied :).  It'd be interesting
>    to test it on the same machine with the vendor's drivers
>    and win2k.
>
> 2: 0-order allocation failures.
>
> 3: Poor `cp' throughput.  This one is strange.  Perhaps
>    `cp' is using a small transfer-size and the kernel's
>    readhead isn't working properly.  Could you experiment
>    with this some more?  For example, what happens with
>
>         dd if=large_file of=/dev/null bs=4096k
>
> -
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


--------------098368129F88303742EEE513--

