Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129569AbRCEQyX>; Mon, 5 Mar 2001 11:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129458AbRCEQyE>; Mon, 5 Mar 2001 11:54:04 -0500
Received: from hera.cwi.nl ([192.16.191.8]:52619 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129449AbRCEQx4>;
	Mon, 5 Mar 2001 11:53:56 -0500
Date: Mon, 5 Mar 2001 17:53:48 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200103051653.RAA72776.aeb@vlet.cwi.nl>
To: cr@sap.com, matti.aarnio@zmailer.org
Subject: Re: 2.4 and 2GB swap partition limit
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> For 2.5 we could perhaps think about a new swapfile layout

> The format seems to be just fine.

No, the present definition is terrible.

Read the mkswap source. A forest of #ifdefs,
and still sometimes user assistance is required
because mkswap cannot always figure out what the "pagesize" is.

There are two main problems:
(i) "new" swap is hardly larger than "old" swap
(ii) the unit in which new swap is measured is a mystery

So, the next swap space has (i) a signature "SWAPSPACE3",
(ii) (not strictly necessary) a size given as a 64-bit number in bytes.
Moreover, the swapon call must not refuse swapspaces
that are larger than the kernel can handle.

Andries
