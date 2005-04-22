Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262136AbVDVVPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbVDVVPe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 17:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbVDVVPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 17:15:33 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:15098 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S262137AbVDVVPL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 17:15:11 -0400
Date: Fri, 22 Apr 2005 14:15:04 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Inaky Perez-Gonzalez <inaky@linux.intel.com>
cc: Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc3-V0.7.46-01
In-Reply-To: <17001.26444.246648.14231@sodium.jf.intel.com>
Message-ID: <Pine.LNX.4.44.0504221410530.4768-200000@dhcp153.mvista.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="694538-657609749-1114204504=:4857"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--694538-657609749-1114204504=:4857
Content-Type: TEXT/PLAIN; charset=US-ASCII

t
On Fri, 22 Apr 2005, Inaky Perez-Gonzalez wrote:

> >>>>> Ingo Molnar <mingo@elte.hu> writes:
> 
> >> this includes fixes from Daniel Walker, which could fix the plist
> >> related slowdown bugs:
> 
> > there are still some problems remaining: i just ran Esben Nielsen's
> > priority-inheritance validation testsuite, and the plist code gives
> > a worst-case latency of 9.0 msecs.
> 
> With which machine is this? 
> 
> I tried to reproduce with V0.7.45-01 in my 2xPIII 0.9 Ghz I cannot get
> more than 1.9ms when doing 2000 samples repeatedly (60 iterations and
> counting). 
> 
> Did you use other parameters to 'test'?
> 
> # cnt=0 
> # while true
> > do echo -n "$cnt "
> > ./test --samples 2000 file.hist 2>&1 | grep maximum; cnt=$(($cnt+1))
> > done
> 
> With 2.6.12-rc3-V0.7.46-02 I get:

It's still to high , it should be under a millisecond .. 

 
I'm still testing but the times get better with this patch . I was 
initializing the lists to 0, instead of MAX_INT . Let me know if it 
changes anything.


Daniel


--694538-657609749-1114204504=:4857
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="fix_pi_list_init.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0504221415040.4857@dhcp153.mvista.com>
Content-Description: 
Content-Disposition: attachment; filename="fix_pi_list_init.patch"

SW5kZXg6IGxpbnV4LTIuNi4xMS9pbmNsdWRlL2xpbnV4L3BsaXN0LmgNCj09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0NCi0tLSBsaW51eC0yLjYuMTEub3JpZy9p
bmNsdWRlL2xpbnV4L3BsaXN0LmgJMjAwNS0wNC0yMiAxOTozNjo1NC4wMDAw
MDAwMDAgKzAwMDANCisrKyBsaW51eC0yLjYuMTEvaW5jbHVkZS9saW51eC9w
bGlzdC5oCTIwMDUtMDQtMjIgMTk6Mzg6MjkuMDAwMDAwMDAwICswMDAwDQpA
QCAtMjUxLDcgKzI1MSw3IEBADQogc3RhdGljIGlubGluZSB2b2lkIHBsaXN0
X2RlbF9pbml0KHN0cnVjdCBwbGlzdCAqcGwsIHN0cnVjdCBwbGlzdCAqcGxp
c3QpDQogew0KICAgICAgICAgcGxpc3RfZGVsIChwbCwgcGxpc3QpOw0KLSAg
ICAgICAgcGxpc3RfaW5pdChwbCwgMCk7DQorICAgICAgICBwbGlzdF9pbml0
KHBsLCBJTlRfTUFYKTsNCiB9DQogDQogLyogUmV0dXJuIHRoZSBwcmlvcml0
eSBhIHBsIG5vZGUgKi8NCkluZGV4OiBsaW51eC0yLjYuMTEva2VybmVsL3J0
LmMNCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT0NCi0tLSBsaW51eC0yLjYuMTEu
b3JpZy9rZXJuZWwvcnQuYwkyMDA1LTA0LTIyIDE1OjA1OjMzLjAwMDAwMDAw
MCArMDAwMA0KKysrIGxpbnV4LTIuNi4xMS9rZXJuZWwvcnQuYwkyMDA1LTA0
LTIyIDE5OjM2OjI5LjAwMDAwMDAwMCArMDAwMA0KQEAgLTkzOSw2ICs5Mzks
NyBAQA0KIA0KIAlzZXRfdGFza19zdGF0ZSh0YXNrLCBUQVNLX1VOSU5URVJS
VVBUSUJMRSk7DQogDQorCXBsaXN0X2luaXQgKCZ3YWl0ZXIubGlzdCwgdGFz
ay0+cHJpbyk7DQogCXRhc2tfYmxvY2tzX29uX2xvY2soJndhaXRlciwgdGFz
aywgbG9jaywgZWlwKTsNCiANCiAJVFJBQ0VfQlVHX09OKCFpcnFzX2Rpc2Fi
bGVkKCkpOw0K
--694538-657609749-1114204504=:4857--
