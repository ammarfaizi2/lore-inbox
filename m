Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964848AbWDCWhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbWDCWhT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 18:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbWDCWhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 18:37:19 -0400
Received: from ozlabs.org ([203.10.76.45]:55941 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S964848AbWDCWhS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 18:37:18 -0400
Date: Tue, 4 Apr 2006 08:36:20 +1000
From: Anton Blanchard <anton@samba.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Add prctl to change endian of a task
Message-ID: <20060403223620.GC4704@krispykreme>
References: <20060401222921.GI23416@krispykreme> <200604021637.49759.ioe-lkml@rameria.de> <1143989770.29060.28.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143989770.29060.28.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> Abuse is a possible problem but you can deal with that. If you don't
> inherit endian changes then the problem doesn't occur. If you must
> inherit them then drop the inheritance when an suid/sgid exec occurs as
> we do with some other properties.

Yeah dropping it on exec makes sense to me.

> Can you explain however why you can't do this simply by using a binary
> magic number in the executable to indicate which endian it is, or do you
> really need to flip it ?

The aim is not to implement little endian binaries but to assist
running portions of code in little endian mode. The thought is we could
hook up qemu to it and avoid having to byteswap.

While ppc has byteswap integer loads it does not have byteswap floating
point loads and a byteswap involves loading into the integer unit,
performing the byteswap, storing to a temporary location and loading
into the floating point unit. Rather slow.

Anton
