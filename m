Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWJPRDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWJPRDc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 13:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWJPRDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 13:03:32 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:61909 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932113AbWJPRDb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 13:03:31 -0400
Date: Mon, 16 Oct 2006 19:04:05 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Duncan Sands <duncan.sands@math.u-psud.fr>, Greg K-H <greg@kroah.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 3/3] Driver core: Per-subsystem multithreaded probing.
Message-ID: <20061016190405.3570f547@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <Pine.LNX.4.44L0.0610161135050.7648-100000@iolanthe.rowland.org>
References: <20061016172631.47d3eb70@gondolin.boeblingen.de.ibm.com>
	<Pine.LNX.4.44L0.0610161135050.7648-100000@iolanthe.rowland.org>
X-Mailer: Sylpheed-Claws 2.5.5 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2006 11:56:29 -0400 (EDT),
Alan Stern <stern@rowland.harvard.edu> wrote:

> You would only be changing it for the multithreaded path, which itself is 
> very new.  But this is all hypothetical anyway...

I think we're talking about the same thing :)

> So the question is what do do if someone calls device_register() or
> device_add() with dev->driver set.  If everything succeeds except for
> creation of the symlinks, should the device remain registered?  The driver
> core has been vacillating about this recently.  I'm not sure what the 
> right answer is.

If dev->driver has not been set and symlink creation failed, we'll end
up with an unbound but registered device. Maybe the same should happen
if dev->driver had been set before (register the device but reset
dev->driver to NULL)?

> However the kerneldoc for device_attach() should be updated to mention
> that when multithreaded probing is used, a driver might end up getting
> bound even though the return value is 0.

Agreed.
 
> P.S.: If you initialize probe_task to ERR_PTR(-ENOMEM) or something 
> similar, then you could eliminate one of the calls to bus_for_each_drv() 
> in device_attach().

I'll do a new patch series tomorrow.

-- 
Cornelia Huck
Linux for zSeries Developer
Tel.: +49-7031-16-4837, Mail: cornelia.huck@de.ibm.com
