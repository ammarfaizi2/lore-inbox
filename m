Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbVLFMhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbVLFMhn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 07:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbVLFMhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 07:37:43 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:14998 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1751381AbVLFMhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 07:37:43 -0500
Date: Tue, 6 Dec 2005 10:37:29 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: Arjan van de Ven <arjan@infradead.org>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, ehabkost@mandriva.com
Subject: Re: [PATCH 01/10] usb-serial: URB write locking macros.
Message-Id: <20051206103729.6c4ee2b7.lcapitulino@mandriva.com.br>
In-Reply-To: <1133871843.4836.15.camel@laptopd505.fenrus.org>
References: <20051206095722.45cf4a32.lcapitulino@mandriva.com.br>
	<1133871843.4836.15.camel@laptopd505.fenrus.org>
Organization: Mandriva
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi Arjan,

On Tue, 06 Dec 2005 13:24:03 +0100
Arjan van de Ven <arjan@infradead.org> wrote:

| On Tue, 2005-12-06 at 09:57 -0200, Luiz Fernando Capitulino wrote:
| >  Introduces URB write locking macros.
| 
| ugh.. WHY ?

 Because is easier to read/understand:

	if (usb_serial_write_urb_lock(port)) {
		dbg("%s - already writing", __FUNCTION__);
		return 0;
	}

 than:

	if (!atomic_add_unless(&port->write_urb_busy, 1, 1)) {
		dbg("%s - already writing", __FUNCTION__);
		return 0;
	}

 IMHO.

 Of course I'm only ilustrating the 'lock' scenario, but you will have other
atomic functions spread in the driver.

 Looks better to have some macros to make clear what you're doing.

-- 
Luiz Fernando N. Capitulino
