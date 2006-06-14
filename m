Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbWFNUi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWFNUi3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 16:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWFNUi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 16:38:29 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:63897 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S932255AbWFNUi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 16:38:29 -0400
Date: Wed, 14 Jun 2006 17:38:24 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: gregkh@suse.de, zaitcev@redhat.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: Serial-Core: USB-Serial port current issues.
Message-ID: <20060614173824.60d1bc2e@doriath.conectiva>
In-Reply-To: <20060614152809.GA17432@flint.arm.linux.org.uk>
References: <20060613192829.3f4b7c34@home.brethil>
	<20060614152809.GA17432@flint.arm.linux.org.uk>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 2.2.3 (GTK+ 2.9.2; i586-mandriva-linux-gnu)
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

 Oh, ok, no worries.

| >  For get_mctrl() and set_mctrl() it seems possible to switch from a
| > spinlock to a mutex, as they are not called from an interrupt context.
| > Is this really possible? Would you agree with this change?
| 
| I don't know - that depends whether the throttle/unthrottle driver
| methods are ever called from interrupt context or not.
| 
| What we could do is put a WARN_ON() or might_sleep() in there and
| find out over time if they are called from non-process context.

 I think BUG_ON(in_interrupt()) does the job. I'll try it here, and
if it doesn't trigger I'll submit a patch to Andrew only for
testing porpuses (ie, not for mainline).

 Thanks a lot for the feedback, Russell.

-- 
Luiz Fernando N. Capitulino
