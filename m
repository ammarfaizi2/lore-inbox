Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbTEEAhz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 20:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbTEEAhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 20:37:55 -0400
Received: from rth.ninka.net ([216.101.162.244]:28370 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S261866AbTEEAhx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 20:37:53 -0400
Subject: Re: Re:[2.5] Update sk98lin driver
From: "David S. Miller" <davem@redhat.com>
To: azarah@gentoo.org
Cc: KML <linux-kernel@vger.kernel.org>
In-Reply-To: <1052092571.4459.27.camel@nosferatu.lan>
References: <3EB5867D.1000404@wanadoo.es>
	 <1052092571.4459.27.camel@nosferatu.lan>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052095702.27465.19.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 May 2003 17:48:22 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-05-04 at 16:56, Martin Schlemmer wrote:
> A few issues though:
> 
> 1)  Should MOD_INC_USE_COUNT and MOD_DEC_USE_COUNT just be removed?
>     I commented them for now.

No.  For the net device itself, make sure you do
SET_MODULE_OWNER() on the netdev before passing it
to register_netdevice().

For the procfs stuff you must make sure the appropriate
module refcounting is done for that mechanism.

Just deleteing MOD_{INC,DEC}_USE_COUNT blindly will result
in the module being broken.

-- 
David S. Miller <davem@redhat.com>

