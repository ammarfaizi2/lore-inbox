Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315779AbSEZIA4>; Sun, 26 May 2002 04:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315784AbSEZIAz>; Sun, 26 May 2002 04:00:55 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:26884 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315779AbSEZIAz>; Sun, 26 May 2002 04:00:55 -0400
Date: Sun, 26 May 2002 09:00:47 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: A Guy Called Tyketto <tyketto@wizard.com>
Cc: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.18-dj1
Message-ID: <20020526090046.A32058@flint.arm.linux.org.uk>
In-Reply-To: <20020526014439.GA19527@suse.de> <20020526075314.GA1307@wizard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 26, 2002 at 12:53:14AM -0700, A Guy Called Tyketto wrote:
> >>EIP; c01cbd2d <fb_copy_cmap+9d/2b0>   <=====

This oops has existed over several 2.5 versions.  The following was thrown
around to fix it (I don't remember who though).

--- orig/drivers/video/fbcmap.c	Fri May  3 11:12:44 2002
+++ linux/drivers/video/fbcmap.c	Fri May 10 19:39:38 2002
@@ -150,9 +150,9 @@
     else
 	tooff = from->start-to->start;
     size = to->len-tooff;
-    if (size > from->len-fromoff)
+    if (size > (int)(from->len-fromoff))
 	size = from->len-fromoff;
-    if (size < 0)
+    if (size <= 0)
 	return;
     size *= sizeof(u16);
     


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

