Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267792AbUIOX25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267792AbUIOX25 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 19:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267725AbUIOXZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 19:25:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:18385 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267770AbUIOXVx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 19:21:53 -0400
X-Authenticated: #1725425
Date: Thu, 16 Sep 2004 01:33:51 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: pjones@redhat.com, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH-NEW] allow root to modify raw scsi command permissions
 list
Message-Id: <20040916013351.1422170f.Ballarin.Marc@gmx.de>
In-Reply-To: <1095284325.20749.8.camel@localhost.localdomain>
References: <1095173470.5728.3.camel@localhost.localdomain>
	<20040915230813.6eac1d04.Ballarin.Marc@gmx.de>
	<1095284325.20749.8.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2004 22:38:47 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> You need to check for capable(CAP_SYS_RAWIO) otherwise you elevate
> anyone with access bypass capabilities to CAP_SYS_RAWIO equivalent
> powers.

True. File permissions aren't enough.

Will something like this suffice?

static ssize_t rcf_store_write(struct rawio_cmd_filter *rcf, const char *page,
			size_t count)
{

	...	
	
	if (!capable(CAP_SYS_RAWIO))
		return -EPERM;
	
	while(i < RCF_MAX_NR_CMDS)
		clear_bit(i++, rcf->write_ok);
	...

Regards
