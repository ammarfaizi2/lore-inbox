Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319670AbSIMO41>; Fri, 13 Sep 2002 10:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319672AbSIMO41>; Fri, 13 Sep 2002 10:56:27 -0400
Received: from WebDev.iNES.RO ([194.105.18.49]:55168 "HELO webdev.ines.ro")
	by vger.kernel.org with SMTP id <S319670AbSIMO4Y>;
	Fri, 13 Sep 2002 10:56:24 -0400
Date: Fri, 13 Sep 2002 18:01:16 +0300 (EEST)
From: Andrei Ivanov <andrei.ivanov@ines.ro>
X-X-Sender: shadow@webdev.ines.ro
To: linux-kernel@vger.kernel.org
Subject: ingress rate limiting weirdness (?)
Message-ID: <Pine.LNX.4.44.0209131724060.6388-200000@webdev.ines.ro>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1774334226-839852540-1031929276=:6388"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1774334226-839852540-1031929276=:6388
Content-Type: TEXT/PLAIN; charset=US-ASCII


Hello,
I've been trying to rate limit my incomming connections, and, as I 
understand, I can do that only with ingress.
So I did a litle test:

tc qdisc add dev eth1 handle ffff: ingress
tc filter add dev eth1 protocol ip parent ffff: prio 50 u32 match ip src \
204.152.189.116 police rate 128kbit burst 10k drop flowid :1

tc qdisc list dev eth1
qdisc ingress ffff: ----------------

tc filter ls dev eth1 parent ffff:
filter protocol ip pref 50 u32
filter protocol ip pref 50 u32 fh 800: ht divisor 1
filter protocol ip pref 50 u32 fh 800::800 order 2048 key ht 800 bkt 0 flowid :1
  match cc98bd74/ffffffff at 12

The outside interface is eth1.

After I do this, any connection to ftp.kernel.org doesn't work.

Attached is a dump of a connection try to ftp.kernel.org.

Am I doing something wrong here or the problem comes from somewhere else ?

Distrib: gentoo
Kernel ver: 2.4.20-pre6
iproute-20010824 (also tried with iproute2-2.4.7-now-ss020116-try)

--1774334226-839852540-1031929276=:6388
Content-Type: TEXT/plain; name="trace.txt"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0209131801160.6388@webdev.ines.ro>
Content-Description: trace dump
Content-Disposition: attachment; filename="trace.txt"

