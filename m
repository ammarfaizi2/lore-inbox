Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030613AbWBODXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030613AbWBODXp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 22:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030616AbWBODXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 22:23:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33742 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030613AbWBODXo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 22:23:44 -0500
Date: Tue, 14 Feb 2006 19:22:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Tilman Schmidt <tilman@imap.cc>
Cc: hjlipp@web.de, kkeil@suse.de, i4ldeveloper@listserv.isdn4linux.de,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: [PATCH 6/9] isdn4linux: Siemens Gigaset drivers - procfs
 interface
Message-Id: <20060214192232.126e6ab2.akpm@osdl.org>
In-Reply-To: <43F289F5.2080102@imap.cc>
References: <gigaset307x.2006.02.11.001.0@hjlipp.my-fqdn.de>
	<gigaset307x.2006.02.11.001.1@hjlipp.my-fqdn.de>
	<gigaset307x.2006.02.11.001.2@hjlipp.my-fqdn.de>
	<gigaset307x.2006.02.11.001.3@hjlipp.my-fqdn.de>
	<gigaset307x.2006.02.11.001.4@hjlipp.my-fqdn.de>
	<gigaset307x.2006.02.11.001.5@hjlipp.my-fqdn.de>
	<gigaset307x.2006.02.11.001.6@hjlipp.my-fqdn.de>
	<20060212022742.16df78a2.akpm@osdl.org>
	<43F289F5.2080102@imap.cc>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tilman Schmidt <tilman@imap.cc> wrote:
>
> > - You did the ringbuffer the wrong way.  Don't constrain the head and
>  >   tail to be within 0..MAX_EVENTS.  Instead, just let them wrap right up to
>  >   0xffffffff.   Apply the masking when you actually _use_ them.
>  > 
>  >   That way, empty is (head == tail) and full is (tail - head == MAX_EVENTS).
> 
>  Interesting idea. I have to admit it's rather new to me. I have always
>  done ringbuffers the way they are done in the Gigaset driver now. Can
>  you point me to some example code done the way you propose, so I can
>  familiarize myself with its advantages?

Pretty much all the Becker-derived net drivers do this - Say,
vortex_private.cur_tx, .cur_tx.  Also include/linux/circ_buf.h and its
various users.

