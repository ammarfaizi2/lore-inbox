Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319419AbSH3DsO>; Thu, 29 Aug 2002 23:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319422AbSH3DsO>; Thu, 29 Aug 2002 23:48:14 -0400
Received: from web10501.mail.yahoo.com ([216.136.130.151]:9751 "HELO
	web10501.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S319419AbSH3DsM>; Thu, 29 Aug 2002 23:48:12 -0400
Message-ID: <20020830035236.44060.qmail@web10501.mail.yahoo.com>
Date: Thu, 29 Aug 2002 20:52:36 -0700 (PDT)
From: Andy Tai <lichengtai@yahoo.com>
Reply-To: atai@atai.org
Subject: file locking (fcntl) bug in 2.4.19
To: linux-kernel@vger.kernel.org
Cc: atai@atai.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-591544022-1030679556=:42005"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-591544022-1030679556=:42005
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi, there is a bug on file locking (via fcntl) on
linux kernel 2.4.19 when locking files in a NFS
volume.

Try to mount a remote NFS server on a directory in a
machine running Linux 2.4.19 as follows:

mount -o nfsvers=3,intr <remote NFS server path> /mnt

Then run the attached program which demonstrates the
bug:

lockbug /mnt/xx

and it keeps showing the error 

lock failed with error: No locks available

The file has not been locked so there must be locks
available.  The error message is wrong.

Trying this on a file in a local drive does not show
the error.

The attached program basically forks a child and in
the child it tries to lock a file descriptor that was
opened in the parent.

Thanks for any help on working around this bug.

__________________________________________________
Do You Yahoo!?
Yahoo! Finance - Get real-time stock quotes
http://finance.yahoo.com
--0-591544022-1030679556=:42005
Content-Type: application/octet-stream; name="lockbug.c"
Content-Transfer-Encoding: base64
Content-Description: lockbug.c
Content-Disposition: attachment; filename="lockbug.c"

LyogY29kZSBpcyBkZXJpdmVkIGZyb20gU2FtYmEKICAgQ29weXJpZ2h0IChD
KSBBbmRyZXcgVHJpZGdlbGwgMTk5Mi0xOTk4CiAgIENvcHlyaWdodCAoQykg
SmVyZW15IEFsbGlzb24gMjAwMQogICBDb3B5cmlnaHQgKEMpIFNpbW8gU29y
Y2UgMjAwMQoKCiAgIG1vZGlmaWNhdGlvbiBoZXJlaW4gQ29weXJpZ2h0IDIw
MDIgTGktQ2hlbmcgVGFpCiAgIFRoaXMgY29kZSBpcyBjb3ZlcmVkIGJ5IHRo
ZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSwgdmVyc2lvbiAyIG9yIGxh
dGVyICovCiAgIAojaW5jbHVkZSA8c3RkaW8uaD4KI2luY2x1ZGUgPHVuaXN0
ZC5oPgojaW5jbHVkZSA8c3RkbGliLmg+CiNpbmNsdWRlIDxlcnJuby5oPgoj
aW5jbHVkZSA8c3RyaW5nLmg+CiNpbmNsdWRlIDxzdGRpbnQuaD4KI2luY2x1
ZGUgPGZjbnRsLmg+CiNpbmNsdWRlIDxzeXMvd2FpdC5oPgovKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKgpBIGZjbnRsIHdyYXBwZXIgdGhhdCB3aWxsIGRlYWwg
d2l0aCBFSU5UUi4KKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiovCgppbnQgc3lz
X2ZjbnRsX3B0cihpbnQgZmQsIGludCBjbWQsIHZvaWQgKmFyZykKewogICAg
aW50IHJldDsKCiAgICBkbyB7CiAgICAgICAgICAgIHJldCA9IGZjbnRsKGZk
LCBjbWQsIGFyZyk7CiAgICB9IHdoaWxlIChyZXQgPT0gLTEgJiYgZXJybm8g
PT0gRUlOVFIpOwogICAgcmV0dXJuIHJldDsKfQoKaW50IGZjbnRsX2xvY2so
aW50IGYsIHVpbnQ2NF90IG9mZnNldCwgdWludDY0X3QgY291bnQpCnsKICAg
IHN0cnVjdCBmbG9jayBsb2NrOwogICAgaW50IHJldDsKICAgIAogICAgbG9j
ay5sX3R5cGUgPSBGX1dSTENLOwogICAgbG9jay5sX3doZW5jZSA9IFNFRUtf
U0VUOwogICAgbG9jay5sX3N0YXJ0ID0gb2Zmc2V0OwogICAgbG9jay5sX2xl
biA9IGNvdW50OwogICAgbG9jay5sX3BpZCA9IDA7CgogICAgcmV0ID0gc3lz
X2ZjbnRsX3B0cihmLEZfU0VUTEssJmxvY2spOwogICAgaWYgKHJldCA9PSAt
MSkKICAgIHsKICAgICAgICBmcHJpbnRmKHN0ZGVyciwgImxvY2sgZmFpbGVk
IHdpdGggZXJyb3I6ICVzXG4iLCBzdHJlcnJvcihlcnJubykpOwogICAgICAg
IGV4aXQoMSk7CiAgICB9CiAgICBlbHNlCiAgICB7CiAgICAgICAgbG9jay5s
X3R5cGUgPSBGX1VOTENLOwogICAgICAgIGxvY2subF93aGVuY2UgPSBTRUVL
X1NFVDsKICAgICAgICBsb2NrLmxfc3RhcnQgPSBvZmZzZXQ7CiAgICAgICAg
bG9jay5sX2xlbiA9IGNvdW50OwogICAgICAgIGxvY2subF9waWQgPSAwOwog
ICAgICAgIHJldCA9IHN5c19mY250bF9wdHIoZixGX1NFVExLLCZsb2NrKTsK
ICAgICAgICBpZiAocmV0ID09IC0xKQogICAgICAgIHsKICAgICAgICAgICAg
ZnByaW50ZihzdGRlcnIsICJ1bmxvY2sgZmFpbGVkIHdpdGggZXJyb3I6ICVz
XG4iLCBzdHJlcnJvcihlcnJubykpOwogICAgICAgICAgICBleGl0KDEpOwog
ICAgICAgIH0KICAgIH0KICAgIHJldHVybiAxOwp9CgppbnQgbWFpbihpbnQg
YXJnYywgY2hhciAqYXJndltdKQp7CiAgICBpbnQgZiwgaSwgc3RhdHVzOwog
ICAgCiAgICAKICAgIGlmIChhcmdjICE9IDIpCiAgICB7CiAgICAgICAgZnBy
aW50ZihzdGRlcnIsICJVc2FnZTogJXMgZmlsZV9uYW1lIFxuIiwgYXJndlsw
XSk7CiAgICB9CiAgICBmID0gb3Blbihhcmd2WzFdLCBPX0NSRUFUIHwgT19S
RFdSKTsKICAgIGlmICghZikKICAgIHsKICAgICAgICBmcHJpbnRmKHN0ZGVy
ciwgInVubG9jayBmYWlsZWQgd2l0aCBlcnJvcjogJXNcbiIsIHN0cmVycm9y
KGVycm5vKSk7CiAgICAgICAgZXhpdCgxKTsKICAgIH0KICAgIHdoaWxlICgx
KQogICAgewogICAgICAgIGkgPSBmb3JrKCk7CiAgICAgICAgaWYgKGkgPiAw
KQogICAgICAgIHsKICAgICAgICAgICAgc2xlZXAoMik7CiAgICAgICAgICAg
IHdhaXQoJnN0YXR1cyk7CiAgICAgICAgICAgIGNvbnRpbnVlOwogICAgICAg
IH0KICAgICAgICBlbHNlCiAgICAgICAgewogICAgICAgICAgICBmY250bF9s
b2NrKGYsIDIxNDc0ODM1MzlMLCAxKTsKICAgICAgICAgICAgZXhpdCgwKTsK
ICAgICAgICB9CiAgICB9CiAgICBjbG9zZShmKTsKICAgIHJldHVybiAwOwp9
Cg==

--0-591544022-1030679556=:42005--
