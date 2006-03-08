Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932523AbWCHJIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523AbWCHJIb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 04:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbWCHJIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 04:08:30 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:16391 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932523AbWCHJI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 04:08:29 -0500
Date: Wed, 8 Mar 2006 10:08:27 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Latchesar Ionkov <lucho@ionkov.net>
Cc: linux-kernel@vger.kernel.org, ericvh@ericvh.myip.org
Subject: [-mm patch] add a prototype for v9fs_printfcall()
Message-ID: <20060308090827.GA4006@stusta.de>
References: <20060307021929.754329c9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060307021929.754329c9.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2006 at 02:19:29AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.16-rc3-mm2:
>...
> +v9fs-print-9p-messages.patch
>...
>  Misc updates and fixes
>...

If you create a function in one file and call them from another file you 
need a prototype in a header file or bad runtime errors can occur in 
some cases.

You mustn't ignore warnings about implicitely defined functions.
This bug was found by the gcc -Werror-implicit-function-declaration flag 
that turns such warnings into errors.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc5-mm3-full/fs/9p/9p.h.old	2006-03-07 13:31:13.000000000 +0100
+++ linux-2.6.16-rc5-mm3-full/fs/9p/9p.h	2006-03-07 13:32:08.000000000 +0100
@@ -372,3 +372,6 @@
 int v9fs_t_write(struct v9fs_session_info *v9ses, u32 fid, u64 offset,
 		 u32 count, const char __user * data,
 		 struct v9fs_fcall **rcall);
+
+int v9fs_printfcall(char *buf, int buflen, struct v9fs_fcall *fc, int extended);
+

