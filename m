Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267818AbUH1Avg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267818AbUH1Avg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 20:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268010AbUH1Aux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 20:50:53 -0400
Received: from ntmail.xtreamlok.com ([203.20.243.135]:46013 "EHLO
	ntmail.xtreamlok.com") by vger.kernel.org with ESMTP
	id S267818AbUH1Auq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 20:50:46 -0400
Message-ID: <412FD751.9070604@biodome.org>
Date: Sat, 28 Aug 2004 10:52:33 +1000
From: QuantumG <qg@biodome.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.1) Gecko/20040707
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: reverse engineering pwcx
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Aug 2004 00:52:36.0004 (UTC) FILETIME=[4F35FE40:01C48C99]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Having watched the discussion around pwcx since the first posting, I 
thought I would take a look at libpwcx.a.  It consists of 3 .o files 
each containing full symbol information and in total a *very* small 
amount of code.  There is no secret algorithm or complex image 
processing in this code.  Having worked on reverse engineering a complex 
audio processing application (see our paper Using a Decompiler for 
Real-World Source Recovery, to appear WCRE 2004), I expected to see some 
serious floating point calculations or at least something recognisable 
as a FFT or some other known algorithm.  There is none of this in the 
pwcx driver.   I could provide complete decompiled source code for this 
binary, however due to the legal questions I'd rather just say that 
there is really not a lot of effort required here to black box this 
driver and replicate what it is doing.  The biggest job will be 
deciphering the two or three large tables used in the decompression 
operations.

The specific issue of pwcx dealt with I'd really like to ask why 
companies perfer to release binary drivers over open source drivers.  A 
Linux kernel driver is really easy to decompile.  There's a number of 
factors that make this so, especially the large amount of symbols 
generally left in binary drivers, but mainly the fact that kernel 
drivers are by design small contained pieces of code.  Also, they are 
generally written in straight C with the only function pointers being 
well documented interfaces (and the function pointers are not changed 
dynamically).  Compared to say, a win32 application written in C++ with 
all that stdcall/fastcall stuff, a linux kernel module is a joy to 
decompile.  So why bother releasing a binary only driver?  The company 
is not protecting its intellectual property.  If an amature like me, who 
knows nothing about web cams, can understand this driver than surely 
someone at one of Philips' competitors reverse engineered and understood 
this algorithm within weeks of the drivers for this camera hitting the 
market.  I'm sure Philips' knows this so why force Nemosoft to sign an 
NDA?  And more importantly, why not let the community maintain this driver?

Trent Waddington
Decompiler maintainer, http://boomerang.sourceforge.net/

