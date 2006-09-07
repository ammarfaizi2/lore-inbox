Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751788AbWIGNEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbWIGNEF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 09:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751679AbWIGNEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 09:04:05 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:8148 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1751788AbWIGNEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 09:04:02 -0400
Date: Thu, 7 Sep 2006 07:04:01 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Tejun Heo <htejun@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-pci@atrey.karlin.mff.cuni.cz,
       Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: question regarding cacheline size
Message-ID: <20060907130401.GO2558@parisc-linux.org>
References: <44FFD8C6.8080802@gmail.com> <20060907111120.GL2558@parisc-linux.org> <45000076.4070005@gmail.com> <20060907120756.GA29532@flint.arm.linux.org.uk> <20060907122311.GM2558@parisc-linux.org> <1157632405.14882.27.camel@laptopd505.fenrus.org> <20060907124026.GN2558@parisc-linux.org> <45001665.9050509@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45001665.9050509@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 02:53:57PM +0200, Tejun Heo wrote:
> The spec says that devices can put additional restriction on supported 
> cacheline size (IIRC, the example was something like power of two >= or 
> <= certain size) and should ignore (treat as zero) if unsupported value 
> is written.  So, there might be need for more low level driver 
> involvement which knows device restrictions, but I don't know whether 
> such devices exist.

That's nothing we can do anything about.  The system cacheline size is
what it is.  If the device doesn't support it, we can't fall back to a
different size, it'll cause data corruption.  So we'll just continue on,
and devices which live up to the spec will act as if we hadn't
programmed a cache size.  For devices that don't, we'll have the quirk.

Arguably devices which don't support the real system cacheline size
would only get data corruption if they used MWI, so we only have to
prevent them from using MWI; they could use a different cacheline size
for MRM and MRL without causing data corruption.  But I don't think we
want to go down that route; do you?
