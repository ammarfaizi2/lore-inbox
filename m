Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbTEFUgs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 16:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbTEFUgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 16:36:48 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:27910 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261839AbTEFUgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 16:36:47 -0400
Date: Tue, 6 May 2003 21:49:18 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Michael Hunold <hunold@convergence.de>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH[[2.5][3-11] update dvb subsystem core
Message-ID: <20030506214918.A18262@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Michael Hunold <hunold@convergence.de>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <3EB7DCF0.2070207@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3EB7DCF0.2070207@convergence.de>; from hunold@convergence.de on Tue, May 06, 2003 at 06:04:00PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 06:04:00PM +0200, Michael Hunold wrote:
> Hello,
> 
> this patch updates the dvb subsystem core.
> 
> Fixed problems:
> - partly reintroduced the DVB_DEVFS_ONLY switch, which was previously
> wiped out by Alan Cox: if enabled, some really obscure code is not
> compiled into the kernel that is necessary to xxx

No, this is wrong.  I did remove it not Alan Cox and I removed it because
kernel 2.5/2.6 should not behave differently whether devfs is used or
not except nodes showing up in devfs.

> -	/* fixme: is this correct? */
> -	try_module_get(THIS_MODULE);
> +

Just removing this makes the code even more incorrect.  You need to
add a ->owner member and call try_module_get on it before calling into
the module (and handle the return value..)

> -typedef struct dmxdev_dvr_s {
> +typedef struct dmxdev_dvr {
>          int state;
> -        struct dmxdev_s *dev;
> +        struct dmxdev *dev;
>          dmxdev_buffer_t buffer;
>  } dmxdev_dvr_t;

Once you rename everything you can nuke the typedef crap aswel..

