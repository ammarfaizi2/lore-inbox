Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268804AbTBZQ1i>; Wed, 26 Feb 2003 11:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268805AbTBZQ1i>; Wed, 26 Feb 2003 11:27:38 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:2229 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S268804AbTBZQ1f>; Wed, 26 Feb 2003 11:27:35 -0500
Date: Wed, 26 Feb 2003 17:37:38 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] Use hex numbers in fs/block_dev.c
Message-ID: <20030226163738.GA15555@wohnheim.fh-wedel.de>
References: <200302261719.15884@bilbo.math.uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200302261719.15884@bilbo.math.uni-mannheim.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 February 2003 17:19:15 +0100, Rolf Eike Beer wrote:
> 
> We're using hex numbers to identify devices in most places. We should use
> them in filesystem messages, errors etc. too, this would be much more
> consistent and avoids things like this where two different naming styles
> for the same error are used:
> 
>      end_request: [...] dev 16:45 (hdd), sector 9175248
>      EXT3-fs error (device ide1(22,69)): [...] inode=575269, block=1146906
> 
> With this patch the second message would look like this:
> 
>      EXT3-fs error (device ide1(16:45)): [...] inode=575269, block=1146906

Whis is _horrible_. Am I supposed to guess that ide does not use major
16, so it will be 0x16 == 22 instead?

Better use the patch below, if at all.

--- linux-2.5.63-eike/fs/block_dev.c.orig	Tue Feb 25 08:15:45 2003
+++ linux-2.5.63-eike/fs/block_dev.c	Wed Feb 26 16:04:28 2003
@@ -794,7 +794,7 @@
 	if (!name)
 		name = "unknown-block";
 
-	sprintf(buffer, "%s(%d,%d)", name, MAJOR(dev), MINOR(dev));
+	sprintf(buffer, "%s(0x%x:0x%x)", name, MAJOR(dev), MINOR(dev));
 	return buffer;
 }

Jörn

-- 
Courage is not the absence of fear, but rather the judgement that
something else is more important than fear.
-- Ambrose Redmoon
