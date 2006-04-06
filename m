Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbWDFX4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWDFX4x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 19:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWDFX4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 19:56:52 -0400
Received: from bio3d.colorado.edu ([128.138.212.7]:24499 "EHLO
	bio3d.hvem.Colorado.EDU") by vger.kernel.org with ESMTP
	id S932234AbWDFX4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 19:56:52 -0400
Date: Thu, 6 Apr 2006 17:56:51 -0600 (MDT)
From: Toby Bereznak <brez@bio3d.colorado.edu>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: data corruption with NFS over udp w/kernel >= 2.6.15 (fwd)
Message-ID: <Pine.LNX.4.60.0604061755220.11600@bio3d.hvem.Colorado.EDU>
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY="657152-1599285622-1144358155=:25789"
Content-ID: <Pine.LNX.4.60.0604061515570.25789@bio3d.hvem.Colorado.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--657152-1599285622-1144358155=:25789
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; FORMAT=flowed
Content-ID: <Pine.LNX.4.60.0604061515571.25789@bio3d.hvem.Colorado.EDU>



Linux-Kernel list,

I hope this bug report is adequate, as it is my first.

We started seeing these problems of data corruption while copying data over the 
network when the network was busy.  We mount drives over nfs with udp on our 
Gigabit network.

brez@cyclops writetest$ cat /etc/exports
/localscratch   @hvem(rw,no_root_squash,insecure,async)

We mount cyclops:/localscratch with the following options:
soft or hard,intr,timeo=10,retrans=100,rsize=65536,wsize=65536,nfsvers=3
cyclops:/localscratch

then run 'copytest <filename> s' in a directory on that mounted 
filesystem.  txt files and binary files both error, but the file should be 
of substantial size:  >100K.

We have data corruption in files that are copied over the network; and this 
problem arises when the client is running kernel 2.6.15 or 2.6.16, but 2.6.14 
works just fine.  The server can be running 2.6.10, 2.6.14, or 2.6.15 and 
above.  It seems to be client dependent.  Our test can take up to 2 hours to 
fail when the network is under a light load, but it usually takes around 10 
minutes when the network load is high.


-NOTE that this problem IS remedied when mounting nfs over tcp, but we need the 
performance of nfs over udp.


I hope I have provided enough information but not too much. :)
I'm attaching the script used to test this problem, a test file to copy, and 
also the output from scripts/ver_linux.

Thanks!

-- 
Toby Bereznak
HVEM IT
MCDB, CU-Boulder
303-492-4537
--657152-1599285622-1144358155=:25789
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME=copytest
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.60.0604061515550.25789@bio3d.hvem.Colorado.EDU>
Content-Description: copytest script
Content-Disposition: ATTACHMENT; FILENAME=copytest

IyEvYmluL2NzaCAtZg0KIyBTY3JpcHQgdG8gdGVzdCBJL08gb24gMi42LjE1
IGtlcm5lbA0KIyBHaXZlIGl0IGZpbGVuYW1lIGFuZCBvcHRpb25hbCBhcmd1
bWVudCBzIHRvIHN0b3Agb24gZXJyb3INCg0Kbm9odXANCg0Kc2V0IHN0b3Ag
PSAwDQpzZXQgZmlsZSA9ICRhcmd2WzFdDQppZiAoJCNhcmd2ID4gMSkgdGhl
bg0KICAgIGlmICgkYXJndlsyXSA9PSAncycpIHNldCBzdG9wID0gMQ0KZW5k
aWYNCg0Kd2hpbGUgKDEpDQogICAgXGNwICRmaWxlICRmaWxlLmNvcHkNCiAg
ICBkaWZmICRmaWxlICRmaWxlLmNvcHkNCg0KICAgIGlmICgkc3RhdHVzKSB0
aGVuDQogICAgICAgIGVjaG8gIkVSUk9SIEFUICAgImBkYXRlYA0KICAgICAg
ICBpZiAoJHN0b3ApIGV4aXQgMQ0KICAgIGVuZGlmDQplbmQNCg==

