Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268605AbUHLQpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268605AbUHLQpv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 12:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268609AbUHLQpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 12:45:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:60566 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268605AbUHLQpu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 12:45:50 -0400
Date: Thu, 12 Aug 2004 09:45:46 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SG_IO and security
In-Reply-To: <Pine.LNX.4.58.0408120929360.1839@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0408120943210.1839@ppc970.osdl.org>
References: <1092313030.21978.34.camel@localhost.localdomain>
 <Pine.LNX.4.58.0408120929360.1839@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Aug 2004, Linus Torvalds wrote:
> 
> Hmm.. This still allows the old "junk" commands (SCSI_IOCTL_SEND_COMMAND).

Btw, I think the _right_ thing to check is the write access of the file 
descriptor. If you have write access to a block device, you can delete the 
data, so you might as well be able to do the raw commands. And that would 
allow things like "disk" groups etc to work and burn CD's.

However, right now we don't even pass down the "struct file" to this 
function. We probably should. Anybody willing to go through the callers? 
(just a few callers, but things like cdrom_command() doesn't even have the 
file, so it has to be recursive).

		Linus
