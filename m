Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318526AbSGaW4l>; Wed, 31 Jul 2002 18:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318538AbSGaW4l>; Wed, 31 Jul 2002 18:56:41 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:46610 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318526AbSGaW4k>; Wed, 31 Jul 2002 18:56:40 -0400
Date: Thu, 1 Aug 2002 00:00:03 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [PATCH] console part 2.
Message-ID: <20020801000003.A24516@flint.arm.linux.org.uk>
References: <Pine.LNX.4.44.0207311523540.21567-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0207311523540.21567-100000@www.transvirtual.com>; from jsimmons@transvirtual.com on Wed, Jul 31, 2002 at 03:27:57PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2002 at 03:27:57PM -0700, James Simmons wrote:
> Here is the second patch. It has many fixes and alot of major changes
> internally.

A quick read through reveals:

-		printk("mdacon: MDA card not detected.\n");
+		printk("KERN_WARNING mdacon: MDA card not detected.\n");

KERN_WARNING and friends should be outside the quotes.

Secondly, the absolutely gigantic "switch (vc_state) {" stuff with
extra layers of switch statements below it in decvte.c - I find this
rather disgusting to read.  I bet the resulting asm is also disgusting.
Isn't there a cleaner solution to this?  (I've been carrying around
since 2.2 patches to the console layer to split this up mainly because
some older versions of ARM gcc choked on it.  I'm not certain about
current versions though.)

Also, something that should probably be fixed one day, but I wouldn't
call it a show stopper:

-#define SIZE(x) (sizeof(x)/sizeof((x)[0]))
+#define SIZE(x)	(sizeof(x)/sizeof((x)[0]))

We have ARRAY_SIZE(x) in linux/kernel.h which does this already.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

