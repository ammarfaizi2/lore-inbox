Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbVFCPMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbVFCPMo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 11:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVFCPMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 11:12:44 -0400
Received: from animx.eu.org ([216.98.75.249]:9909 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S261321AbVFCPMm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 11:12:42 -0400
Date: Fri, 3 Jun 2005 11:08:48 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: "Richard B. Johnson" <linux-os@analogic.com>
Cc: Tomko <tomko@avantwave.com>, linux-kernel@vger.kernel.org
Subject: Re: question why need open /dev/console in init() when starting kernel
Message-ID: <20050603150848.GB14641@animx.eu.org>
Mail-Followup-To: "Richard B. Johnson" <linux-os@analogic.com>,
	Tomko <tomko@avantwave.com>, linux-kernel@vger.kernel.org
References: <42A00065.9060201@avantwave.com> <Pine.LNX.4.61.0506030629170.11487@chaos.analogic.com> <20050603141504.GA14641@animx.eu.org> <Pine.LNX.4.61.0506031031070.13982@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0506031031070.13982@chaos.analogic.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> On Fri, 3 Jun 2005, Wakko Warner wrote:
> >Is it at all possible that if /dev/console does not exist that the kernel
> >can mknod it?
> >
> 
> Yes. Your initial console can be NULL, set as a kernel command-line

I forgot about this.  I was thinking in the cases where it wasn't.

> parameter. You should really be using an initial RAM disk (initrd).
> That gets mounted for boot, containing whatever is necessary to
> properly start the system, then change to the file root (or not).
> This is how hundreds of different embeded systems are started.
> 
> Execute-in-place, which I think you are trying with 'cpio' will
> continue to give you problems because you can't test it except
> by throwing it off-the-cliff to see if it flies. RAM-disk systems
> can be tested, booting on any media (even a floppy).

I built a small system that runs in 2 stages.  stage 1 basically only
searches for stage 2 and can fit on a floppy.  It has a kernel (no
filesystem support builtin) and a cpio archive that is loaded via initrd. 
It has actually decreased the size and since everything runs out of a tmpfs
filesystem anyway, it works just fine.

I was asking a technical question, not a preferred usage question.

I would think that if the kernel itself can populate a tmpfs from a cpio
archive, it can also mknod /dev/console.  However, I don't know if the
code would increase the kernel more than just having 2 extra entries in a
cpio archive.

> >Would the code to do this be larger than 2 entries in a cpio archive (one
> >for /dev directory and one for /dev/console char dev)?

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
