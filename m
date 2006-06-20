Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbWFTTLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWFTTLl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 15:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWFTTLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 15:11:41 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:48785 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1750802AbWFTTLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 15:11:40 -0400
Date: Tue, 20 Jun 2006 16:11:34 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: gregkh@suse.de, zaitcev@redhat.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: Serial-Core: USB-Serial port current issues.
Message-ID: <20060620161134.20c1316e@doriath.conectiva>
In-Reply-To: <20060614152809.GA17432@flint.arm.linux.org.uk>
References: <20060613192829.3f4b7c34@home.brethil>
	<20060614152809.GA17432@flint.arm.linux.org.uk>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 2.3.0 (GTK+ 2.9.3; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2006 16:28:09 +0100
Russell King <rmk+lkml@arm.linux.org.uk> wrote:

| On Tue, Jun 13, 2006 at 07:28:29PM -0300, Luiz Fernando N. Capitulino wrote:
| >  I took a look in the Serial Core code and didn't see why set_termios()
| > and break_ctl() (plus tx_empty()) are not allowed to sleep: they doesn't
| > seem to run in atomic context. So, are they allowed to sleep? Isn't the
| > documentation out of date? I've even submitted a patch to fix it [2].
| 
| You are correct - and I will eventually apply your patch.  At the
| moment, I'm throttling back on applying patches so that 2.6.17 can
| finally appear (I don't want to be responsible for Linus saying
| again "too many changes for -final, let's do another -rc".)
| 
| >  For get_mctrl() and set_mctrl() it seems possible to switch from a
| > spinlock to a mutex, as they are not called from an interrupt context.
| > Is this really possible? Would you agree with this change?
| 
| I don't know - that depends whether the throttle/unthrottle driver
| methods are ever called from interrupt context or not.
| 
| What we could do is put a WARN_ON() or might_sleep() in there and
| find out over time if they are called from non-process context.

 Ok, I've put a WARN_ON(in_interrupt()) (as suggested by Greg) in
all the functions which grabs the 'port->lock' spinlock and didn't
get anything with my tests (PPP through a standard modem, serial
console and other simple tests).

 I could submit that debug patch to Andrew, but now I'm wondering
whether the switch is really possible (considering, of course, that
those functions are not called from interrupt context).

 Pete, was it your original idea to completely move from the spinlock
to a mutex?

-- 
Luiz Fernando N. Capitulino
