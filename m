Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129720AbQKBWME>; Thu, 2 Nov 2000 17:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129619AbQKBWLx>; Thu, 2 Nov 2000 17:11:53 -0500
Received: from c100.clearway.com ([199.103.231.100]:56338 "EHLO
	mercury.clearway.com") by vger.kernel.org with ESMTP
	id <S129720AbQKBWLj>; Thu, 2 Nov 2000 17:11:39 -0500
From: Paul Marquis <pmarquis@iname.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <3A01E68C.EDA27165@iname.com>
Date: Thu, 02 Nov 2000 17:11:24 -0500
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.15pre3 ppc)
X-Accept-Language: en
MIME-Version: 1.0
Subject: select() bug
Content-Type: multipart/mixed;
 boundary="------------7121BADFB0F6863EBA7A88CE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------7121BADFB0F6863EBA7A88CE
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I've uncovered a bug in select() when checking if it's okay to write
on a pipe.  It will report "false negatives" if there is any unread
data already on the pipe, even a single byte.  As soon as the pipe
gets flushed, select() does the right thing.

Normally, I wouldn't think this such a big deal, except that Apache
uses the writability of s pipe to determine if any of its children
that are log file handlers are dead.  If select() reports it can't
write immediately, Apache terminates and restarts the child process,
creating unnecessary load on the system.

The bug exists in the 2.2.x kernels up to and including 2.2.17 that
I've tried and I don't know it extends beyond pipes.  I've attached
sample code to demonstrate the problem, which works correctly on BSD
and Solaris.

Is this a know bug?

-- 
Paul Marquis
pmarquis@iname.com

If it's tourist season, why can't we shoot them?


--------------7121BADFB0F6863EBA7A88CE
Content-Type: application/octet-stream;
 name="simple_pipe_test.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="simple_pipe_test.c"

