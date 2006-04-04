Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750867AbWDDU72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbWDDU72 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 16:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbWDDU72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 16:59:28 -0400
Received: from xenotime.net ([66.160.160.81]:40091 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750863AbWDDU72 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 16:59:28 -0400
Date: Tue, 4 Apr 2006 14:01:40 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, drepper@redhat.com,
       mtk-manpages@gmx.net, nickpiggin@yahoo.com.au
Subject: Re: [patch 1/1] sys_sync_file_range()
Message-Id: <20060404140140.f13b8606.rdunlap@xenotime.net>
In-Reply-To: <20060404205055.GA5745@agluck-lia64.sc.intel.com>
References: <200603300741.k2U7fQLe002202@shell0.pdx.osdl.net>
	<20060404205055.GA5745@agluck-lia64.sc.intel.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Apr 2006 13:50:55 -0700 Luck, Tony wrote:

> On Wed, Mar 29, 2006 at 11:41:11PM -0800, akpm@osdl.org wrote:
> > @@ -318,8 +318,9 @@
> >  #define __NR_unshare		310
> >  #define __NR_set_robust_list	311
> >  #define __NR_get_robust_list	312
> > +#define __NR_sys_sync_file_range 313
> 
> What's up with the __NR_sys_yada_yada?  Except for recent entries (kexec,
> splice, and now sync_file_range) all of the other names in here have
> dropped the "sys_".
> 
> Is it too late to fix __NR_sys_kexec_load (since it is out in the
> wild now?)

already been done:  (copy-n-paste warning here:)
~~~~~

On i386, we don't use sys_ prefix for __NR_*. This patch removes it.
[FWIW, _syscall*() macros will generate foo() instead of sys_foo().]

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 include/asm-i386/unistd.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN include/asm-i386/unistd.h~remove-sys_-prefix include/asm-i386/unistd.h
--- linux-2.6/include/asm-i386/unistd.h~remove-sys_-prefix	2006-04-02 05:23:57.000000000 +0900
+++ linux-2.6-hirofumi/include/asm-i386/unistd.h	2006-04-02 05:24:10.000000000 +0900
@@ -318,8 +318,8 @@
 #define __NR_unshare		310
 #define __NR_set_robust_list	311
 #define __NR_get_robust_list	312
-#define __NR_sys_splice		313
-#define __NR_sys_sync_file_range 314
+#define __NR_splice		313
+#define __NR_sync_file_range	314
 
 #define NR_syscalls 315


---
~Randy
