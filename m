Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbTJJPLV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 11:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262862AbTJJPLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 11:11:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:29921 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262861AbTJJPLR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 11:11:17 -0400
Date: Fri, 10 Oct 2003 08:02:12 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Miles Bader <miles@gnu.org>
Cc: miles@lsi.nec.co.jp, linux-kernel@vger.kernel.org
Subject: Re: initcall ordering of driver w/respect to tty_init?
Message-Id: <20031010080212.6ddb02ff.rddunlap@osdl.org>
In-Reply-To: <buo65j0f9vi.fsf@mcspd15.ucom.lsi.nec.co.jp>
References: <buo65j0f9vi.fsf@mcspd15.ucom.lsi.nec.co.jp>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08 Oct 2003 16:48:17 +0900 Miles Bader <miles@lsi.nec.co.jp> wrote:

| I have a tty driver, arch/v850/kernel/simcons.c, who's init function is
| called via __initcall:
| 
|    int __init simcons_tty_init (void)
|    {
|            struct tty_driver *driver = alloc_tty_driver(1);
|    ...
|            err = tty_register_driver(driver);
|    }
|    __initcall (simcons_tty_init);
| 
| I'm getting errors because this init function is being called _before_
| tty_init, and tty_kobj (which is the `parent' kobj of simcon's kobj) is
| apparently not setup correctly yet when the simcons_tty_init calls
| tty_register_driver.
| 
| Since there seems to be no way of ordering basic initcalls, I can see
| why it's happening.  But what's the proper way to avoid this?  Other
| tty drivers that call tty_register_driver also seem to get initialized
| via initcalls (usually declared with module_init), so maybe this
| problem exists for other drivers too.

Does it help/work to change it to a console_initcall() ?

--
~Randy
