Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286116AbRLIAdd>; Sat, 8 Dec 2001 19:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286111AbRLIAdW>; Sat, 8 Dec 2001 19:33:22 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:24013 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S284733AbRLIAdG>;
	Sat, 8 Dec 2001 19:33:06 -0500
From: David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15378.45358.807039.55719@napali.hpl.hp.com>
Date: Sat, 8 Dec 2001 16:32:46 -0800
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: davidm@hpl.hp.com, marcelo@conectiva.com.br (Marcelo Tosatti),
        akpm@zip.com.au (Andrew Morton), j-nomura@ce.jp.nec.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.16 kernel/printk.c (per processorinitializationcheck)
In-Reply-To: <E16CoLL-0002bW-00@the-village.bc.nu>
In-Reply-To: <15378.17075.960942.357075@napali.hpl.hp.com>
	<E16CoLL-0002bW-00@the-village.bc.nu>
X-Mailer: VM 6.76 under Emacs 20.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sat, 8 Dec 2001 20:45:07 +0000 (GMT), Alan Cox <alan@lxorguk.ukuu.org.uk> said:

  Alan> x86_udelay_tsc wont have been set at that point so the main
  Alan> timer is still being used.

  >>  x86 does use current_cpu_data.loops_per_jiffy in the non-TSC
  >> case, no?

  Alan> I believe so.  So we should propogate that across earlier,
  Alan> although its not needed for our current console drivers that I
  Alan> can see

I don't think you can do it early enough.  calibrate_delay() requires
irqs to be enabled and the first printk() happens long before irqs are
enabled on an AP.

	--david
