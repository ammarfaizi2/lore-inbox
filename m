Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264132AbUESMoa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264132AbUESMoa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 08:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264134AbUESMoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 08:44:30 -0400
Received: from colin2.muc.de ([193.149.48.15]:8971 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S264132AbUESMo2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 08:44:28 -0400
Date: 19 May 2004 14:44:27 +0200
Date: Wed, 19 May 2004 14:44:27 +0200
From: Andi Kleen <ak@muc.de>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Jan Kasprzak <kas@informatics.muni.cz>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: sendfile -EOVERFLOW on AMD64
Message-ID: <20040519124427.GA68902@colin2.muc.de>
References: <1XuW9-3G0-23@gated-at.bofh.it> <m3d650wys1.fsf@averell.firstfloor.org> <20040519103855.GF18896@fi.muni.cz> <20040519105805.GK30909@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040519105805.GK30909@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (note error is int, not ssize_t), but I don't see anything obvious
> for other filesystems.

sendfile64 on 32bit hosts seems to be quite fishy too.

It works with ssize_t, which is 32bit only, but there are no checks
that the transfered file is not >4GB.  It would just wrap in this case.
It would be better to add such checks for 32bit hosts to sendfile64.

Or am I missing something?

-Andi
