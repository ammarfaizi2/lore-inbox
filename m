Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262229AbTIMWPm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 18:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbTIMWPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 18:15:42 -0400
Received: from keetweej.xs4all.nl ([213.84.46.114]:10435 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S262229AbTIMWPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 18:15:41 -0400
From: Folkert van Heusden <folkert@vanheusden.com>
Reply-To: folkert@vanheusden.com
Organization: vanheusdendotcom
To: linux-kernel@vger.kernel.org
Subject: 2.6.0test-1 error while writing files to loopback UDF filesystem UDF-fs DEBUG fs/udf/balloc.c:192:udf_
bitmap_free_blocks: bit 3128 already set
Date: Sun, 14 Sep 2003 00:15:40 +0200
User-Agent: KMail/1.5.3
WebSite: http://www.vanheusden.com/
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309140015.40063.folkert@vanheusden.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I created an UDF filesystem (dd of=file if=... && mkudffs file && mount -o 
loop -t udf /mnt) and then added some files to it (tar cf - * | (cd /mnt ; 
tar xvpf -)).
That went well for a while, but after aprox 2GB (beware: no file was longer 
then +/- 1GB), I got these errors in syslog:
Sep 14 00:04:38 boemboem kernel: UDF-fs DEBUG fs/udf/balloc.c:192:udf_
bitmap_free_blocks: bit 3125 already set
Sep 14 00:04:38 boemboem kernel: UDF-fs DEBUG fs/udf/balloc.c:193:udf_
bitmap_free_blocks: byte=20
Sep 14 00:04:38 boemboem kernel: UDF-fs DEBUG fs/udf/balloc.c:192:udf_
bitmap_free_blocks: bit 3125 already set
Sep 14 00:04:38 boemboem kernel: UDF-fs DEBUG fs/udf/balloc.c:193:udf_
bitmap_free_blocks: byte=60
etc.
I then did a compare (cmp -l) and found that the copied file was different 
from the original one, so it seems something is going wrong while writing to 
the UDF filesystem.
As I wrote in the subjectline, I'm using 2.6.0-test1.


Folkert van Heusden

+--------------------------------------------------------------------------+
| UNIX sysop? Then give MultiTail ( http://www.vanheusden.com/multitail/ ) |
| a try, it brings monitoring logfiles (and such) to a different level!    |
+---------------------------------------------------= www.vanheusden.com =-+

