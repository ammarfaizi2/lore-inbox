Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751075AbWFEVwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbWFEVwN (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 17:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbWFEVwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 17:52:12 -0400
Received: from wx-out-0102.google.com ([66.249.82.201]:35588 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751068AbWFEVwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 17:52:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=XPszmjAAiRTiyUxRPvt81anL5BBycSKLdZyGntO0ZyjrvHdNkn1fVccOBwJ96PAIJXQsTG6D7lJLKYB9KEl39C+KGaiD81ojiUGGKdVnnO8LFKoWwSuNN1bbqELSKBwKDFIgyexpbw5kWktXnG7maRn/JNZoQNZuxfKp8r+lN9k=
Message-ID: <986ed62e0606051452x320cce2ap9598558b5343ae6b@mail.gmail.com>
Date: Mon, 5 Jun 2006 14:52:11 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.17-rc5-mm1
Cc: "Laurent Riffard" <laurent.riffard@free.fr>, 76306.1226@compuserve.com,
        linux-kernel@vger.kernel.org, jbeulich@novell.com,
        "Ingo Molnar" <mingo@elte.hu>,
        "Arjan van de Ven" <arjan@linux.intel.com>
In-Reply-To: <20060605110046.2a7db23f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200606042101_MC3-1-C19B-1CF4@compuserve.com>
	 <20060604181002.57ca89df.akpm@osdl.org> <44840838.7030802@free.fr>
	 <4484584D.4070108@free.fr> <20060605110046.2a7db23f.akpm@osdl.org>
X-Google-Sender-Auth: 7befa9e90198e58f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/06, Andrew Morton <akpm@osdl.org> wrote:
> I guess we should force 8k stacks if the lockdep features are enabled.

Also, Laurent is running "2.6.17-rc5-mm3-lockdep" (per his previous
message), i.e., 2.6.17-rc5-mm3 with Ingo's lockdep-combo patch added.
If you're wondering how I conclude the latter from the former, look at
this hunk from the lockdep-combo patch:

--- linux.orig/Makefile
+++ linux/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 17
-EXTRAVERSION =-rc5-mm3
+EXTRAVERSION =-rc5-mm3-lockdep
 NAME=Lordi Rules

And from the same patch:

--- linux.orig/arch/i386/Makefile
+++ linux/arch/i386/Makefile
@@ -38,6 +38,10 @@ CFLAGS += $(call cc-option,-mpreferred-s
 include $(srctree)/arch/i386/Makefile.cpu

 cflags-$(CONFIG_REGPARM) += -mregparm=3
+#
+# Prevent tail-call optimizations, to get clearer backtraces:
+#
+cflags-$(CONFIG_FRAME_POINTER) += -fno-optimize-sibling-calls

 # temporary until string.h is fixed
 cflags-y += -ffreestanding

I would expect that to increase stack usage...
-- 
-Barry K. Nathan <barryn@pobox.com>
