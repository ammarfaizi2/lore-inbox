Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264134AbTF0KVM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 06:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264146AbTF0KVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 06:21:12 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:24891 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264134AbTF0KVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 06:21:10 -0400
Subject: Re: O_DIRECT
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alan Cox <alan@redhat.com>
Cc: Stephen Tweedie <sct@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1056706819.2418.11.camel@sisko.scot.redhat.com>
References: <200306262021.h5QKLhN10771@devserv.devel.redhat.com>
	 <1056706819.2418.11.camel@sisko.scot.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056710121.2418.19.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 Jun 2003 11:35:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Fri, 2003-06-27 at 10:40, Stephen C. Tweedie wrote:

> On Thu, 2003-06-26 at 21:21, Alan Cox wrote:
> > So its now confirmed with 3 distros, two file systems and several 
> > compilers. It certainly seems to be the O_DIRECT patches but I'll pull
> > the back out for the next -ac and check I guess

Ouch ouch ouch, there's nasty merge conflict between the O_DIRECT patch
and an existing 64-bit rlimit chunk in -ac3.  You really, really want
the change below. :-)  Marcelo's tree appears OK, and this is a common
code path for all filesystems in -ac, so it matches the failure patterns
that far.

Cheers,
 Stephen

--- mm/filemap.c.~1~	2003-06-27 09:58:08.000000000 +0100
+++ mm/filemap.c	2003-06-27 11:13:07.000000000 +0100
@@ -2995,8 +2995,8 @@
 		}
 		/* Fix this up when we got to rlimit64 */
 		if (pos > 0xFFFFFFFFULL)
-			count = 0;
-		else if(count > limit - (u32)pos) {
+			*count = 0;
+		else if(*count > limit - (u32)pos) {
 			/* send_sig(SIGXFSZ, current, 0); */
 			*count = limit - (u32)pos;
 		}


