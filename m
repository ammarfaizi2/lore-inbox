Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265648AbUBJGBy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 01:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265649AbUBJGBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 01:01:54 -0500
Received: from pogehseh134.us.infonet.com ([207.209.118.134]:5575 "EHLO
	msu-ex01.corp.m-sys.com") by vger.kernel.org with ESMTP
	id S265648AbUBJGBx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 01:01:53 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: open() and mmap() from the driver
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Date: Mon, 9 Feb 2004 22:02:51 -0800
Message-ID: <97303ED3C472254E8888E5F74A78347130AC5C@msu-ex01.corp.m-sys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: open() and mmap() from the driver
Thread-Index: AcPvm1Mf1rN43JsURK6U5l/f9rq9hQ==
From: "Dmitry Shmidt" <DimitryS@m-sys.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I want to access file from the driver. 
In user application I can access file through the pointer with the help of:
----------------------------------------------------------------
 fd = open( "myfile", O_RDWR );
 myptr = mmap( NULL, mysize, PROT_READ + PROT_WRITE, MAP_SHARED, fd, 0 );
 ...
 msync( myptr, mysize, MS_SYNC );
 munmap( myptr, mysize );
-----------------------------------------------------------------
 
Generally speaking I can use:
-----------------------------------------------------------------
 filp_open(filename);
 vmalloc(filesize);
 kernel_read() in loop
 ... Do something with the image in memory ...
And then I can
 kernel_write() in loop
 filp_close();
 vfree();
-----------------------------------------------------------------
However, it will be much more convenient to use some kind of mmap()
equivalent for this purpose. Is it possible ?

Thanks,

Dmitry
