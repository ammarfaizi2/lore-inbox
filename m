Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030273AbVLFWsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030273AbVLFWsS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 17:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030281AbVLFWsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 17:48:18 -0500
Received: from mail1.kontent.de ([81.88.34.36]:57986 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S1030273AbVLFWsR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 17:48:17 -0500
From: Oliver Neukum <oliver@neukum.org>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: [PATCH 00/10] usb-serial: Switches from spin lock to atomic_t.
Date: Tue, 6 Dec 2005 23:48:14 +0100
User-Agent: KMail/1.8
Cc: Eduardo Pereira Habkost <ehabkost@mandriva.com>, Greg KH <gregkh@suse.de>,
       Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>,
       linux-kernel@vger.kernel.org
References: <20051206095610.29def5e7.lcapitulino@mandriva.com.br> <20051206194041.GA22890@suse.de> <20051206201340.GB20451@duckman.conectiva>
In-Reply-To: <20051206201340.GB20451@duckman.conectiva>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512062348.14349.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 6. Dezember 2005 21:13 schrieb Eduardo Pereira Habkost:
> Anyway, I don't see yet why the atomic_t would make the code slower on
> non-smp. Is atomic_add_unless(v, 1, 1) supposed to be slower than
> 'if (!v) v = 1;' ?

spin_lock() can be dropped on UP. atomic_XXX must either use an operation
on main memory, meaning less efficient code generation, or must disable
interrupts even on UP.

	Regards
		Oliver
