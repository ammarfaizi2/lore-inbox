Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbWIOUoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbWIOUoR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 16:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWIOUoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 16:44:16 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:1227 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932238AbWIOUoO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 16:44:14 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: =?iso-8859-1?q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Subject: Re: [RFC] Alignment of fields in struct dentry
Date: Fri, 15 Sep 2006 22:44:07 +0200
User-Agent: KMail/1.9.1
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20060914093123.GA10431@wohnheim.fh-wedel.de> <20060914215545.GC6441@schatzie.adilger.int> <20060915102736.GA767@wohnheim.fh-wedel.de>
In-Reply-To: <20060915102736.GA767@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609152244.07889.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Friday 15 September 2006 12:27 schrieb Jörn Engel:
> -};
> +}__attribute__((aligned(64))); /* make sure the dentry is 128/192 bytes
> +                                  on 32/64 bit independently of config
> +                                  options.  d_iname will vary in length
> +                                  a bit. */

I'd guess that a 32 byte alignment is much better here, 64 byte sounds
excessive. It should have the same effect with the current dentry layout
and default config options, but would keep the d_iname length in the
16-44 byte range instead of 16-76 byte as your patch does.

Since all important fields are supposed to be kept in 32 bytes anyway,
they are still either at the start or the end of a given cache line,
but never cross two.

	Arnd <><
