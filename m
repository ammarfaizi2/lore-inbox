Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWFUVPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWFUVPX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 17:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWFUVPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 17:15:23 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:3510 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1750738AbWFUVPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 17:15:22 -0400
Date: Wed, 21 Jun 2006 18:15:13 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Pete Zaitcev <zaitcev@redhat.com>, gregkh@suse.de,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: Serial-Core: USB-Serial port current issues.
Message-ID: <20060621181513.235fc23c@doriath.conectiva>
In-Reply-To: <20060621164336.GD24265@flint.arm.linux.org.uk>
References: <20060613192829.3f4b7c34@home.brethil>
	<20060614152809.GA17432@flint.arm.linux.org.uk>
	<20060620161134.20c1316e@doriath.conectiva>
	<20060620193233.15224308.zaitcev@redhat.com>
	<20060621133500.18e82511@doriath.conectiva>
	<20060621164336.GD24265@flint.arm.linux.org.uk>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.9.3; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006 17:43:36 +0100
Russell King <rmk+lkml@arm.linux.org.uk> wrote:

| In the uart_update_mctrl() case, the purpose of the locking is to
| prevent two concurrent changes to the modem control state resulting
| in an inconsistency between the hardware and the software state.  If
| it's provable that it is always called from process context (and
| it isn't called from a lock_kernel()-section or the lock_kernel()
| section doesn't mind a rescheduling point being introduced there),
| there's no problem converting that to a mutex.

 Ok, then I can submit my debug patch to answer these questions.

 might_sleep() can catch the lock_kernel()-section case right?

| With get_mctrl(), the situation is slightly more complicated, because
| we need to atomically update tty->hw_stopped in some circumstances
| (that may also be modified from irq context.)  Therefore, to give
| the driver a consistent locking picture, the spinlock is _always_
| held.

 Is it too bad (wrong?) to only protect the tty->hw_stopped update
by the spinlock? Then the call to get_mctrl() could be protected by
a mutex, or is it messy?

-- 
Luiz Fernando N. Capitulino
