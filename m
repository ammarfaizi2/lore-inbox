Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265134AbUFBHrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265134AbUFBHrg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 03:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265136AbUFBHrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 03:47:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:1745 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265134AbUFBHre (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 03:47:34 -0400
Date: Wed, 2 Jun 2004 00:46:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, bilotta78@hotpop.com,
       danlee@informatik.uni-freiburg.de, vojtech@suse.cz, tuukkat@ee.oulu.fi
Subject: Re: [RFC/RFT] Raw access to serio ports (1/2)
Message-Id: <20040602004654.648132f8.akpm@osdl.org>
In-Reply-To: <200406020243.09560.dtor_core@ameritech.net>
References: <200406020218.42979.dtor_core@ameritech.net>
	<20040602003626.4d754944.akpm@osdl.org>
	<200406020243.09560.dtor_core@ameritech.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dtor_core@ameritech.net> wrote:
>
>  > The return values here are mucked up - this function returns `written'.
> 
>  Or an error code in negative notation - it's the standard practice for
>  read/write. Am I missing something?

You want the function to return -ENODEV if !list->rawdev->serio

	if (!list->rawdev->serio) {
		retval = -ENODEV;
		goto out;
	}
	...
out:
	up(&rawdev_sem);
	return written;
}

But it won't.