I2luY2x1ZGUgPHN5cy90aW1lLmg+CiNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KI2luY2x1ZGUgPHN0
ZGlvLmg+CiNpbmNsdWRlIDxzdHJpbmcuaD4KI2luY2x1ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSA8
ZXJybm8uaD4KCmludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikKewogICBpbnQgZmRbMl07
CiAgIGludCBpOwogICBjaGFyIGJ1ZlsyXTsKICAgZmRfc2V0IHdyaXRlX2ZkczsKICAgc3RydWN0
IHRpbWV2YWwgdHY7CiAgIHNzaXplX3QgbjsKICAgaW50IHN0YXR1czsKCiAgIC8qIGluaXRpYWxp
emUgKi8KICAgYnVmWzBdID0gJ2gnOwogICBidWZbMV0gPSAnaSc7CgogICBkbwogICB7CiAgICAg
IC8qIGNyZWF0ZSBwaXBlICovCiAgICAgIGlmICgwID4gcGlwZShmZCkpCiAgICAgIHsKICAgICAg
ICAgcHJpbnRmKCJwaXBlIGVycm9yIC0gJXNcbiIsIHN0cmVycm9yKGVycm5vKSk7CiAgICAgICAg
IGJyZWFrOwogICAgICB9CgogICAgICAvKgogICAgICAgKiBsb29wIGZvdXIgdGltZXMKICAgICAg
ICogc2VsZWN0IGZvciB3cml0ZSwgdGhlbiB3cml0ZSBvbmUgYnl0ZQogICAgICAgKiBhZnRlciB0
aGUgc2Vjb25kIHdyaXRlLCBkbyBhIHJlYWQKICAgICAgICogb2RkIHNlbGVjdHMgc3VjY2VlZCwg
ZXZlbiBmYWlsCiAgICAgICAqLwogICAgICBmb3IgKGkgPSAwOyBpIDwgNDsgaSsrKQogICAgICB7
CiAgICAgICAgIHByaW50ZigiaXRlcmF0aW9uICVkXG4iLCBpICsgMSk7CgogICAgICAgICBzdGF0
dXMgPSAwOwoKICAgICAgICAgLyogZG8gc2VsZWN0ICovCiAgICAgICAgIEZEX1pFUk8oJndyaXRl
X2Zkcyk7CiAgICAgICAgIEZEX1NFVChmZFsxXSwgJndyaXRlX2Zkcyk7CiAgICAgICAgIHR2LnR2
X3NlYyA9IDA7CiAgICAgICAgIHR2LnR2X3VzZWMgPSAwOwogICAgICAgICBzd2l0Y2ggKHNlbGVj
dChmZFsxXSArIDEsIE5VTEwsICZ3cml0ZV9mZHMsIE5VTEwsICZ0dikpCiAgICAgICAgIHsKICAg
ICAgICAgICAgY2FzZSAtMToKICAgICAgICAgICAgICAgLyogc2hvdWxkIHByb2JhYmx5IGNoZWNr
IGZvciBFSU5UUiBhbmQvb3IgRVdPVUxEQkxPQ0sgKi8KICAgICAgICAgICAgICAgcHJpbnRmKCJz
ZWxlY3QgZXJyb3IgLSAlc1xuIiwgc3RyZXJyb3IoZXJybm8pKTsKICAgICAgICAgICAgICAgYnJl
YWs7CiAgICAgICAgICAgIGNhc2UgMDoKICAgICAgICAgICAgICAgLyogbm8gSS9PICovCiAgICAg
ICAgICAgICAgIHB1dHMoInNlbGVjdCByZXR1cm5lZCAwIC0tIHBpcGUgbm90IHdyaXRhYmxlIik7
CiAgICAgICAgICAgICAgIGJyZWFrOwogICAgICAgICAgICBkZWZhdWx0OgogICAgICAgICAgICAg
ICAvKiBtYWtlIHN1cmUgb3VyIGZkIGlzIHdyaXRhYmxlICovCiAgICAgICAgICAgICAgIGlmIChG
RF9JU1NFVChmZFsxXSwgJndyaXRlX2ZkcykpCiAgICAgICAgICAgICAgIHsKICAgICAgICAgICAg
ICAgICAgcHV0cygic2VsZWN0IHNheXMgcGlwZSBpcyB3cml0YWJsZSIpOwogICAgICAgICAgICAg
ICAgICBzdGF0dXMgPSAxOwogICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgIGVsc2UKICAg
ICAgICAgICAgICAgICAgcHV0cygic2VsZWN0IHNheXMgcGlwZSBpcyBub3Qgd3JpdGFibGUiKTsK
ICAgICAgICAgICAgICAgYnJlYWs7CiAgICAgICAgIH0KCiAgICAgICAgIC8qIGRvIHdyaXRlICov
CiAgICAgICAgIG4gPSB3cml0ZShmZFsxXSwgYnVmICsgKGkgJSAyKSwgMSk7CiAgICAgICAgIHN3
aXRjaCAobikKICAgICAgICAgewogICAgICAgICAgICBjYXNlIC0xOgogICAgICAgICAgICAgICAv
KiBzaG91bGQgcHJvYmFibHkgY2hlY2sgZm9yIEVJTlRSIGFuZC9vciBFV09VTERCTE9DSyAqLwog
ICAgICAgICAgICAgICBwcmludGYoIndyaXRlIGVycm9yIC0gJXNcbiIsIHN0cmVycm9yKGVycm5v
KSk7CiAgICAgICAgICAgICAgIGJyZWFrOwogICAgICAgICAgICBjYXNlIDA6CiAgICAgICAgICAg
ICAgIC8qIG5vIEkvTyAqLwogICAgICAgICAgICAgICBwdXRzKCJ3cml0ZSByZXR1cm5lZCAwIC0t
IHBpcGUgY2xvc2VkIik7CiAgICAgICAgICAgICAgIGJyZWFrOwogICAgICAgICAgICBkZWZhdWx0
OgogICAgICAgICAgICAgICBwcmludGYoIndyaXRlIHN1Y2NlZWRlZCAtICVkIGJ5dGVzIHdyaXR0
ZW5cbiIsIG4pOwogICAgICAgICAgICAgICBpZiAoMCA9PSBzdGF0dXMpCiAgICAgICAgICAgICAg
ICAgIHB1dHMoInNlbGVjdCBidWciKTsKICAgICAgICAgICAgICAgYnJlYWs7CiAgICAgICAgIH0K
CiAgICAgICAgIC8qIGRvIHJlYWQgKi8KICAgICAgICAgaWYgKDAgPT0gKChpICsgMSkgJSAyKSkK
ICAgICAgICAgewogICAgICAgICAgICBuID0gcmVhZChmZFswXSwgYnVmLCBzaXplb2YoYnVmKSk7
CiAgICAgICAgICAgIHN3aXRjaCAobikKICAgICAgICAgICAgewogICAgICAgICAgICAgICBjYXNl
IC0xOgogICAgICAgICAgICAgICAgICAvKiBzaG91bGQgcHJvYmFibHkgY2hlY2sgZm9yIEVJTlRS
IGFuZC9vciBFV09VTERCTE9DSyAqLwogICAgICAgICAgICAgICAgICBwcmludGYoIndyaXRlIGVy
cm9yIC0gJXNcbiIsIHN0cmVycm9yKGVycm5vKSk7CiAgICAgICAgICAgICAgICAgIGJyZWFrOwog
ICAgICAgICAgICAgICBjYXNlIDA6CiAgICAgICAgICAgICAgICAgIC8qIG5vIEkvTyAqLwogICAg
ICAgICAgICAgICAgICBwdXRzKCJyZWFkIHJldHVybmVkIDAgLS0gcGlwZSBjbG9zZWQiKTsKICAg
ICAgICAgICAgICAgICAgYnJlYWs7CiAgICAgICAgICAgICAgIGRlZmF1bHQ6CiAgICAgICAgICAg
ICAgICAgIHByaW50ZigicmVhZCBzdWNjZWVkZWQgLSAlZCBieXRlcyByZWFkXG4iLCBuKTsKICAg
ICAgICAgICAgICAgICAgYnJlYWs7CiAgICAgICAgICAgIH0KICAgICAgICAgfQogICAgICB9CiAg
IH0KICAgd2hpbGUgKDApOwoKICAgZXhpdCgwKTsKfQo=

--------------7121BADFB0F6863EBA7A88CE--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
