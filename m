Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbVASVGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbVASVGi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 16:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbVASVGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 16:06:37 -0500
Received: from fire.osdl.org ([65.172.181.4]:45468 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261897AbVASVGa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 16:06:30 -0500
Subject: Re: [PATCH - 2.6.10] generic_file_buffered_write handle partial
	DIO writes with multiple iovecs
From: Daniel McNeil <daniel@osdl.org>
To: Sami Farin <7atbggg02@sneakemail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050119172812.GR6725@m.safari.iki.fi>
References: <1106097764.3041.16.camel@ibm-c.pdx.osdl.net>
	 <20050119023151.GK6725@m.safari.iki.fi>
	 <1106153740.3041.42.camel@ibm-c.pdx.osdl.net>
	 <20050119172812.GR6725@m.safari.iki.fi>
Content-Type: text/plain
Message-Id: <1106168787.3041.60.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 19 Jan 2005 13:06:27 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-19 at 09:28, Sami Farin wrote:
> On Wed, Jan 19, 2005 at 08:55:40AM -0800, Daniel McNeil wrote:
> > On Tue, 2005-01-18 at 18:31, Sami Farin wrote:
> ...
> > > I have Linux 2.6.10-ac9 + bio clone memory corruption -patch,
> > > and dio_bug does not give errors (without your patch).
> > 
> > I should have mentioned that my testing was on ext3 with 4k
> > block size.   The bio clone patch might affect this by merging
> > the i/o into a single iovec.  Here's an updated test program
> > that uses 2 different buffers allocated separately that might
> > prevent the merging.  See if this works on your system.
> 
> I have reiserfs... and this version does not give errors, either. 

Reisefs must handle allocations differently.  The bug only
shows up if there is an unallocated hole and a O_DIRECT write with
multiple iovecs writes partially into the allocated space 
and completes at least 1 iovec worth of data and then finishes
the i/o using buffer i/o to allocate space for the hole and write
the remaining data.

Daniel


