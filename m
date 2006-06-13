Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbWFMWZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWFMWZN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 18:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWFMWZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 18:25:13 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:60598 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S932315AbWFMWZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 18:25:11 -0400
Date: Tue, 13 Jun 2006 19:28:29 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: rmk+serial@arm.linux.org.uk
Cc: gregkh@suse.de, zaitcev@redhat.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Serial-Core: USB-Serial port current issues.
Message-ID: <20060613192829.3f4b7c34@home.brethil>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi Russell,

 I'm working on the port of the USB-Serial layer to the Serial Core [1],
and turns out that most of the USB-Serial drivers does need to sleep in
set_termios(), break_ctl(), get_mctrl() and set_mctrl() calls (which are
not allowed to sleep according to the documentation).

 I took a look in the Serial Core code and didn't see why set_termios()
and break_ctl() (plus tx_empty()) are not allowed to sleep: they doesn't
seem to run in atomic context. So, are they allowed to sleep? Isn't the
documentation out of date? I've even submitted a patch to fix it [2].

 For get_mctrl() and set_mctrl() it seems possible to switch from a spinlock
to a mutex, as they are not called from an interrupt context. Is this
really possible? Would you agree with this change?

 Please, note that your opnion is very important. Both issues makes
the port not possible.

 Thanks.

[1] http://distro2.conectiva.com.br/~lcapitulino/patches/usbserial/2.6.17-rc5/serialcore-port-V0/
[2] http://marc.theaimsgroup.com/?l=linux-kernel&m=114979748706523&w=2

-- 
Luiz Fernando N. Capitulino