--657152-1599285622-1144358155=:25789
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="ver_linux.out"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.60.0604061515551.25789@bio3d.hvem.Colorado.EDU>
Content-Description: output from ver_linux
Content-Disposition: ATTACHMENT; FILENAME="ver_linux.out"

SWYgc29tZSBmaWVsZHMgYXJlIGVtcHR5IG9yIGxvb2sgdW51c3VhbCB5b3Ug
bWF5IGhhdmUgYW4gb2xkIHZlcnNpb24uDQpDb21wYXJlIHRvIHRoZSBjdXJy
ZW50IG1pbmltYWwgcmVxdWlyZW1lbnRzIGluIERvY3VtZW50YXRpb24vQ2hh
bmdlcy4NCiANCkxpbnV4IGdvbmRvbGluLmh2ZW0uY29sb3JhZG8uZWR1IDIu
Ni4xNi0xLjIwNjlfRkM0ICMxIFR1ZSBNYXIgMjggMTI6MTk6MTAgRVNUIDIw
MDYgaTY4NiBpNjg2IGkzODYgR05VL0xpbnV4DQogDQpHbnUgQyAgICAgICAg
ICAgICAgICAgIDQuMC4wDQpHbnUgbWFrZSAgICAgICAgICAgICAgIDMuODAN
CmJpbnV0aWxzICAgICAgICAgICAgICAgMi4xNS45NC4wLjIuMg0KdXRpbC1s
aW51eCAgICAgICAgICAgICAyLjEycA0KbW91bnQgICAgICAgICAgICAgICAg
ICAyLjEycA0KbW9kdWxlLWluaXQtdG9vbHMgICAgICAzLjENCmUyZnNwcm9n
cyAgICAgICAgICAgICAgMS4zNw0KcmVpc2VyZnNwcm9ncyAgICAgICAgICBs
aW5lDQpyZWlzZXI0cHJvZ3MgICAgICAgICAgIGxpbmUNCnBjbWNpYS1jcyAg
ICAgICAgICAgICAgMy4yLjgNCnF1b3RhLXRvb2xzICAgICAgICAgICAgMy4x
Mi4NClBQUCAgICAgICAgICAgICAgICAgICAgMi40LjINCm5mcy11dGlscyAg
ICAgICAgICAgICAgMS4wLjcNCkxpbnV4IEMgTGlicmFyeSAgICAgICAgMi4z
LjUNCkR5bmFtaWMgbGlua2VyIChsZGQpICAgMi4zLjUNClByb2NwcyAgICAg
ICAgICAgICAgICAgMy4yLjUNCk5ldC10b29scyAgICAgICAgICAgICAgMS42
MA0KS2JkICAgICAgICAgICAgICAgICAgICAxLjEyDQpTaC11dGlscyAgICAg
ICAgICAgICAgIDUuMi4xDQp1ZGV2ICAgICAgICAgICAgICAgICAgIDA1OA0K
TW9kdWxlcyBMb2FkZWQgICAgICAgICBuZnMgbG9ja2QgbmZzX2FjbCBwYXJw
b3J0X3BjIGxwIHBhcnBvcnQgYXV0b2ZzNCByZmNvbW0gbDJjYXAgYmx1ZXRv
b3RoIHN1bnJwYyBkbV9tb2QgdmlkZW8gYnV0dG9uIGJhdHRlcnkgYWMgaXB2
NiB1aGNpX2hjZCBod19yYW5kb20gaTJjX2k4MDEgaTJjX2NvcmUgc25kX2Vu
czEzNzEgZ2FtZXBvcnQgc25kX3Jhd21pZGkgc25kX2FjOTdfY29kZWMgc25k
X2FjOTdfYnVzIHNuZF9zZXFfZHVtbXkgc25kX3NlcV9vc3Mgc25kX3NlcV9t
aWRpX2V2ZW50IHNuZF9zZXEgc25kX3NlcV9kZXZpY2Ugc25kX3BjbV9vc3Mg
c25kX21peGVyX29zcyBzbmRfcGNtIHNuZF90aW1lciBzbmQgc291bmRjb3Jl
IHNuZF9wYWdlX2FsbG9jIGRtZmUgZmxvcHB5IGV4dDMgamJkDQo=

--657152-1599285622-1144358155=:25789--
