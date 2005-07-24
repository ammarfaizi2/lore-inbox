Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbVGXGLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbVGXGLK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 02:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbVGXGLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 02:11:10 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:34500 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S261693AbVGXGLI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 02:11:08 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Johannes Stezenbach <js@linuxtv.org>, Adrian Bunk <bunk@stusta.de>
Subject: Re: Why build empty object files in drivers/media? 
In-reply-to: Your message of "Fri, 22 Jul 2005 19:46:00 GMT."
             <20050722194600.GA8757@mars.ravnborg.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 24 Jul 2005 16:10:13 +1000
Message-ID: <3945.1122185413@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jul 2005 19:46:00 +0000, 
Sam Ravnborg <sam@ravnborg.org> wrote:
>On Thu, Jul 21, 2005 at 11:06:21PM -0400, Chuck Ebbert wrote:
>> 
>> I have this in my .config file for 2.6.13-rc3:
>> 
>> 
>> #
>> # Multimedia devices
>> #
>> # CONFIG_VIDEO_DEV is not set
>> 
>> #
>> # Digital Video Broadcasting Devices
>> #
>> # CONFIG_DVB is not set
>> 
>> 
>> And yet these completely empty files are being built:
>> 
>> ...
>kbuild is told to visit these directories - and then it build an empty
>.o file to make linking step possible.
>The only solution is to tell kbuild not to visit these directories
>unless they are in real use.
>Following untested patch should do the trick. But the media people must
>check if before being applied since I have only taken a brief look at
>the Kconfig and Makefile files.
>
>	Sam
>
>diff --git a/drivers/media/Makefile b/drivers/media/Makefile
>--- a/drivers/media/Makefile
>+++ b/drivers/media/Makefile
>@@ -2,4 +2,7 @@
> # Makefile for the kernel multimedia device drivers.
> #
> 
>-obj-y        := video/ radio/ dvb/ common/
>+obj-y                   := common/
>+obj-$(CONFIG_VIDEO_DEV) := video/
>+obj-$(CONFIG_VIDEO_DEV) := radio/
>+obj-$(CONFIG_DVB)       := dvb/

That should be +=, not :=

+obj-$(CONFIG_VIDEO_DEV) += video/
+obj-$(CONFIG_VIDEO_DEV) += radio/
+obj-$(CONFIG_DVB)       += dvb/

