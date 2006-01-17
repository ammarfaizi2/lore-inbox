Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbWAQJIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbWAQJIu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 04:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWAQJIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 04:08:50 -0500
Received: from ik55118.ikexpress.com ([213.246.55.118]:13973 "EHLO
	ik55118.ikexpress.com") by vger.kernel.org with ESMTP
	id S932362AbWAQJIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 04:08:49 -0500
Message-ID: <43CCB3E5.5090302@free-electrons.com>
Date: Tue, 17 Jan 2006 10:07:49 +0100
From: Michael Opdenacker <michael-lists@free-electrons.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [ketchup] Fix for the install_nearest function
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For people managing kernel sources with the excellent 'ketchup' tool 
(http://www.selenic.com/ketchup/wiki/index.cgi/FrontPage)

A full version containing my 2 fixes is available on 
http://free-electrons.com/pub/patches/ketchup/ketchup-0.9.6-latest-fixes

Patch for ketchup 0.9.6
=======================

>From Michael Opdenacker <michael@free-electrons.com>

Issue
-----

> ketchup 2.6-git
None -> 2.6.15-git9
Downloading linux-2.6.15.tar.bz2
--18:17:52--  http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.15.tar.bz2
           => `/home/mike/.ketchup/linux-2.6.15.tar.bz2.partial'
Resolving www.kernel.org... 204.152.191.5, 204.152.191.37
Connecting to www.kernel.org|204.152.191.5|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 39,832,836 (38M) [application/x-bzip2]

100%[==============================================================================================================================>]
39,832,836    24.11K/s    ETA 00:00

18:24:44 (94.56 KB/s) - `/home/mike/.ketchup/linux-2.6.15.tar.bz2.partial'
saved [39832836/39832836]

DEBUG: f, sign /home/mike/.ketchup/linux-2.6.15.tar.bz2 1
Traceback (most recent call last):
  File "/data/soft/bin/ketchup", line 738, in ?
    transform(a, b)
  File "/data/soft/bin/ketchup", line 507, in transform
    a = install_nearest(base(b))
  File "/data/soft/bin/ketchup", line 475, in install_nearest
    f = trydownload([url], f, 1)
  File "/data/soft/bin/ketchup", line 357, in trydownload
    if not sign or verify(url, f, sign):
  File "/data/soft/bin/ketchup", line 336, in verify
    sf = f + sign
TypeError: cannot concatenate 'str' and 'int' objects

Explanation
-----------

As shown above, 'try_download' is called with its 'sign'
argument set to '1'.

However, 'sign' is supposed to be the extension
of the signature file. The '1' value means the
default extension (".sign") in the 'version_info'
definition, but can't be passed as such
to 'try_download'.

Proposed fix
------------

http://free-electrons.com/pub/patches/ketchup/20060113a/ketchup-sign-fix.patch

Caution: just tested with 2.6-git. I may have missed something important.

-- 
Michael Opdenacker, Free Electrons
Free Embedded Linux Training Materials
on http://free-electrons.com/training

