Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272966AbRIPW6c>; Sun, 16 Sep 2001 18:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273147AbRIPW6X>; Sun, 16 Sep 2001 18:58:23 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:16627
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S272966AbRIPW6R>; Sun, 16 Sep 2001 18:58:17 -0400
Date: Sun, 16 Sep 2001 15:58:35 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Define conflict between ext3 and raid patches against 2.2.19
Message-ID: <20010916155835.C24067@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm trying to setup a 2.2 kernel that I can use for comparison to the latest
2.4 kernels I've been testing, but I came accross a little problem with the
patches I've been trying to combine.

I've already applied:
ide.2.2.19.05042001.patch
linux-2.2.19.kdb.diff
linux-2.2.19.ext3.diff

And now I'm trying to apply raid-2.2.19-A1, and I get one reject in
include/linux/fs.h.

***************
*** 191,197 ****
  #define BH_Req		3	/* 0 if the buffer has been invalidated */
  #define BH_Protected	6	/* 1 if the buffer is protected */
  #define BH_Wait_IO	7	/* 1 if we should throttle on this buffer */

  /*
   * Try to keep the most commonly used fields in single cache lines (16
--- 191,196 ----
  #define BH_Req		3	/* 0 if the buffer has been invalidated */
  #define BH_Protected	6	/* 1 if the buffer is protected */
  #define BH_Wait_IO	7	/* 1 if we should throttle on this buffer */
+ #define BH_LowPrio	8	/* 1 if the buffer is lowprio */
  
  /*
   * Try to keep the most commonly used fields in single cache lines (16

Now I have two defines from different patches for the same bit.  The top
line is from RAID, and bottom is of ext3 origin.

#define BH_LowPrio	8	/* 1 if the buffer is lowprio */
#define BH_Temp         8       /* 1 if the buffer is temporary (unlinked)

Is this a fatal conflict?  How can I resolve this?

Mike
