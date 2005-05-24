Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261997AbVEXJTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261997AbVEXJTj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 05:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbVEXJSC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 05:18:02 -0400
Received: from smtp.nexlab.net ([213.173.188.110]:62908 "EHLO smtp.nexlab.net")
	by vger.kernel.org with ESMTP id S261890AbVEXJOj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 05:14:39 -0400
X-Postfix-Filter: PDFilter By Nexlab, Version 0.1 on mail01.nexlab.net
X-Virus-Checker-Version: clamassassin 1.2.1 with ClamAV 0.83/893/Tue May 24
	08:27:20 2005 signatures 31.893
Message-Id: <20050524091436.53CE4FB9E@smtp.nexlab.net>
Date: Tue, 24 May 2005 11:14:36 +0200 (CEST)
From: root@smtp.nexlab.net
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	by smtp.nexlab.net (Postfix) with ESMTP id 1014BFB6D

	for <chiakotay@nexlab.it>; Tue, 24 May 2005 10:01:44 +0200 (CEST)

Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand

	id S261278AbVEXBWc (ORCPT <rfc822;chiakotay@nexlab.it>);

	Mon, 23 May 2005 21:22:32 -0400

Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVEXBWc

	(ORCPT <rfc822;linux-kernel-outgoing>);

	Mon, 23 May 2005 21:22:32 -0400

Received: from fire.osdl.org ([65.172.181.4]:44189 "EHLO smtp.osdl.org")

	by vger.kernel.org with ESMTP id S261329AbVEXBRo (ORCPT

	<rfc822;linux-kernel@vger.kernel.org>);

	Mon, 23 May 2005 21:17:44 -0400

Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])

	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4O1HBjA004584

	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);

	Mon, 23 May 2005 18:17:12 -0700

Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])

	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4O1HBxQ031844;

	Mon, 23 May 2005 18:17:11 -0700

Received: (from chrisw@localhost)

	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j4O1HB9g031843;

	Mon, 23 May 2005 18:17:11 -0700

Date:	Mon, 23 May 2005 18:17:11 -0700

From: Chris Wright <chrisw@osdl.org>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
	stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	"Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
	Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
	akpm@osdl.org, alan@lxorguk.ukuu.org.uk, p2@mind.be,
	vandrove@vc.cvut.cz, dsd@gentoo.org
Subject: Re: [patch 06/16] Fix matroxfb on big-endian hardware

Message-ID: <20050524011711.GD27549@shell0.pdx.osdl.net>

References: <20050523231529.GL27549@shell0.pdx.osdl.net> <20050523232207.GR27549@shell0.pdx.osdl.net> <20050523235052.GX29811@parcelfarce.linux.theplanet.co.uk>

Mime-Version: 1.0

Content-Type: text/plain; charset=us-ascii

Content-Disposition: inline

In-Reply-To: <20050523235052.GX29811@parcelfarce.linux.theplanet.co.uk>

User-Agent: Mutt/1.5.6i

X-Spam-Status: No, hits=0 required=5 tests=

X-Spam-Checker-Version:	SpamAssassin 2.63-osdl_revision__1.40__

X-MIMEDefang-Filter: osdl$Revision: 1.109 $

X-Scanned-By: MIMEDefang 2.36

Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk

X-Mailing-List:	linux-kernel@vger.kernel.org



* Al Viro (viro@parcelfarce.linux.theplanet.co.uk) wrote:
> On Mon, May 23, 2005 at 04:22:07PM -0700, Chris Wright wrote:
> > -				mga_writel(mmio, 0, *chardata);
> > +#if defined(__BIG_ENDIAN)
> > +				fb_writel((*chardata) << 24, mmio.vaddr);
> > +#else
> > +				fb_writel(*chardata, mmio.vaddr);
> > +#endif
> 
> So basically you are passing it cpu_to_le32(*chardata)?
> 
> > +#if defined(__BIG_ENDIAN)
> > +				fb_writel((*(u_int16_t*)chardata) << 16, mmio.vaddr);
> > +#else
> > +				fb_writel(*(u_int16_t*)chardata, mmio.vaddr);
> > +#endif
> 
> *yuck*
> 
> cpu_to_le32(le16_to_cpu(*(__le16 *)chardata)?  Is that what you are doing
> here?

Petr, care to comment?  Best I can tell this is from you and is already
upstream.  Any reason not to use cpu_to_xx instead of what's done?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

