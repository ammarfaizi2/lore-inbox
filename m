Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313262AbSC1VVr>; Thu, 28 Mar 2002 16:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313261AbSC1VVi>; Thu, 28 Mar 2002 16:21:38 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:7440 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S313262AbSC1VV2>; Thu, 28 Mar 2002 16:21:28 -0500
Date: Thu, 28 Mar 2002 16:19:11 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Chris Wright <chris@wirex.com>
cc: Stephen Baker <stbaker@cisco.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Patch; setpriority
In-Reply-To: <20020327143231.A19240@figure1.int.wirex.com>
Message-ID: <Pine.LNX.3.96.1020328161615.18779D-200000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1170656797-873103368-1017350351=:18779"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1170656797-873103368-1017350351=:18779
Content-Type: TEXT/PLAIN; charset=US-ASCII

  Rather than expect people who have been following this to reread I'll
put this here. I believe the capability of nice(2) setting and restoring
is (a) very seldom useful given the new scheduler, and (b) can be done
with a bit of effort and no assult on SUS by doing the nice work in a nice
thread. 

  Code is attached.

On Wed, 27 Mar 2002, Chris Wright wrote:

> * Stephen Baker (stbaker@cisco.com) wrote:
> > 
> > This patch will allow a process or thread to changes it's priority 
> > dynamically based on it's capabilities.  In our case we wanted to use 
> > threads with Linux.  To have true priorities we need root to use 
> > SCHED_FIFO or SCHED_RR; in many case root access is not allowed but we 
> > still wanted priorities.  So we started using setpriority to change a 
> > threads priority.  Now we used nice values from 19 to 0 which did not 
> > require root access.  In some cases a thread need to raise it's nice 
> > level and this would fail.  I also saw a note man renice(8) that said 
> > this bug exists.
> 
> hmm, SUS v3 seems to disagree.
> 
> "Only a process with appropriate privileges can lower its nice value."
> 
> and with this patch setpriority(2) is now inconsistent with nice(2)
> (albeit i don't know how much longer that interface will persist in arch
> independent portion of the kernel based on the comments surrounding it).

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

--1170656797-873103368-1017350351=:18779
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="nice.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.3.96.1020328161911.18779E@gatekeeper.tmr.com>
Content-Description: 

LyogdHJ5IGNoYW5naW5nIG5pY2UoMikgZm9yIGEgc2luZ2xlIHRocmVhZCAq
Lw0KDQojaW5jbHVkZSA8c3RkaW8uaD4NCiNpbmNsdWRlIDx1bmlzdGQuaD4N
CiNpbmNsdWRlIDxwdGhyZWFkLmg+DQoNCmludCBwaWQ7DQp2b2lkIHBhcnQx
KGludCAqKTsNCnB0aHJlYWRfbXV0ZXhfdCBwcmludF9sb2NrID0gUFRIUkVB
RF9NVVRFWF9JTklUSUFMSVpFUjsNCiNkZWZpbmUgTUFYX0xPT1AJCTEwMA0K
DQptYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pDQp7DQoJaW50IGosIHN0
YXQ7DQoJdm9sYXRpbGUgaW50IGkgPSAwOw0KCXB0aHJlYWRfdCB0aHJkMTsN
Cg0KCXBpZCA9IGdldHBpZCgpOw0KCWZwcmludGYoc3RkZXJyLCAicGFyZW50
IHBpZDogJWRcbiIsIHBpZCk7DQoJcHRocmVhZF9jcmVhdGUoJnRocmQxLCBO
VUxMLCAodm9pZCAqKXBhcnQxLCAodm9pZCAqKSZpKTsNCgkvKiBub3RlIHRo
YXQgSSBhbSBub3QgZG9pbmcgYSBkYW1uIHRoaW5nIGhlcmUgKi8NCglwdGhy
ZWFkX2pvaW4odGhyZDEsIE5VTEwpOw0KDQoJZnByaW50ZihzdGRlcnIsICJO
b3JtYWwgdGVybWluYXRpb25cbiIpOw0KCWV4aXQoMCk7DQp9DQoNCnZvaWQN
CnBhcnQxKGludCAqaXgpDQp7DQoJLyogZG8gb25lIHBzIGJlZm9yZSBuaWNl
KDIpIGNhbGwgKi8NCglzeXN0ZW0oInBzIGwiKTsNCgkvKiBub3cgYmUgbmlj
ZSBhbmQgdHJ5IGFnYWluICovDQoJZnByaW50ZihzdGRlcnIsICJcbi0tPiBu
aWNlXG4iKTsNCgluaWNlKDYpOw0KCXN5c3RlbSgicHMgbCIpOw0KfQ0K
--1170656797-873103368-1017350351=:18779--
