Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752280AbWKQSi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752280AbWKQSi0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 13:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755786AbWKQSi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 13:38:26 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:31447 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1752261AbWKQSiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 13:38:24 -0500
Date: Fri, 17 Nov 2006 19:37:41 +0100
From: Chris Friedhoff <chris@friedhoff.org>
To: "Bill O'Donnell" <billodo@sgi.com>
Cc: KaiGai Kohei <kaigai@ak.jp.nec.com>, "Serge E. Hallyn" <serue@us.ibm.com>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
       Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>,
       KaiGai Kohei <kaigai@kaigai.gr.jp>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH 1/1] security: introduce fs caps
Message-Id: <20061117193741.9be61ff1.chris@friedhoff.org>
In-Reply-To: <20061116144743.GA21497@sgi.com>
References: <20061108222453.GA6408@sergelap.austin.ibm.com>
	<20061109061021.GA32696@sergelap.austin.ibm.com>
	<20061109103349.e58e8f51.chris@friedhoff.org>
	<20061113215706.GA9658@sgi.com>
	<20061114052531.GA20915@sergelap.austin.ibm.com>
	<20061114135546.GA9953@sgi.com>
	<20061114152307.GA7534@sergelap.austin.ibm.com>
	<455B0357.2050400@ak.jp.nec.com>
	<20061115170633.GA21345@sgi.com>
	<20061115224923.539fe60a.chris@friedhoff.org>
	<20061116144743.GA21497@sgi.com>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Fri__17_Nov_2006_19_37_41_+0100_UW99dMRaAfmI1mmG"
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9d7f00276fac4b25ba506f26988c1e36
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Fri__17_Nov_2006_19_37_41_+0100_UW99dMRaAfmI1mmG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> Good quesion.  My gentoo ia32 machine uses libcap.so.1.10.  Probably a FAQ, 
> but is 1.92 actually older than 1.10?
looking at these locations, yes
http://www.me.kernel.org/pub/linux/libs/security/linux-privs/old/kernel-2.3/
http://ftp.kernel.org/pub/linux/libs/security/linux-privs/kernel-2.4/

> | Kaigai also provides a srpm package to compile.
> |  VFS Capability Support -> fscaps version 1.0 [SRPM]
> | (http://www.kaigai.gr.jp/pub/fscaps-1.0-kg.src.rpm)
> 
> I'll try that next.

I installed sles10 in qemu on my pentium-m laptop, compiled  a kernel
with fscap support and installed fscaps-1.0-kg.i386.rpm and got "Invalid
argument (errno=22)" error.
trace output is attached

# id
uid=0(root) gid=0(root) groups=0(root)
# uname -a
Linux sles10 2.6.19-rc3-fscaps-a #2 Fri Nov 17 09:17:40 CET 2006 i686
i686 i386 GNU/Linux
# rpm -q fscaps
fscaps-1.0-kg
# zgrep -i capa /proc/config.gz
CONFIG_SECURITY_FS_CAPABILITIES=y
# setfcaps cap_net_raw=ep /bin/ping
/bin/ping: Invalid argument (errno=22)
# setfcaps cap_sys_module=ep /sbin/modprobe
/sbin/modprobe: Invalid argument (errno=22)
# ls -l /lib/libcap.so*
lrwxrwxrwx 1 root root    11 Nov 17 09:51 /lib/libcap.so -> libcap.so.1
lrwxrwxrwx 1 root root    14 Nov 16 11:57 /lib/libcap.so.1 ->
libcap.so.1.92 -rwxr-xr-x 1 root root 10456 Jun 16
15:14 /lib/libcap.so.1.92



--------------------
Chris Friedhoff
chris@friedhoff.org


--Multipart=_Fri__17_Nov_2006_19_37_41_+0100_UW99dMRaAfmI1mmG
Content-Type: application/octet-stream;
 name="strace-ping-sles10.gz"
Content-Disposition: attachment;
 filename="strace-ping-sles10.gz"
Content-Transfer-Encoding: base64

H4sICJZ5XUUAA3N0cmFjZS1waW5nLXNsZXMxMACtVmFz2jgQ/d5foeGT6Tgg2cY2zHA3NDg95sCk
QNJmLh2NbAviqbE9kqHkkv73WxlaQ0jSXhOMLZB3V9r3nndtGo6NEN/wcM21WnMlRTOI06bkxTxk
uazp6J/a3p8ajDTlBRXsa5fnaqa0z+N0UfsMxs23qNVCayYketv8XEddhN+Y5RqB+KLhOnrmA7Yb
F1sM4+8+yyXLDc2/GA51ZOG2raPzyXhGJ16vf1/++jgZzDwdjXrn9HwyuOzNvHv1u+eP/avR+GKq
oxOiI1zuYxM48xBXwVkYcikhaV6EzSRqyKyRC55kLIK0JnT8t/I6Icjzx54/Q5qfIbkKb9A8TjjK
BIpiwcMiE7f1XcAs5+lBuJCFNxyCjemkP/aHVyqguTOey4IVtqWZOrqTBV1mEe9O6eBs4r2/x7Zl
6QhmZfwv77bstglWjUbj2z6e+9jsTH6Ac4CIjsx9CAKjgiBMMsk18xlWqvV22SVxoE7QgcqQPJGd
4CxSqdWuieN4w7NrUh746DB3Z3Vvrq4Y1yBfSIwYKiwMvwKb02pVsBFsteznYSMmLHSkKe+Td3os
qb7nX+3UdgAn43tyZdE6BkCrGz/WGPX6l3TqfbgAKQ16w3u8Ice72vJDSof/I/ezwSev/9guN0ZF
O3kV2hXp9gHpr8E6YHR1TV5OuYUtwzJ+Qjpx7Lbrvox27j5B+/bG3iq/Tjxztp626VovZ54Qt9Ko
87CkbqeDcsG2bRyj8dP1niyxZdTfENpr13ruRtVGoIXR4kbpkzK4anc8LcQtTVfLgIsOFPmTPxCs
GDDJKYsi0dlFsAMAKImXcdGBeuK2HKU2vqCmEagpHYVZWkAs2QG7MrxqpTRLk9vOd08apzRnCy6V
vXJOs4JCp5Hgp4xWkrMg4R1yKNlcZAX0lwNtuKRt7OFyYL9KAUCtKvG7rlB/BOrfacWlD8zZit5H
fbc+9j79LF9wlQFpt11smrAn+N5tB/ytrB2qwQ78y94QaYN0zZI4QkwsVksAp/6gAJAHBeD0rwm0
SgOXBUBEfN1dsi8cRg2eH1I/LgNxFhaJCjP1+6ezIZ2NJnQ2GHnvelNPdfTZ6XtvBjq6ewePIMZQ
+zJZoFjGCxSHLM1SxMOb7Nnq8ipvKcG8wvCriAuu9ly9aHXQQ6SQxoXYlk+zXfbh9s6db0CAC5Gt
8qcY76I/3/wH528XqwYKAAA=

--Multipart=_Fri__17_Nov_2006_19_37_41_+0100_UW99dMRaAfmI1mmG--
