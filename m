Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271862AbRHUUeZ>; Tue, 21 Aug 2001 16:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271861AbRHUUeP>; Tue, 21 Aug 2001 16:34:15 -0400
Received: from [24.130.1.20] ([24.130.1.20]:37554 "EHLO
	lsmls01.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S271860AbRHUUeC>; Tue, 21 Aug 2001 16:34:02 -0400
Message-ID: <3B82C7F2.43A60829@kegel.com>
Date: Tue, 21 Aug 2001 13:43:30 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: socket connected to itself with RH 2.2.14-5.0? (Problem with example 
 from Stevens)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been fooling around with porting 
the example programs from Richard Stevens' 
"Unix Network Programming, Volume 1, 2nd edition"
to Linux.  The patches I've come up with so far, along with
instructions for reproducing my results, are
available at http://www.kegel.com/unpv1/
My goal is to reproduce the results in table 27-1.

Along the way, I have been running both server and client on
the same machine (it's easier to script that way for testing).
Oddly, on Red Hat 6.2, the client often hangs within a minute or two.
Poking around a bit shows that the client is blocked in read.
OK so far, that could be a bug in the program or how I'm using it.

The interesting bit is that (after you wait long enough for other
activity to finish up) all threads of the server are serenely 
sitting in accept(), knowing nothing about the client supposedly connected to it.
Curiously, netstat -pant | grep 127.0.0.1  shows just

tcp        0      0 127.0.0.1:2003          127.0.0.1:2003          ESTABLISHED 965/client 

Erm, could the client have connected to *itself* somehow?

Doesn't happen with Red Hat 7.1.  I am now compiling vanilla 2.2.19 to see
if that fixes it, too.

(I seem to have a knack for triggering this kind of thing.  ucd-snmp/snmpget
used to crash if you had it query itself :-)

- Dan

-- 
"I have seen the future, and it licks itself clean." -- Bucky Katt
