Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263889AbUDFXLj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 19:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264058AbUDFXLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 19:11:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46509 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263889AbUDFXLh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 19:11:37 -0400
Date: Wed, 7 Apr 2004 00:11:36 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] BME, noatime and nodiratime
Message-ID: <20040406231136.GN31500@parcelfarce.linux.theplanet.co.uk>
References: <20040406145544.GA19553@MAIL.13thfloor.at> <20040406204843.GL31500@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040406204843.GL31500@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 09:48:44PM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:

> noatime/nodiratime: OK, but we still have direct modifications of i_atime
> that need to be taken care of.

Particulary interesting one is in tty_io.c.  There we
	1) unconditionally touch i_atime on read()
	2) do not touch it on write()
	3) never mark the inode dirty.

Note that the last one means that doing stat() in a loop will sometimes
give atime going backwards.  We also completely ignore noatime here.

There are similar places in some other char drivers.  Obvious step would
be to have them do file_accessed() instead; however, I'd really like to
hear the rationale for existing behaviour.  Comments?
