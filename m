Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263968AbTJFDhK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 23:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263969AbTJFDhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 23:37:09 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:27581 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263968AbTJFDhH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 23:37:07 -0400
Date: Sun, 5 Oct 2003 20:36:06 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
Subject: Re: oops when removing sbp2 module
Message-ID: <20031005203606.A3829@beaverton.ibm.com>
References: <16256.6322.388402.857084@cargo.ozlabs.ibm.com> <20031005074902.A26284@beaverton.ibm.com> <16256.56491.671416.205944@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16256.56491.671416.205944@cargo.ozlabs.ibm.com>; from paulus@samba.org on Mon, Oct 06, 2003 at 01:08:27PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 06, 2003 at 01:08:27PM +1000, Paul Mackerras wrote:

> That fixes it, it no longer oopses on removing sbp2.  As before I get
> a message saying "Device 'fw-host0' does not have a release()
> function, it is broken and must be fixed."  I assume that is a problem
> with the sbp2 module.
> 
> The code in the patch looks a little worrying to me, though.  Is there
> some lock we have taken to ensure that no other process could be
> modifying sdev->access_count at the same time?  Also, what is to stop
> some other process from noticing that sdev->access_count is 0 and
> calling device_del(&sdev->sdev_gendev) ?

Yes, it's a known problem, there is also a comment in the code, Christoph
was working on it.

-- Patrick Mansfield
