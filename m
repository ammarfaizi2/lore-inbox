Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130793AbRDCJyW>; Tue, 3 Apr 2001 05:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130940AbRDCJyL>; Tue, 3 Apr 2001 05:54:11 -0400
Received: from swan.prod.itd.earthlink.net ([207.217.120.123]:50102 "EHLO
	swan.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S130793AbRDCJx5>; Tue, 3 Apr 2001 05:53:57 -0400
Date: Tue, 3 Apr 2001 01:53:26 -0700
From: Allen Ashley <ashley@alumni.caltech.edu>
Message-Id: <200104030853.BAA00238@aa.home.org>
To: linux-kernel@vger.kernel.org
Subject: 2.2.15 kernel bug report
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am enclosing a section of code that crashes the 2.2.15 kernel
repeatedly. My system is a 266 Intel P2 with 128Mb ram. The
crash is caused by the connect statement. It does not crash
if the socket is in BLOCKING mode. My distribution is Slack 7.0
if that matters.

---------------------------------------------------------------
soval=fcntl(s,F_GETFL,0);
ioval=fcntl(0,F_GETFL,0);
fcntl(s,F_SETFL,soval|O_NONBLOCK);
fcntl(0,F_SETFL,ioval|O_NONBLOCK);
cwait=WAITCONNECT;
*chin=0;
do{
/*If the following line is commented out the program does not crash*/
	rval=connect(s, (struct sockaddr *)&dst, sizeof(dst));
	read(0,chin,16);
	sleep(1);
	} while((rval) && --cwait && *chin!=0xa);
fcntl(s,F_SETFL,soval&~O_NONBLOCK);
fcntl(0,F_SETFL,ioval&~O_NONBLOCK);
---------------------------------------------------------------
