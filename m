Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbUAINt5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 08:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbUAINty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 08:49:54 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:16904 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261595AbUAINts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 08:49:48 -0500
Date: Fri, 9 Jan 2004 13:49:42 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@osdl.org>, Jes Sorensen <jes@trained-monkey.org>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [patch] 2.6.1-rc2-mm1: qla1280.c doesn't compile
Message-ID: <20040109134942.A24302@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>,
	Jes Sorensen <jes@trained-monkey.org>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <20040107232831.13261f76.akpm@osdl.org> <20040109015229.GK13867@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040109015229.GK13867@fs.tum.de>; from bunk@fs.tum.de on Fri, Jan 09, 2004 at 02:52:30AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 09, 2004 at 02:52:30AM +0100, Adrian Bunk wrote:
> I got the following compile error when trying to compile this driver 
> statically into a kernel with hotplug enabled:

Jes, that's your ifdef-magic around around qla1280_remove_one.. Do you
remember why you added it?  The only case we don't need it is when
the driver is builtin and CONFIG_HOTPLUG is not set - and in that case
__devexit should get rid of it for us.

> Since I don't see a good reason why qla1280_remove_one is #ifdef'ed out 
> in the non-modular case the patch below fixes this problem by removing 
> two #ifdef's.

The patch looks good to me.  In fact that's how it was in the patch
I sent to Jes..
