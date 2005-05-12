Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262174AbVELXDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbVELXDg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 19:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbVELXDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 19:03:36 -0400
Received: from animx.eu.org ([216.98.75.249]:51091 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S262174AbVELXDd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 19:03:33 -0400
Date: Thu, 12 May 2005 19:02:06 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Bugs in 2.6.12-rc kernels
Message-ID: <20050512230206.GA1380@animx.eu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050512015220.GA31634@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050512015220.GA31634@animx.eu.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wakko Warner wrote:
> 3) I put together a boot kernel/initrd using 2.6.12-rc2 (also tested
> 2.6.12-rc4) which seems to work, except that pcmcia does not function
> properly.  When pcmcia.ko gets loaded, it is unable to register it's char
> dev.  I'm not sure why this is.  2.6.11.8 worked fine with no modifications
> to the system.  This is a system designed to boot from floppy minimally,
> search for a device which has some files that populates a tmpfs filesystem
> which becomes the root filesystem.  This module is loaded from the tmpfs
> filesystem.  Module-init-tools version is 3.2-pre (Not sure if this makes a
> difference).  I tested this on a notebook that I have.  I also have this
> same kernel version installed which works fine.  It could be a different
> version of module-init-tools, but I'm unsure at this point (I do not have
> access to the notebook at this time.

I tested this again today with a few changes.  It appears that if pcmcia.ko
(or rather the .c files that make it up) are compiled with -Os, it will fail
to register a character device.  Being that one of my goals for this was to
fit everything on a floppy, I had to use -Os when building the kernel. 
(pcmcia was not one of the modules that belongs on the floppy, however I
did not want to have to compile the kernel and then again for the modules
w/o -Os)

I believe that pcmcia.ko is the only module I am using that  uses a dynamic
major.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
