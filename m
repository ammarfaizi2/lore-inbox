Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270688AbTHAHnA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 03:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270689AbTHAHnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 03:43:00 -0400
Received: from fmr05.intel.com ([134.134.136.6]:60632 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S270688AbTHAHm5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 03:42:57 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [vfat]incompatible dirent structure between user space and kernel space?
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Date: Fri, 1 Aug 2003 15:42:54 +0800
Message-ID: <571ACEFD467F7749BC50E0A98C17CDD8F327A2@pdsmsx403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [vfat]incompatible dirent structure between user space and kernel space?
Thread-Index: AcNYAIPhoig/btWLSHGkpEfglvOZ2g==
From: "Tian, Kevin" <kevin.tian@intel.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 01 Aug 2003 07:42:55.0011 (UTC) FILETIME=[84F09730:01C35800]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all,
	I tried to invoke vfat's ioctl to read directory information on
some vfat file system. However I found the returned information shifted
by 1 byte. I mean:

Expected: 	initrd~1.img
Actual:	nitrd~1.img

	The biggest problem is the structure dirent, which in kernel is:
Struct dirent{
	Long			d_ino;
	__kernel_off_t	d_off;
	unsigned short	d_reclen;
	char			d_name[256];
};
	However in user space, /usr/include/bits/dirent.h:
...
	unsigned short int d_reclen;
	unsigned char	d_type; ******
	char d_name[256];
};

	The d_type is the point here. Then has anybody encountered same
problem? I confirmed this problem existing both in kernel 2.6.0-test1(RH
as2.1/Itanium/Tiger) and kernel 2.4.18-14(RedHat Linux 8.0 3.2-7). 

	Also a problem confusing me is that I only include <dirent.h> in
my test file and there is no explicit reference to <bits/dirent.h> in
/usr/include/dirent.h. How could <bits/dirent.h> replace my inclusion of
<dirent.h>? In fact, the definition of dirent in <dirent.h> is same as
one in kernel space.

Thanks,
Kevin
