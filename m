Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbVASU3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbVASU3u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 15:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbVASU3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 15:29:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:59305 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261880AbVASU3f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 15:29:35 -0500
Date: Wed, 19 Jan 2005 15:29:27 -0500
From: Dave Jones <davej@redhat.com>
To: Matt Mackall <mpm@selenic.com>
Cc: Roger Luethi <rl@hellgate.ch>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] use mmiowb in via-rhine
Message-ID: <20050119202927.GA21673@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Matt Mackall <mpm@selenic.com>, Roger Luethi <rl@hellgate.ch>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20050119202220.GT12076@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050119202220.GT12076@waste.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2005 at 12:22:20PM -0800, Matt Mackall wrote:
 > Use the generic PCI memory barrier. Test-compiled.

This can't be right.

 > Signed-off-by: Matt Mackall <mpm@selenic.com>
 > 
 > Index: bk/drivers/net/via-rhine.c
 > ===================================================================
 > --- bk.orig/drivers/net/via-rhine.c	2005-01-19 12:06:52.283455936 -0800
 > +++ bk/drivers/net/via-rhine.c	2005-01-19 12:18:02.536561976 -0800
 > @@ -351,9 +351,6 @@
 >   * indicator. In addition, Tx and Rx buffers need to 4 byte aligned.
 >   */
 >  
 > -/* Beware of PCI posted writes */
 > -#define IOSYNC	do { ioread8(ioaddr + StationAddr); } while (0)
 > -

You're replacing a PCI ordering barrier with..

include/asm-i386/io.h:#define mmiowb()

nothing ?

		Dave

