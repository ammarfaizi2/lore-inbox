Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261219AbVARAeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbVARAeR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 19:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261310AbVARAeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 19:34:17 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33700 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261219AbVARAeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 19:34:15 -0500
Date: Tue, 18 Jan 2005 00:34:13 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Daniel Drake <dsd@gentoo.org>
Cc: Andrew Morton <akpm@osdl.org>, Joseph Fannin <jhf@rivenstone.net>,
       linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       William Park <opengeometry@yahoo.ca>
Subject: Re: [PATCH] Wait and retry mounting root device (revised)
Message-ID: <20050118003413.GA26051@parcelfarce.linux.theplanet.co.uk>
References: <20050114002352.5a038710.akpm@osdl.org> <20050116005930.GA2273@zion.rivenstone.net> <41EC7A60.9090707@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41EC7A60.9090707@gentoo.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2005 at 02:54:24AM +0000, Daniel Drake wrote:
> Retry up to 20 times if mounting the root device fails.  This fixes booting
> from usb-storage devices, which no longer make their partitions immediately
> available.

Sigh...  So we can very well get device coming up in the middle of a loop
and get the actual attempts to mount the sucker in wrong order.  How nice...

Folks, that's not a solution.  And kludges like that really have no
business being there - they only hide the problem and make it harder
to reproduce.
