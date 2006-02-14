Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422812AbWBNVqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422812AbWBNVqk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 16:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422813AbWBNVqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 16:46:40 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:8597 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1422812AbWBNVqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 16:46:39 -0500
Subject: Re: [PATCH] tty reference count fix
From: Arjan van de Ven <arjan@infradead.org>
To: Jason Baron <jbaron@redhat.com>
Cc: Paul Fulghum <paulkf@microgate.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "jesper.juhl@gmail.com" <jesper.juhl@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <Pine.LNX.4.61.0602131747570.19384@dhcp83-105.boston.redhat.com>
References: <1139861610.3573.24.camel@amdx2.microgate.com>
	 <Pine.LNX.4.61.0602131747570.19384@dhcp83-105.boston.redhat.com>
Content-Type: text/plain
Date: Tue, 14 Feb 2006 22:46:29 +0100
Message-Id: <1139953590.4117.23.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> patch looks good to me. Or you could even drop the tty_sem completely from 
> the release_dev path (patch below) since lock_kernel() is held in both 
> tty_open() and the release_dev paths() (and there is no sleeping b/w 
> setting the tty_closing flag and setting the TTY_CLOSING bit).


that's the wrong direction.. the idea is to first put new locking under
the BKL layer.. and at the end pull the BKL entirely.. The BKL isn't a
good lock.

