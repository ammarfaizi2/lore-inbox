Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751669AbWB0ICz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669AbWB0ICz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 03:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751671AbWB0ICz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 03:02:55 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:3749 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751669AbWB0ICy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 03:02:54 -0500
Subject: Re: [PATCH 2/7] isdn4linux: Siemens Gigaset drivers - event layer
From: Arjan van de Ven <arjan@infradead.org>
To: Hansjoerg Lipp <hjlipp@web.de>
Cc: Karsten Keil <kkeil@suse.de>, i4ldeveloper@listserv.isdn4linux.de,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Greg Kroah-Hartman <gregkh@suse.de>, Tilman Schmidt <tilman@imap.cc>
In-Reply-To: <gigaset307x.2006.02.27.001.2@hjlipp.my-fqdn.de>
References: <gigaset307x.2006.02.27.001.0@hjlipp.my-fqdn.de>
	 <gigaset307x.2006.02.27.001.1@hjlipp.my-fqdn.de>
	 <gigaset307x.2006.02.27.001.2@hjlipp.my-fqdn.de>
Content-Type: text/plain
Date: Mon, 27 Feb 2006 09:02:48 +0100
Message-Id: <1141027369.2992.49.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-27 at 07:23 +0100, Hansjoerg Lipp wrote:
> +               }
> +
> +       spin_lock_irqsave(&cs->lock, flags);
> +       ret = kmalloc(sizeof(struct at_state_t), GFP_ATOMIC);
> +       if (ret) {
> +               gigaset_at_init(ret, NULL, cs, cid);
> 

if you move the kmalloc one line up, can it use GFP_KERNEL ?
(GFP_ATOMIC is evil in the sense that spurious use of it gives trouble
for the VM)

