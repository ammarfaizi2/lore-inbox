Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265154AbTLaPqO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 10:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265156AbTLaPqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 10:46:14 -0500
Received: from rat-5.inet.it ([213.92.5.95]:57219 "EHLO rat-5.inet.it")
	by vger.kernel.org with ESMTP id S265154AbTLaPqH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 10:46:07 -0500
From: Paolo Ornati <ornati@lycos.it>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.6.1-rc1 [resend]
Date: Wed, 31 Dec 2003 16:45:23 +0100
User-Agent: KMail/1.5.2
References: <Pine.LNX.4.58.0312310033110.30995@home.osdl.org> <200312311619.27812.ornati@lycos.it> <20031231152052.GR27687@holomorphy.com>
In-Reply-To: <20031231152052.GR27687@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312311645.23348.ornati@lycos.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 December 2003 16:20, you wrote:
> On Wednesday 31 December 2003 16:06, you wrote:
> >> What io scheduler are you using? Or, could you post /var/log/dmesg?
>
> On Wed, Dec 31, 2003 at 04:19:27PM +0100, Paolo Ornati wrote:
> > "dmesg" and "config" attached.
>
> Could you try this with elevator=deadline?

ok, I have just tried...
I don't see any big difference.

The output of this script:
_________________________________________________
#!/bin/bash

echo "HD test for linux `uname -r`"
echo

ra=8
for i in `seq 7`; do
    echo "READAHEAD = $ra";
    hdparm -a $ra /dev/hda;
    for j in `seq 3`; do
	hdparm -t /dev/hda;
    done;
    ra=$(($ra*2));
done
_________________________________________________

is:
_________________________________________________
HD test for linux 2.6.1-rc1

READAHEAD = 8

/dev/hda:
 setting fs readahead to 8
 readahead    =  8 (on)

/dev/hda:
 Timing buffered disk reads:  64 MB in  4.79 seconds = 13.37 MB/sec

/dev/hda:
 Timing buffered disk reads:  64 MB in  4.79 seconds = 13.36 MB/sec

/dev/hda:
 Timing buffered disk reads:  64 MB in  4.79 seconds = 13.37 MB/sec
READAHEAD = 16

/dev/hda:
 setting fs readahead to 16
 readahead    = 16 (on)

/dev/hda:
 Timing buffered disk reads:  64 MB in  2.48 seconds = 25.80 MB/sec

/dev/hda:
 Timing buffered disk reads:  64 MB in  2.45 seconds = 26.14 MB/sec

/dev/hda:
 Timing buffered disk reads:  64 MB in  2.43 seconds = 26.30 MB/sec
READAHEAD = 32

/dev/hda:
 setting fs readahead to 32
 readahead    = 32 (on)

/dev/hda:
 Timing buffered disk reads:  64 MB in  2.44 seconds = 26.23 MB/sec

/dev/hda:
 Timing buffered disk reads:  64 MB in  2.43 seconds = 26.32 MB/sec

/dev/hda:
 Timing buffered disk reads:  64 MB in  2.44 seconds = 26.27 MB/sec
READAHEAD = 64

/dev/hda:
 setting fs readahead to 64
 readahead    = 64 (on)

/dev/hda:
 Timing buffered disk reads:  64 MB in  2.43 seconds = 26.38 MB/sec

/dev/hda:
 Timing buffered disk reads:  64 MB in  2.44 seconds = 26.27 MB/sec

/dev/hda:
 Timing buffered disk reads:  64 MB in  2.43 seconds = 26.36 MB/sec
READAHEAD = 128

/dev/hda:
 setting fs readahead to 128
 readahead    = 128 (on)

/dev/hda:
 Timing buffered disk reads:  64 MB in  2.43 seconds = 26.33 MB/sec

/dev/hda:
 Timing buffered disk reads:  64 MB in  2.44 seconds = 26.20 MB/sec

/dev/hda:
 Timing buffered disk reads:  64 MB in  2.42 seconds = 26.40 MB/sec
READAHEAD = 256

/dev/hda:
 setting fs readahead to 256
 readahead    = 256 (on)

/dev/hda:
 Timing buffered disk reads:  64 MB in  2.41 seconds = 26.56 MB/sec

/dev/hda:
 Timing buffered disk reads:  64 MB in  2.41 seconds = 26.55 MB/sec

/dev/hda:
 Timing buffered disk reads:  64 MB in  2.41 seconds = 26.54 MB/sec
READAHEAD = 512

/dev/hda:
 setting fs readahead to 512
 readahead    = 512 (on)

/dev/hda:
 Timing buffered disk reads:  64 MB in  2.41 seconds = 26.52 MB/sec

/dev/hda:
 Timing buffered disk reads:  64 MB in  2.40 seconds = 26.67 MB/sec

/dev/hda:
 Timing buffered disk reads:  64 MB in  2.41 seconds = 26.54 MB/sec
_________________________________________________

>
>
> -- wli

-- 
	Paolo Ornati
	Linux v2.6.1-rc1

