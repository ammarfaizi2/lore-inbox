Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285719AbRLHBKq>; Fri, 7 Dec 2001 20:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285720AbRLHBKg>; Fri, 7 Dec 2001 20:10:36 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:53969 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S285719AbRLHBKV>;
	Fri, 7 Dec 2001 20:10:21 -0500
From: David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15377.26745.265632.705793@napali.hpl.hp.com>
Date: Fri, 7 Dec 2001 17:10:17 -0800
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: David Mosberger <davidm@hpl.hp.com>, Andrew Morton <akpm@zip.com.au>,
        j-nomura@ce.jp.nec.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.16 kernel/printk.c (per processorinitializationcheck)
In-Reply-To: <Pine.LNX.4.21.0112071906430.22884-100000@freak.distro.conectiva>
In-Reply-To: <15377.16385.380923.588249@napali.hpl.hp.com>
	<Pine.LNX.4.21.0112071906430.22884-100000@freak.distro.conectiva>
X-Mailer: VM 6.76 under Emacs 20.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 7 Dec 2001 19:09:03 -0200 (BRST), Marcelo Tosatti <marcelo@conectiva.com.br> said:

  >> I'm not entirely sure whether this particular problem is
  >> architecture specific.  Perhaps it is and, if so, I'm certainly
  >> happy to fix it in the ia64 specific code. However, are you
  >> really 100% certain that on x86 there are no console drivers
  >> which in some fashion depend on cpu_init() having completed
  >> execution?  Note that the x86 version of cpu_init() also has
  >> printk()s.  If you're not certain of this, the AP startup problem
  >> could occur on x86, too.  I haven't looked at all the other
  >> platforms, but I suspect similar things will be true, there.

  Marcelo> Prove, please. If you show me it can also happen on other
  Marcelo> architectures, I'll be glad to apply the patch.

I'm no x86 expert, but I have the impression that
current_cpu_data.loops_per_jiffy will be invalid (probably 0) until
smp_store_cpu_info() is called in smp_callin().  If so, a console
driver using udelay() might not work properly.  I suspect there are
other issues, but this is just based on looking at the x86 source code
for 5 minutes.

	--david
