Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279913AbRKIPEK>; Fri, 9 Nov 2001 10:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279920AbRKIPEB>; Fri, 9 Nov 2001 10:04:01 -0500
Received: from pop.ewave.at ([62.173.128.67]:64266 "HELO mail.ewave.at")
	by vger.kernel.org with SMTP id <S279913AbRKIPDw>;
	Fri, 9 Nov 2001 10:03:52 -0500
Message-ID: <3BEBF13A.1030505@ewave.at>
Date: Fri, 09 Nov 2001 16:07:38 +0100
From: atze <atze-lists@ewave.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: de-at, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: mke2fs hangs ?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hy!
maybe i'm a little bit off-topic but a had no other idea where to post 
my prob.
i built a kickstart disk myself, using the 2.4.8 kernel, ramdisk, 
whatever, and everythings running wuite fine indeed.

my only problem is this: when executine the script below to initiate the 
hard disks, the script hangs. right after sfdisk partitioned the disk 
with the data from its input file, mke2fs shows it initial line (mke2fs 
1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09) and then stops.
to go on with the script one has to press any key, shift, tab, caps, 
whatever..

anyone has a clue what could cause that behaviour ?

thx to all
thomas

#!/bin/sh
export PATH=/bin:/usr/bin:/usr/sbin

DS=`sfdisk -s /dev/hda`

echo -n "partitioning /dev/hda..."

if [ $DS -gt 500000 -a $DS -lt 1000000 ]; then
        PT="min";
elif [ $DS -gt 1000000 -a $DS -lt 7000000 ]; then
        PT="mid";
elif [ $DS -gt 7000000 ]; then
        PT="max";
else
        echo "too small";
        exit 1;
fi

echo $PT

sfdisk -uM /dev/hda < /etc/inst/partitions.$PT 1>/dev/null 2>&1

mke2fs -q -c /dev/hda5 -L "/"
mke2fs -q -c -b 1024 /dev/hda1 -l "/boot"

if [ $PT = "max" ]; then
        mke2fs /dev/hda6 -q -L "/root";
        mke2fs /dev/hda7 -q -L "/tmp";
        mke2fs /dev/hda8 -q -L "/var";
elif [ $PT = "mid" ]; then
        mke2fs /dev/hda6 -q -L "/tmp";
        mke2fs /dev/hda7 -q -L "/var";
elif [ $PT = "min" ]; then
        mke2fs /dev/hda6 -q -L "/var";
fi


