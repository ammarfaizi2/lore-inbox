Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbVGVSNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVGVSNg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 14:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbVGVSN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 14:13:26 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:43093 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261319AbVGVSMF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 14:12:05 -0400
Date: Fri, 22 Jul 2005 19:46:00 +0000
From: Sam Ravnborg <sam@ravnborg.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Johannes Stezenbach <js@linuxtv.org>, Adrian Bunk <bunk@stusta.de>
Subject: Re: Why build empty object files in drivers/media?
Message-ID: <20050722194600.GA8757@mars.ravnborg.org>
References: <200507212309_MC3-1-A534-95EE@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507212309_MC3-1-A534-95EE@compuserve.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2005 at 11:06:21PM -0400, Chuck Ebbert wrote:
> 
> I have this in my .config file for 2.6.13-rc3:
> 
> 
> #
> # Multimedia devices
> #
> # CONFIG_VIDEO_DEV is not set
> 
> #
> # Digital Video Broadcasting Devices
> #
> # CONFIG_DVB is not set
> 
> 
> And yet these completely empty files are being built:
> 
> ...
kbuild is told to visit these directories - and then it build an empty
.o file to make linking step possible.
The only solution is to tell kbuild not to visit these directories
unless they are in real use.
Following untested patch should do the trick. But the media people must
check if before being applied since I have only taken a brief look at
the Kconfig and Makefile files.

	Sam

diff --git a/drivers/media/Makefile b/drivers/media/Makefile
--- a/drivers/media/Makefile
+++ b/drivers/media/Makefile
@@ -2,4 +2,7 @@
 # Makefile for the kernel multimedia device drivers.
 #
 
-obj-y        := video/ radio/ dvb/ common/
+obj-y                   := common/
+obj-$(CONFIG_VIDEO_DEV) := video/
+obj-$(CONFIG_VIDEO_DEV) := radio/
+obj-$(CONFIG_DVB)       := dvb/
