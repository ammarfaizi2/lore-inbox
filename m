Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265485AbRFVSvo>; Fri, 22 Jun 2001 14:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265486AbRFVSve>; Fri, 22 Jun 2001 14:51:34 -0400
Received: from mercury.Sun.COM ([192.9.25.1]:40091 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S265485AbRFVSvW>;
	Fri, 22 Jun 2001 14:51:22 -0400
Message-ID: <3B339380.C0D973CB@sun.com>
Date: Fri, 22 Jun 2001 11:50:40 -0700
From: Tim Hockin <thockin@sun.com>
Organization: Sun Microsystems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: /dev/nvram driver
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Who is maintaining the /dev/nvram driver?  I have a couple things I want to
suggest/ask.  

Currently it tracks O_EXCL on open() and sets a flag, whereby no other
open() calls can succeed.  Is this functionality really needed?  Perhaps it
should just be a reader/writer model : n readers or 1 writer.  In that
case, should open() block on a writer, or return -EBUSY?

nvram_release() calls lock_kernel() - any particular reason?

various other bits (nvram_open_cnt, for example) are not SMP safe.  I'm
making sure it is safe now.

What I really want to know is: should I bother making nvram_open_cnt SMP
safe, or should it just go away all together.  I vote for the latter
option, unless something depends on this behavior (in which case, other
fixes are needed, because it is broken :).

comments?


-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Cobalt Server Appliances
thockin@sun.com