MTc6NTU6MDAuODg2MjEzIG15aG9zdC5pbmVzLnJvLjMyOTc5ID4gemV1cy1w
dWIua2VybmVsLm9yZy5mdHA6IFMgMTA0ODI0ODU5NjoxMDQ4MjQ4NTk2KDAp
IHdpbiA1ODQwIDxtc3MgMTQ2MCxzYWNrT0ssdGltZXN0YW1wIDgzMDQyNzQg
MCxub3Asd3NjYWxlIDA+IChERikNDQoxNzo1NTowMS4wODkxOTggemV1cy1w
dWIua2VybmVsLm9yZy5mdHAgPiBteWhvc3QuaW5lcy5yby4zMjk3OTogUyAx
MDM2MTY0MDA1OjEwMzYxNjQwMDUoMCkgYWNrIDEwNDgyNDg1OTcgd2luIDU3
OTIgPG1zcyAxNDYwLHNhY2tPSyx0aW1lc3RhbXAgODQ1NTM5ODEwIDgzMDQy
NzQsbm9wLHdzY2FsZSAwPiAoREYpIFt0b3MgMHg2MixFQ1QoMCldDQ0KMTc6
NTU6MDMuODg1ODAwIG15aG9zdC5pbmVzLnJvLjMyOTc5ID4gemV1cy1wdWIu
a2VybmVsLm9yZy5mdHA6IFMgMTA0ODI0ODU5NjoxMDQ4MjQ4NTk2KDApIHdp
biA1ODQwIDxtc3MgMTQ2MCxzYWNrT0ssdGltZXN0YW1wIDgzMDQ1NzQgMCxu
b3Asd3NjYWxlIDA+IChERikNDQoxNzo1NTowNC4wODk0MDcgemV1cy1wdWIu
a2VybmVsLm9yZy5mdHAgPiBteWhvc3QuaW5lcy5yby4zMjk3OTogUyAxMDM2
MTY0MDA1OjEwMzYxNjQwMDUoMCkgYWNrIDEwNDgyNDg1OTcgd2luIDU3OTIg
PG1zcyAxNDYwLHNhY2tPSyx0aW1lc3RhbXAgODQ1NTQwMTEwIDgzMDQyNzQs
bm9wLHdzY2FsZSAwPiAoREYpIFt0b3MgMHg2MixFQ1QoMCldDQ0KMTc6NTU6
MDUuMjQ1MjgzIHpldXMtcHViLmtlcm5lbC5vcmcuZnRwID4gbXlob3N0Lmlu
ZXMucm8uMzI5Nzk6IFMgMTAzNjE2NDAwNToxMDM2MTY0MDA1KDApIGFjayAx
MDQ4MjQ4NTk3IHdpbiA1NzkyIDxtc3MgMTQ2MCxzYWNrT0ssdGltZXN0YW1w
IDg0NTU0MDIyNiA4MzA0Mjc0LG5vcCx3c2NhbGUgMD4gKERGKSBbdG9zIDB4
NjIsRUNUKDApXQ0NCjE3OjU1OjA5Ljg4NTc2NyBteWhvc3QuaW5lcy5yby4z
Mjk3OSA+IHpldXMtcHViLmtlcm5lbC5vcmcuZnRwOiBTIDEwNDgyNDg1OTY6
MTA0ODI0ODU5NigwKSB3aW4gNTg0MCA8bXNzIDE0NjAsc2Fja09LLHRpbWVz
dGFtcCA4MzA1MTc0IDAsbm9wLHdzY2FsZSAwPiAoREYpDQ0KMTc6NTU6MTAu
MDg4MTA0IHpldXMtcHViLmtlcm5lbC5vcmcuZnRwID4gbXlob3N0LmluZXMu
cm8uMzI5Nzk6IFMgMTAzNjE2NDAwNToxMDM2MTY0MDA1KDApIGFjayAxMDQ4
MjQ4NTk3IHdpbiA1NzkyIDxtc3MgMTQ2MCxzYWNrT0ssdGltZXN0YW1wIDg0
NTU0MDcxMCA4MzA0Mjc0LG5vcCx3c2NhbGUgMD4gKERGKSBbdG9zIDB4NjIs
RUNUKDApXQ0NCjE3OjU1OjExLjI0NzMyMCB6ZXVzLXB1Yi5rZXJuZWwub3Jn
LmZ0cCA+IG15aG9zdC5pbmVzLnJvLjMyOTc5OiBTIDEwMzYxNjQwMDU6MTAz
NjE2NDAwNSgwKSBhY2sgMTA0ODI0ODU5NyB3aW4gNTc5MiA8bXNzIDE0NjAs
c2Fja09LLHRpbWVzdGFtcCA4NDU1NDA4MjYgODMwNDI3NCxub3Asd3NjYWxl
IDA+IChERikgW3RvcyAweDYyLEVDVCgwKV0NDQoxNzo1NToyMS44ODU2OTkg
bXlob3N0LmluZXMucm8uMzI5NzkgPiB6ZXVzLXB1Yi5rZXJuZWwub3JnLmZ0
cDogUyAxMDQ4MjQ4NTk2OjEwNDgyNDg1OTYoMCkgd2luIDU4NDAgPG1zcyAx
NDYwLHNhY2tPSyx0aW1lc3RhbXAgODMwNjM3NCAwLG5vcCx3c2NhbGUgMD4g
KERGKQ0NCjE3OjU1OjIyLjA4NzAwNyB6ZXVzLXB1Yi5rZXJuZWwub3JnLmZ0
cCA+IG15aG9zdC5pbmVzLnJvLjMyOTc5OiBTIDEwMzYxNjQwMDU6MTAzNjE2
NDAwNSgwKSBhY2sgMTA0ODI0ODU5NyB3aW4gNTc5MiA8bXNzIDE0NjAsc2Fj
a09LLHRpbWVzdGFtcCA4NDU1NDE5MTAgODMwNDI3NCxub3Asd3NjYWxlIDA+
IChERikgW3RvcyAweDYyLEVDVCgwKV0NDQoxNzo1NToyMy4yNDcyNDEgemV1
cy1wdWIua2VybmVsLm9yZy5mdHAgPiBteWhvc3QuaW5lcy5yby4zMjk3OTog
UyAxMDM2MTY0MDA1OjEwMzYxNjQwMDUoMCkgYWNrIDEwNDgyNDg1OTcgd2lu
IDU3OTIgPG1zcyAxNDYwLHNhY2tPSyx0aW1lc3RhbXAgODQ1NTQyMDI2IDgz
MDQyNzQsbm9wLHdzY2FsZSAwPiAoREYpIFt0b3MgMHg2MixFQ1QoMCldDQ0K

--1774334226-839852540-1031929276=:6388--
