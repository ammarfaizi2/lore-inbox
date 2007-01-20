Return-Path: <linux-kernel-owner+w=401wt.eu-S965329AbXATRxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965329AbXATRxF (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 12:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965337AbXATRxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 12:53:05 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:58099 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965329AbXATRxD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 12:53:03 -0500
From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Organization: TUBITAK/UEKAE
To: Willy Tarreau <w@1wt.eu>
Subject: Re: Abysmal disk performance, how to debug?
Date: Sat, 20 Jan 2007 19:52:53 +0200
User-Agent: KMail/1.9.5
References: <200701201920.54620.ismail@pardus.org.tr> <20070120174503.GZ24090@1wt.eu>
In-Reply-To: <20070120174503.GZ24090@1wt.eu>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200701201952.54714.ismail@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

20 Oca 2007 Cts 19:45 tarihinde şunları yazmıştınız:
[...]
> > vaio cartman # hdparm -tT /dev/hda
> >
> > /dev/hda:
> >  Timing cached reads:   1576 MB in  2.00 seconds = 788.18 MB/sec
> >  Timing buffered disk reads:   74 MB in  3.01 seconds =  24.55 MB/sec
> >
> >
> > [~]> time dd if=/dev/zero of=/tmp/1GB bs=1M count=1024
> > 1024+0 records in
> > 1024+0 records out
> > 1073741824 bytes (1,1 GB) copied, 77,2809 s, 13,9 MB/s
> >
> > real    1m17.482s
> > user    0m0.003s
> > sys     0m2.350s
>
> That's not bad at all ! I suspect that if your system becomes unresponsive,
> it's because real writes start when the cache is full. And if you fill
> 512 MB of RAM with data that you then need to flush on disk at 14 MB/s, it
> can take about 40 seconds during which it might be difficult to do
> anything.
>
> Try lowering the cache flush starting point to about 10 MB if you want
> (2% of 512 MB) :
>
> # echo 2 >/proc/sys/vm/dirty_ratio
> # echo 2 >/proc/sys/vm/dirty_background_ratio

After that I get,

[~]>  time dd if=/dev/zero of=/tmp/1GB bs=1M count=1024
1024+0 records in
1024+0 records out
1073741824 bytes (1,1 GB) copied, 41,7005 s, 25,7 MB/s

real    0m41.926s
user    0m0.007s
sys     0m2.500s


not bad! thanks :)

Regards,
ismail
