Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264973AbTFCLgu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 07:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264975AbTFCLgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 07:36:50 -0400
Received: from pat.uio.no ([129.240.130.16]:48016 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264973AbTFCLgt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 07:36:49 -0400
From: Terje Malmedal <terje.malmedal@usit.uio.no>
To: Alexander Hoogerhuis <alexh@ihatent.com>
Cc: Oliver Neukum <oliver@neukum.org>, David Brownell <david-b@pacbell.net>,
       linux-kernel@vger.kernel.org
Subject: Re: USB 2.0 with 250Gb disk and insane loads
References: <3EDA0E5D.8080404@pacbell.net>
	<200306011653.47958.oliver@neukum.org>
	<87k7c5g738.fsf@lapper.ihatent.com>
MIME-Version: 1.0
Message-Id: <E19NAIA-0005cD-00@aqualene.uio.no>
Date: Tue, 3 Jun 2003 13:49:26 +0200
X-MailScanner-Information: Please contact postmaster@uio.no for more information
X-UiO-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Alexander Hoogerhuis]
> Stuck it in an older machine on USB 1.1 and it foudn the disk fine
> (redhat 9, 2.4.20-13.9 kernel on that machine), and ditto result:

> 19:15:16  up 2 days, 20:23,  4 users,  load average: 6.02, 2.41, 0.89
> 58 processes: 55 sleeping, 3 running, 0 zombie, 0 stopped
> CPU states:   0.2% user   4.0% system   0.0% nice   0.0% iowait  95.8% idle
> Mem:   385040k av,  380820k used,    4220k free,       0k shrd,   67368k buff
>        224720k active,              69412k inactive
> Swap:  521632k av,      80k used,  521552k free                  237452k cached
                                                                                
> and generating about 2500 interrupts for the usb controller per 10
> seconds and when i finally break it off and give it "sync" it uses
> about two minutes with about 4500 per 10 seconds to get it all on
> disk. On 2.4 the machine becomes more and more sluggish if I let it
> go more than a short minute.

I had the same problem with USB 1.1. I solved it by writing a
LD_PRELOAD-able shared library which overrides write() to do a
fdatasync() on the filehandle after a megabyte worth of writes.

Would be nice to have it fixed in the kernel though.

-- 
 - Terje
malmedal@usit.uio.no
