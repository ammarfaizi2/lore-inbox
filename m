Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161217AbWJXT6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161217AbWJXT6j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 15:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161216AbWJXT6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 15:58:39 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:6885 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1161211AbWJXT6i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 15:58:38 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: will_schmidt@vnet.ibm.com
Subject: Re: [PATCH 2/3] spufs: fix another off-by-one bug in mbox_read
Date: Tue, 24 Oct 2006 21:58:32 +0200
User-Agent: KMail/1.9.5
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, linuxppc-dev@ozlabs.org,
       Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
References: <20061024160140.452484000@arndb.de> <200610242107.44115.arnd@arndb.de> <1161719603.8946.84.camel@farscape>
In-Reply-To: <1161719603.8946.84.camel@farscape>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610242158.33069.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 October 2006 21:53, Will Schmidt wrote:
> Hey Arnd,
>    just curiosity..   What was the behavior before this patch?   just
> leaving a few (0 - 3) characters behind?

It transfers more bytes than requested on a read. If you asked for
four bytes, you got eight.

Note: one nasty property of this file in spufs is that you can only
read multiples of four bytes in the first place, there is no way to
atomically put back a few bytes into the hardware register, so reading
less than four bytes returns -EINVAL. Asking for more than four
should return the largest possible multiple of four.

	Arnd <><
