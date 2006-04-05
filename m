Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbWDEPVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbWDEPVv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 11:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbWDEPVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 11:21:51 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:32977 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750885AbWDEPVv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 11:21:51 -0400
Date: Wed, 5 Apr 2006 16:21:23 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: gregkh@suse.de, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [patch 03/26] sysfs: zero terminate sysfs write buffers (CVE-2006-1055)
Message-ID: <20060405152123.GH27946@ftp.linux.org.uk>
References: <20060404235634.696852000@quad.kroah.org> <20060404235947.GD27049@kroah.com> <20060405190928.17b9ba6a.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060405190928.17b9ba6a.vsu@altlinux.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2006 at 07:09:28PM +0400, Sergey Vlasov wrote:
> This will break the "color_map" sysfs file for framebuffers -
> drivers/video/fbsysfs.c:store_cmap() expects to get exactly 4096 bytes
> for a colormap with 256 entries.  In fact, the original patch which
> changed PAGE_SIZE - 1 to PAGE_SIZE:

... cheerfully assuming that nobody assumes NUL-termination and
everyone (sysfs patch writers!) certainly uses the length argument.
Fscking brilliant, that.

Are you willing to audit all sysfs ->show() in the kernel?  Original
author of that turd had not been.

FWIW, "color_map" is a blatant abuse of interface.  Doesn't get
any more borderline...

