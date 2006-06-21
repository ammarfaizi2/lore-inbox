Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbWFUSpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbWFUSpx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 14:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWFUSpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 14:45:53 -0400
Received: from terminus.zytor.com ([192.83.249.54]:18832 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932314AbWFUSpx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 14:45:53 -0400
Message-ID: <449993D4.8030309@zytor.com>
Date: Wed, 21 Jun 2006 11:45:40 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Paul Drynoff <pauldrynoff@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [BUG]: 2.6.17-mm1 can not compile - infinite cycle
References: <20060621224600.aaa03fdc.pauldrynoff@gmail.com>
In-Reply-To: <20060621224600.aaa03fdc.pauldrynoff@gmail.com>
Content-Type: multipart/mixed;
 boundary="------------060407080907040907010707"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060407080907040907010707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Paul Drynoff wrote:
> I try compile 2.6.17-mm1 with almost(make oldconfig) the same config as 
> linux-2.6.17-rc6-mm2.

I just pushed out this bugfix for this condition.

	-hpa

--------------060407080907040907010707
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

[klibc] Fix incorrect dependency

Remove a bogus dependency which would cause circular rebuilds at
high -j levels.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit 540f76e3b9d0272b50e2cc9be086b1f77606cc58
tree 636ac799e7517bb954e66a8eebb6adbcdd7b21d8
parent 52a83f25c64f52abb81c6e93977cf00247176e1b
author H. Peter Anvin <hpa@zytor.com> Wed, 21 Jun 2006 11:36:58 -0700
committer H. Peter Anvin <hpa@zytor.com> Wed, 21 Jun 2006 11:36:58 -0700

 usr/klibc/syscalls/Kbuild |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/usr/klibc/syscalls/Kbuild b/usr/klibc/syscalls/Kbuild
index e7ae1d2..a1d408d 100644
--- a/usr/klibc/syscalls/Kbuild
+++ b/usr/klibc/syscalls/Kbuild
@@ -64,7 +64,6 @@ quiet_cmd_syscalsz = GEN     $@
 
 $(obj)/typesize.c: $(KLIBCSRC)/syscalls.pl $(obj)/SYSCALLS.i \
                       $(KLIBCSRC)/arch/$(KLIBCARCHDIR)/sysstub.ph \
-                      $(call objectify, $(syscall-objs:.o=.S)) \
                       $(src)/syscommon.h $(obj)/syscalls.nrs FORCE
 	$(call if_changed,syscalsz)
 



!-------------------------------------------------------------flip-



--------------060407080907040907010707--
