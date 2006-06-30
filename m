Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbWF3L6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbWF3L6T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 07:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751783AbWF3L6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 07:58:19 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59050 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750894AbWF3L6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 07:58:19 -0400
Subject: Re: [linux-usb-devel] [PATCH] Airprime driver improvements to
	allow full speed EvDO transfers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sergei Organov <osv@javad.com>
Cc: Andrew Morton <akpm@osdl.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <874py2apca.fsf@javad.com>
References: <1151646482.3285.410.camel@tahini.andynet.net>
	 <20060630001021.2b49d4bd.akpm@osdl.org>  <874py2apca.fsf@javad.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 30 Jun 2006 13:13:48 +0100
Message-Id: <1151669628.31392.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-06-30 am 14:51 +0400, ysgrifennodd Sergei Organov:
> In fact, according to Alan Cox answer, the first call is useless here at
> all, i.e., tty_buffer_request_room() is for subsequent
> tty_insert_flip_char() calls in a loop, not for
> tty_insert_flip_string(). tty_insert_flip_string() calls
> tty_buffer_request_room() itself, and does it in a loop in attempt to
> find as much memory as possible.

Yep. Think of it as a hint that "I'm about to stuff xyz bytes into
memory" to get best memory efficiency.

> tty_insert_flip_string() returns number of bytes it has actually
> inserted, but I don't believe one can do much if it returns less than
> has been requested as it means that we are out of kernel memory.

Yes. I've been wondering if we should log the failure case somewhere,
either as a tty-> object or printk.

Alan

