Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbTFFSlX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 14:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbTFFSlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 14:41:23 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56071 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262227AbTFFSlV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 14:41:21 -0400
Date: Fri, 6 Jun 2003 11:54:45 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Steven Cole <elenstev@mesatop.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] 2.5.70-bk11 zlib cleanup #3 Z_NULL
In-Reply-To: <20030606183920.GC10487@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.44.0306061151420.30453-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id h56IsjB07327
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 6 Jun 2003, Jörn Engel wrote:
> 
> How do you feel about "if (z->state->blocks != NULL)"?  Remove the
> pointless !=NULL or keep it?

I don't mind it, but it doesn't buy much.

It's actually in some other cases where I think there is a readability 
issue, ie in more complex conditionals I personally prefer the simpler 
cersion, ie I much prefer something like

	if (ptr && ptr->ops && ptr->ops->shutdown)
		ptr->ops->shutdown(ptr, xxxx);

over the pointless NULL-masturbation in something like

	if (ptr != NULL && ptr->ops != NULL && ptr->ops->shutdown != NULL)
		ptr->ops->shutdown(ptr, xxxx)

which I just is much less readable than the simple version.

		Linus

