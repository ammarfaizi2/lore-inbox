Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137033AbREKC3P>; Thu, 10 May 2001 22:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137034AbREKC3G>; Thu, 10 May 2001 22:29:06 -0400
Received: from deliverator.sgi.com ([204.94.214.10]:40255 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S137033AbREKC27>; Thu, 10 May 2001 22:28:59 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: rjd@xyzzy.clara.co.uk
cc: linux-kernel@vger.kernel.org
Subject: Re: Detecting Red Hat builds ? 
In-Reply-To: Your message of "Thu, 10 May 2001 17:25:29 +0100."
             <200105101625.f4AGPTh02433@xyzzy.clara.co.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 11 May 2001 12:28:32 +1000
Message-ID: <29401.989548112@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 May 2001 17:25:29 +0100 (BST), 
rjd@xyzzy.clara.co.uk wrote:
>The problem is I have a driver that includes syncppp.h which in the releases
>from kernel.org is in linux/drivers/net/wan/ up to and including 2.4.2 after
>which it moves to linux/include/net/.

Do it in the Makefile.  Untested:

ifneq ($(wildcard $(TOPDIR)/include/net/syncppp.h),)
  CFLAGS_driver_name.o += -I $(TOPDIR)/include/net
else
  CFLAGS_driver_name.o += -I $(TOPDIR)/drivers/net/wan
endif

and the driver does #include "syncppp.h".

