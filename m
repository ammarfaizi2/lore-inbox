Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932334AbWE3RAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbWE3RAz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 13:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbWE3RAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 13:00:55 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:25754 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S932334AbWE3RAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 13:00:53 -0400
Date: Tue, 30 May 2006 11:00:51 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Greg KH <gregkh@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       Greg KH <greg@kroah.com>, Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: searching for pci busses
Message-ID: <20060530170051.GA1610@parisc-linux.org>
References: <4478DCF1.8080608@gmail.com> <20060529214753.GD10875@kroah.com> <447B6ECB.9080207@pobox.com> <20060530163821.GC7146@suse.de> <9e4733910605300952v1cf56beasc2a907cc77b8a09f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910605300952v1cf56beasc2a907cc77b8a09f@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2006 at 12:52:31PM -0400, Jon Smirl wrote:
> This is how DRM does it...

>        for (i = 0; driver->pci_driver.id_table[i].vendor != 0; i++) {
>                pid = (struct pci_device_id *)&driver->pci_driver.id_table[i];

Why do you cast away the const warning?  Why not just make pid a pointer
to const?  drm_get_dev already has the const qualifier, so somebody
realised what the right thing to do was.

But looking at this code just reinforces the basic problem -- that DRM
does everything wrong and it needs shooting in the head.
