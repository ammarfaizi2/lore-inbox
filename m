Received: by vger.rutgers.edu via listexpand id <168256-11364>; Thu, 15 Apr 1999 17:53:30 -0400
Received: by vger.rutgers.edu id <160290-11366>; Thu, 15 Apr 1999 17:53:10 -0400
Received: from mail.inconnect.com ([209.140.64.7]:35142 "HELO mail.inconnect.com" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with SMTP id <161283-11366>; Thu, 15 Apr 1999 17:52:58 -0400
Date: Thu, 15 Apr 1999 16:14:51 -0600 (MDT)
From: Dax Kelson <dkelson@inconnect.com>
To: Jim Nance <jlnance@avanticorp.com>
cc: linux-kernel@vger.rutgers.edu
Subject: Re: Solaris tmpfs vs. Linux RAMdisk
In-Reply-To: <19990414141937.A23591@avanticorp.com>
Message-ID: <Pine.LNX.4.04.9904151611084.695-200000@brookie.inconnect.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1932454080-1223573852-924214491=:695"
Sender: owner-linux-kernel@vger.rutgers.edu

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---1932454080-1223573852-924214491=:695
Content-Type: TEXT/PLAIN; charset=US-ASCII



On Wed, 14 Apr 1999, Jim Nance wrote:

> The original question is enough of an FAQ that I thought it would be good to
> have real numbers rather than just my assurances that Linux has a fast FS
> layer.  Therefore I wrote a benchmarking program that creates/writes/destroys
> files and ran it under several operating systems and on several types of
> file systems.  I have included that program as an attachment to this mail.
> Here are the results:
> 
> OS                      Hardware        FS Type         Loops/Second
> --------------------------------------------------------------------
> Linux 2.2.5-ac6         1               nfs             16.33
> Linux 2.2.5-ac6         1               arla            73.67
> Linux 2.2.5-ac6         1               ext2            15383.32
> Solaris 2.6             2               afs             71.33
> Solaris 2.6             2               nfs             10.00
> Solaris 2.6             2               ufs             23.67
> Solaris 2.6             2               tmpfs           9162.32
> Digital Unix 4.0D       3               afs             49.33
> Digital Unix 4.0D       3               nfs             14.67
> Digital Unix 4.0D       3               ufs             28.67
> Digital Unix 4.0D       3               memfs           3062.66
> Linux 2.0.33            4               afs             69.33
> Linux 2.0.33            4               nfs             15.00
> Linux 2.0.33            4               ext2            2218.33
> 
> Hardware:
> 1 -> 333 MHz PII, 512M ram, Compaq WDE4360W disk
> 2 -> Ultra450 class Sun server (300MHz?)
> 3 -> Personal Workstation 600 AU. 600 MHz alpha.  1.5G ram
> 4 -> 75 MHz Pentium, 32M ram, Segate ST31200N disk

Can you try the Solaris "fastfs" utility and post the results?  It should
make ufs performance much closer to ext2 (and give you the same
reliability as ext2 (for better or worse, but it has been a *LONG* time 
since I've seen my Solaris or Linux boxes panic)).

I've attached the source for fastfs.

Dax Kelson

---1932454080-1223573852-924214491=:695
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="fastfs.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.04.9904151614510.695@brookie.inconnect.com>
Content-Description: 
Content-Disposition: attachment; filename="fastfs.c"

LyogDQogKiAkSWQ6IGZhc3Rmcy5jLHYgMS4zIDE5OTUvMDIvMDIgMTU6MzI6
MTkgY2FzcGVyIEV4cCBjYXNwZXIgJA0KICoNCiAqIFRoaXMgcHJvZ3JhbXMg
dHVybnMgb24vb2ZmIGRlbGF5ZWQgSS9PIG9uIGEgZmlsZXN5c3RlbS4NCiAq
IA0KICogVXNhZ2U6ICAgZmFzdGZzIGZpbGVzeXN0ZW0gZmFzdHxzbG93fHN0
YXR1cw0KICoNCiAqIE5vdGUgdGhhdCBpdCBpcyBpbnRlbmRlZCBmb3IgdXNl
IHdpdGggcmVzdG9yZSg4KQ0KICogdG8gc3BlZWQgdXAgZnVsbCBmaWxlc3lz
dGVtIHJlc3RvcmVzLiBSZW1lbWJlcg0KICogdGhhdCBpZiBhIGZpbGVzeXN0
ZW0gaXMgcnVubmluZyB3aXRoIGRlbGF5ZWQgSS9PDQogKiBlbmFibGVkIHdo
ZW4gdGhlIHN5c3RlbSBjcmFzaGVzIGl0IGNhbiByZXN1bHQgaW4NCiAqIGZz
Y2sgYmVpbmcgdW5hYmxlIHRvICJmaXgiIHRoZSBmaWxlc3lzdGVtIG9uIHJl
Ym9vdA0KICogd2l0aG91dCBtYW51YWwgaW50ZXJ2ZW50aW9uLg0KICoNCiAq
IFR5cGljYWwgdXNlIGlzDQogKg0KICogZmFzdGZzIC9ob21lIGZhc3QNCiAq
IGNkIC9ob21lOyByZXN0b3JlIHJmIC9kZXYvcnN0NQ0KICogZmFzdGZzIC9o
b21lIHNsb3cNCiAqDQogKiBUaGUgYWJvdmUgZ2l2ZXMgYWJvdXQgYSA1MDAl
IGluY3JlYXNlIGluIHRoZSBzcGVlZCBvZg0KICogdGhlIHJlc3RvcmUgKHlv
dXIgbWlsYWdlIG1heSB2YXJ5KS4NCiAqDQogKiBJdHMgYWxzbyBnb29kIGZv
ciAvdG1wIGdpdmluZyBtb3N0IG9mIHRoZSBiZW5pZml0cyBvZiB0bXBmcw0K
ICogd2l0aG91dCB0aGUgcHJvYmxlbXMuDQogKg0KICogSW4gcmMubG9jYWwN
CiAqDQogKiBmYXN0ZnMgL3RtcCBmYXN0DQogKg0KICogYnV0IHlvdSBtYXkg
bmVlZCB0byBhZGQgZnNjayAteSAvdG1wIGludG8gL2V0Yy9yYy5ib290DQog
KiBiZWZvcmUgdGhlIHJlYWwgZnNjayB0byBlbnN1cmUgdGhlIG1hY2hpbmUg
YWx3YXlzIGJvb3RzDQogKg0KICogQWRhcHRlZCBmcm9tIHRoZSBvcmlnaW5h
bCBmYXN0ZnMuYyBjb2RlIGJ5DQogKiBQZXRlciBHcmF5LCAgVW5pdmVyc2l0
eSBvZiBXb2xsb25nb25nLg0KICoNCiAqIENhc3BlciBEaWsNCiovDQoNCiNp
bmNsdWRlIDxzdGRpby5oPiANCiNpbmNsdWRlIDxzdHJpbmcuaD4gDQojaW5j
bHVkZSA8c3lzL2lvY3RsLmg+DQojaW5jbHVkZSA8c3lzL2ZpbGlvLmg+DQoj
aW5jbHVkZSA8ZmNudGwuaD4NCiNpbmNsdWRlIDxlcnJuby5oPg0KI2lmbmRl
ZiBGSU9ESU8NCiNkZWZpbmUgU09MQVJJUw0KI2RlZmluZSBGSU9ESU8gX0ZJ
T1NESU8NCiNkZWZpbmUgRklPRElPUyBfRklPR0RJTw0KI2luY2x1ZGUgPHN5
cy9tbnR0YWIuaD4NCiNkZWZpbmUgTVRBQiAiL2V0Yy9tbnR0YWIiDQojZWxz
ZQ0KI2luY2x1ZGUgPG1udGVudC5oPg0KI2RlZmluZSBNVEFCICIvZXRjL210
YWIiDQojZW5kaWYNCg0KI2lmbmRlZiBTT0xBUklTDQpleHRlcm4gY2hhciAq
c3lzX2Vycmxpc3RbXTsNCmV4dGVybiBpbnQgc3lzX25lcnI7DQojZGVmaW5l
IHN0cmVycm9yKHgpICgoeCA+IHN5c19uZXJyIHx8IHggPCAwKSA/ICJVa25v
d24gZXJyb3IiIDogc3lzX2Vycmxpc3RbeF0pDQojZW5kaWYNCg0KaW50IGVy
cm9yczsNCg0KY2hhciAqY21kc1tdID0geyAgInNsb3ciLCAiZmFzdCIsICJz
dGF0dXMiIH07DQoNCiNkZWZpbmUgQ01EX1NMT1cgMA0KI2RlZmluZSBDTURf
RkFTVCAxDQojZGVmaW5lIENNRF9TVEFUVVMgMg0KI2RlZmluZSBDTURfRVJS
T1IgLTENCiNkZWZpbmUgQ01EX0FNQklHVU9VUyAtMg0KDQppbnQNCnN0cjJj
bWQoc3RyKQ0KY2hhciAqc3RyOw0Kew0KICAgIGludCBpLGxlbiA9IHN0cmxl
bihzdHIpLCBoaXRzID0gMCwgcmVzID0gQ01EX0VSUk9SOw0KICAgIGZvciAo
aSA9IDA7IGkgPCBzaXplb2YoY21kcykvc2l6ZW9mKGNoYXIqKTsgaSsrKSB7
DQoJaWYgKHN0cm5jbXAoc3RyLCBjbWRzW2ldLCBsZW4pID09IDApIHsNCgkg
ICAgcmVzID0gaTsNCgkgICAgaGl0cysrOw0KCX0NCiAgICB9DQogICAgaWYg
KGhpdHMgPD0gMSkNCglyZXR1cm4gcmVzOw0KICAgIGVsc2UNCglyZXR1cm4g
Q01EX0FNQklHVU9VUzsNCn0NCg0Kdm9pZA0KZmFzdGZzKHBhdGgsIGNtZCkN
CmNoYXIgKnBhdGg7DQppbnQgY21kOw0Kew0KICAgIGludCBmZCA9IG9wZW4o
cGF0aCwgT19SRE9OTFkpOw0KICAgIGludCBmbGFnLCBuZXdmbGFnLCBvbGRm
bGFnLCBub2NoYW5nZSA9IDA7DQogICAgY2hhciAqaG93Ow0KDQogICAgaWYg
KGZkIDwgMCkgew0KCXBlcnJvcihwYXRoKTsNCgllcnJvcnMgKys7DQoJcmV0
dXJuOw0KICAgIH0NCiAgICBpZiAoaW9jdGwoZmQsIEZJT0RJT1MsICZvbGRm
bGFnKSA9PSAtMSkgew0KCXBlcnJvcigic3RhdHVzIGlvY3RsIik7DQoJZXJy
b3JzICsrOw0KCXJldHVybjsNCiAgICB9DQogICAgc3dpdGNoIChjbWQpIHsN
CgljYXNlIENNRF9TTE9XOg0KCSAgICBmbGFnID0gMDsNCgkgICAgaWYgKG9s
ZGZsYWcgPT0gZmxhZykNCgkJbm9jaGFuZ2UgPSAxOw0KCSAgICBlbHNlDQoJ
CWlmIChpb2N0bChmZCwgRklPRElPLCAmZmxhZykgPT0gLTEpIHsNCgkJICAg
IHBlcnJvcigic2xvdyBpb2N0bCIpOw0KCQkgICAgZXJyb3JzICsrOw0KCQkg
ICAgcmV0dXJuOw0KCQl9DQoJICAgIGJyZWFrOw0KCWNhc2UgQ01EX0ZBU1Q6
DQoJICAgIGZsYWcgPSAxOw0KCSAgICBpZiAob2xkZmxhZyA9PSBmbGFnKQ0K
CQlub2NoYW5nZSA9IDE7DQoJICAgIGVsc2UNCgkJaWYgKGlvY3RsKGZkLCBG
SU9ESU8sICZmbGFnKSA9PSAtMSkgew0KCQkgICAgcGVycm9yKCJmYXN0IGlv
Y3RsIik7DQoJCSAgICBlcnJvcnMgKys7DQoJCSAgICByZXR1cm47DQoJCX0N
CgkgICAgYnJlYWs7DQoJY2FzZSBDTURfU1RBVFVTOg0KCSAgICBob3cgPSAi
IjsNCgkgICAgYnJlYWs7DQoJZGVmYXVsdDoNCgkgICAgZnByaW50ZihzdGRl
cnIsIkludGVybmFsIGVycm9yOiB1bmV4cGVjdGVkIGNvbW1hbmRcbiIpOw0K
CSAgICBleGl0KDEpOw0KCSAgICAvKk5PVFJFQUNIRUQqLw0KICAgIH0NCiAg
ICBpZiAoaW9jdGwoZmQsIEZJT0RJT1MsICZuZXdmbGFnKSA9PSAtMSkgew0K
CXBlcnJvcigic3RhdHVzIGlvY3RsIik7DQoJZXJyb3JzICsrOw0KICAgIH0g
ZWxzZSB7DQoJaWYgKGNtZCAhPSBDTURfU1RBVFVTICYmIGZsYWcgIT0gbmV3
ZmxhZykNCgkgICAgcHJpbnRmKCJGQUlMRUQ6ICIpOw0KCWlmIChjbWQgIT0g
Q01EX1NUQVRVUykNCgkgICAgaG93ID0gbm9jaGFuZ2UgPyAiYWxyZWFkeSAi
IDogIm5vdyAiOw0KCXByaW50ZigiJXNcdGlzICVzJXNcbiIsIHBhdGgsIGhv
dywgY21kc1tuZXdmbGFnXSk7DQogICAgfQ0KICAgIGNsb3NlKGZkKTsNCn0N
Cg0Kdm9pZCB1c2FnZSgpDQp7DQogICAgZnByaW50ZihzdGRlcnIsIlVzYWdl
OiBmYXN0ZnMgLWEgW3Nsb3d8c3RhdHVzfGZhc3RdXG4iKTsNCiAgICBmcHJp
bnRmKHN0ZGVyciwiVXNhZ2U6IGZhc3RmcyBwYXRoMSAuLiBwYXRoTiBbc2xv
d3xzdGF0dXN8ZmFzdF1cbiIpOw0KICAgIGV4aXQoMSk7DQp9DQoNCmludA0K
bWFpbihhcmdjLCBhcmd2KQ0KaW50IGFyZ2M7DQpjaGFyCSoqYXJndjsNCnsN
CiAgICBpbnQgb3BzdGF0ID0gMDsNCiAgICBpbnQgaTsNCiAgICBjaGFyICpj
bWQ7DQogICAgaW50IGljbWQ7DQogICAgDQogICAgLyoNCiAgICAgKiBOZXcg
dXNhZ2U6DQogICAgICogZmFzdGZzIC1hICBbIHJlcG9ydCBzdGF0dXMgb24g
YWxsIHVmcyBmaWxlc3lzdGVtcyBdDQogICAgICogZmFzdGZzIC1hIHN0YXR1
c3xzbG93fGZhc3QNCiAgICAgKiBmYXN0ZnMgcGF0aDEgLi4uIHBhdGhOIHN0
YXR1c3xzbG93fGZhc3QNCiAgICAgKi8NCg0KICAgIGlmIChhcmdjIDwgMikg
dXNhZ2UoKTsNCg0KICAgIGlmIChhcmdjID4gMikgew0KCWlmIChzdHIyY21k
KGFyZ3ZbYXJnYy0xXSkgPT0gQ01EX0VSUk9SKQ0KCSAgICBvcHN0YXQgPSAx
Ow0KICAgIH0gZWxzZQ0KCW9wc3RhdCA9IDE7DQoNCiAgICBpZiAob3BzdGF0
KQ0KCWNtZCA9ICJzdGF0dXMiOw0KICAgIGVsc2UNCgljbWQgPSBhcmd2W2Fy
Z2MtMV07DQoNCiAgICBpZiAoKGljbWQgPSBzdHIyY21kKGNtZCkpIDwgMCkN
Cgl1c2FnZSgpOw0KDQogICAgaWYgKHN0cmNtcChhcmd2WzFdLCItYSIpID09
IDApIHsNCglGSUxFICpmcCA9IGZvcGVuKE1UQUIsInIiKTsNCiNpZmRlZiBT
T0xBUklTDQoJc3RydWN0IG1udHRhYiBtcCwgbXRlbXBsYXRlOw0KI2Vsc2UN
CglzdHJ1Y3QgbW50ZW50ICptbnQ7DQojZW5kaWYNCg0KCWlmIChmcCA9PSBO
VUxMKSB7DQoJICAgIGZwcmludGYoc3RkZXJyLCJDYW4ndCBvcGVuICVzXG4i
LCBNVEFCKTsNCgkgICAgZXhpdCgxKTsNCgl9DQoJaWYgKGFyZ2MgKyBvcHN0
YXQgIT0gMykNCgkgICAgdXNhZ2UoKTsNCiNpZmRlZiBTT0xBUklTDQoJbXRl
bXBsYXRlLm1udF9mc3R5cGUgPSAidWZzIjsNCgltdGVtcGxhdGUubW50X3Nw
ZWNpYWwgPSAwOw0KCW10ZW1wbGF0ZS5tbnRfbW50b3B0cyA9IDA7DQoJbXRl
bXBsYXRlLm1udF9tb3VudHAgPSAwOw0KCW10ZW1wbGF0ZS5tbnRfdGltZSA9
IDA7DQoJd2hpbGUgKGdldG1udGFueShmcCwgJm1wLCAmbXRlbXBsYXRlKSA9
PSAwKQ0KCSAgICBmYXN0ZnMobXAubW50X21vdW50cCwgaWNtZCk7DQojZWxz
ZQ0KCXdoaWxlIChtbnQgPSBnZXRtbnRlbnQoZnApKSB7DQoJICAgIGlmIChz
dHJjbXAobW50LT5tbnRfdHlwZSwiNC4yIikgIT0gMCkNCgkJY29udGludWU7
DQoJICAgIGZhc3RmcyhtbnQtPm1udF9kaXIsIGljbWQpOw0KCX0NCiNlbmRp
Zg0KCWZjbG9zZShmcCk7DQogICAgfSBlbHNlIHsNCglmb3IgKGkgPSAxOyBp
IDwgYXJnYyArIG9wc3RhdCAtIDE7IGkrKykNCgkgICAgZmFzdGZzKGFyZ3Zb
aV0sIGljbWQpOw0KICAgIH0NCg0KICAgIGV4aXQoZXJyb3JzID8gMSA6IDAp
Ow0KfQ0K
---1932454080-1223573852-924214491=:695--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
