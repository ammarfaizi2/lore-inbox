Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317564AbSFRTOY>; Tue, 18 Jun 2002 15:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317563AbSFRTNe>; Tue, 18 Jun 2002 15:13:34 -0400
Received: from mrelay1.cc.umr.edu ([131.151.1.120]:11180 "EHLO smtp.umr.edu")
	by vger.kernel.org with ESMTP id <S317564AbSFRTNT> convert rfc822-to-8bit;
	Tue, 18 Jun 2002 15:13:19 -0400
x-mimeole: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Behavior of exec wrt euid/ruid on 2.2 vs. 2.4 kernels
Date: Tue, 18 Jun 2002 14:13:19 -0500
Message-ID: <5958610EC585FA42B1CC3D20E216BE7018FAF6@umr-mail6.umr.edu>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Behavior of exec wrt euid/ruid on 2.2 vs. 2.4 kernels
Thread-Index: AcIW/DUUXcuVHoCZEda/OwBQVgAgFQ==
From: "Neulinger, Nathan" <nneul@umr.edu>
To: <Linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just noticed this today when I upgraded an older machine from 2.2.x to
2.4.18 that the behavior of exec changed with respect to how it handles
euid!=ruid.

Basically, on 2.4:
	setuid bin, execute it, ruid!=euid, exec another tool, now euid
is set to ruid

on 2.2 the execced binary retains the ruid!=euid.

I can see how this might have been done intentionally for security,
however, it does mean that it is impossible for a execced tool to know
the real uid that is running it if executed from a setuid wrapper, or to
run a helper tool (aklog) from a ruid!=euid process. 

Was this change in behavior intentional?

I never noticed it on any of our other 2.4.x systems, cause exec()'s
within setuid bin's without setresuid(geteuid(),geteuid(),geteuid()) are
pretty rare in our tools, most of them just have a single bin that does
whatever it needs to do. 

-- Nathan

------------------------------------------------------------
Nathan Neulinger                       EMail:  nneul@umr.edu
University of Missouri - Rolla         Phone: (573) 341-4841
Computing Services                       Fax: (573) 341-4216
