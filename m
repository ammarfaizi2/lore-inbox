Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266976AbTBQQGb>; Mon, 17 Feb 2003 11:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267124AbTBQQGb>; Mon, 17 Feb 2003 11:06:31 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:1952 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266976AbTBQQGa>;
	Mon, 17 Feb 2003 11:06:30 -0500
Subject: [PATCH] BUG() call in vmalloc.c causes segmentation fault.
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 6.0 September 26, 2002
Message-ID: <OFA9B848ED.44B251A9-ON85256CD0.0058C89E-86256CD0.0059C5EC@pok.ibm.com>
From: "Robert Williamson" <robbiew@us.ibm.com>
Date: Mon, 17 Feb 2003 11:16:20 -0500
X-MIMETrack: Serialize by Router on D01ML076/01/M/IBM(Release 5.0.11 +SPRs MIAS5EXFG4, MIAS5AUFPV
 and DHAG4Y6R7W, MATTEST |November 8th, 2002) at 02/17/2003 11:16:23 AM
MIME-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=0ABBE643DFCB4E0E8f9e8a93df938690918c0ABBE643DFCB4E0E"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0__=0ABBE643DFCB4E0E8f9e8a93df938690918c0ABBE643DFCB4E0E
Content-type: text/plain; charset=us-ascii


In the function __vmalloc() in mm/vmalloc.c. The function
is parsing the "size" parameter passed to it. If the request
is of zero bytes or if it is greater than num_physpages,
then __vmalloc calls BUG(). The NULL pointer is never
returned, which causes the segmentation fault.  This BUG()
call was correctly removed for 2.5.

- Robbie

(See attached file: vmalloc.c.patch)

Robert V. Williamson <robbiew@us.ibm.com>
Linux Test Project
IBM Linux Technology Center
Phone: (512) 838-9295   T/L: 678-9295
Fax: (512) 838-4603
Web: http://ltp.sourceforge.net
IRC: #ltp on freenode.irc.net
====================
"Only two things are infinite, the universe and human stupidity, and I'm
not sure about the former." -Albert Einstein

--0__=0ABBE643DFCB4E0E8f9e8a93df938690918c0ABBE643DFCB4E0E
Content-type: application/octet-stream; 
	name="vmalloc.c.patch"
Content-Disposition: attachment; filename="vmalloc.c.patch"
Content-transfer-encoding: base64

SW5kZXg6IGZzL2xvY2tzLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbW0vdm1hbGxvYy5jCVRodSBOb3YgMjgg
MTc6NTM6MTUgMjAwMgorKysgbW0vdm1hbGxvYy5jLm5ldwlNb24gRmViIDE3IDExOjAzOjM4IDIw
MDMKQEAgLTIzOSw3ICsyMzksNiBAQAogCiAJc2l6ZSA9IFBBR0VfQUxJR04oc2l6ZSk7CiAJaWYg
KCFzaXplIHx8IChzaXplID4+IFBBR0VfU0hJRlQpID4gbnVtX3BoeXNwYWdlcykgewotCQlCVUco
KTsKIAkJcmV0dXJuIE5VTEw7CiAJfQogCWFyZWEgPSBnZXRfdm1fYXJlYShzaXplLCBWTV9BTExP
Qyk7Cg==

--0__=0ABBE643DFCB4E0E8f9e8a93df938690918c0ABBE643DFCB4E0E--

