Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbTIOTof (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 15:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbTIOTof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 15:44:35 -0400
Received: from keetweej.xs4all.nl ([213.84.46.114]:5311 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S261485AbTIOTod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 15:44:33 -0400
From: Folkert van Heusden <folkert@vanheusden.com>
Reply-To: folkert@vanheusden.com
Organization: vanheusdendotcom
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0test-1 error while writing files to loopback UDF filesystem UDF-fs DEBUG fs/udf/balloc.c:192:udf_ still with 2.6.0-test4!
Date: Mon, 15 Sep 2003 21:44:31 +0200
User-Agent: KMail/1.5.3
References: <200309140032.15116.folkert@vanheusden.com>
In-Reply-To: <200309140032.15116.folkert@vanheusden.com>
WebSite: http://www.vanheusden.com/
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309152144.31238.folkert@vanheusden.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just retested it with 2.6.0-test4.
This time, the kernel did *NOT* log any of the messages as it did with test1,
BUT: if I compare the original with the new file, I get differences all over
the place.

So what I did was (just in case):

# create backup image
truncate /data2/backup.udf 4294967296
mkudffs /data2/backup.udf

# mount it & copy data
mount -o loop -t udf /data2/backup.udf /mnt
(cd /data/backup/Backup ; tar cf - *) | (cd /mnt ; tar xvf -)
umount /mnt

# verify things
mount -o loop -t udf /data2/backup.udf /mnt
cd /mnt
find . -type f |xargs -n 1 ./docmp

docmp is:
--------
echo $1
cmp -l /mnt/$1 /data/backup/Backup/$1

On Sunday 14 September 2003 00:32, Folkert van Heusden wrote:
> Hi,
> I created an UDF filesystem (dd of=file if=... && mkudffs file && mount -o
> loop -t udf /mnt) and then added some files to it (tar cf - * | (cd /mnt ;
> tar xvpf -)).
> That went well for a while, but after aprox 2GB (beware: no file was longer
> then +/- 1GB), I got these errors in syslog:
> Sep 14 00:04:38 boemboem kernel: UDF-fs DEBUG fs/udf/balloc.c:192:udf_
> bitmap_free_blocks: bit 3125 already set
> Sep 14 00:04:38 boemboem kernel: UDF-fs DEBUG fs/udf/balloc.c:193:udf_
> bitmap_free_blocks: byte=20
> Sep 14 00:04:38 boemboem kernel: UDF-fs DEBUG fs/udf/balloc.c:192:udf_
> bitmap_free_blocks: bit 3125 already set
> Sep 14 00:04:38 boemboem kernel: UDF-fs DEBUG fs/udf/balloc.c:193:udf_
> bitmap_free_blocks: byte=60
> etc.
> I then did a compare (cmp -l) and found that the copied file was different
> from the original one, so it seems something is going wrong while writing
> to the UDF filesystem.
> As I wrote in the subjectline, I'm using 2.6.0-test1.


Folkert van Heusden

p.s.: truncate is an utility which is available on most BSD systems (not mac
      os x which is a BSD). I wrote a version for linux: 
      http://vanheusden.com/Linux/truncate-0.1.tgz (64bit safe)

+--------------------------------------------------------------------------+
| UNIX sysop? Then give MultiTail ( http://www.vanheusden.com/multitail/ ) |
| a try, it brings monitoring logfiles (and such) to a different level!    |
+---------------------------------------------------= www.vanheusden.com =-+

