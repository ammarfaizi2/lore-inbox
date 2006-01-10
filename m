Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751671AbWAJAIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671AbWAJAIE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 19:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751675AbWAJAIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 19:08:04 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:8678 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751671AbWAJAIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 19:08:02 -0500
Date: Tue, 10 Jan 2006 00:07:58 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch 0/2] Tmpfs acls
Message-ID: <20060110000758.GA22399@srcf.ucam.org>
References: <200601090023.16956.agruen@suse.de> <E1Evk3m-00043Y-00@chiark.greenend.org.uk> <200601100059.47317.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601100059.47317.agruen@suse.de>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 12:59:46AM +0100, Andreas Gruenbacher wrote:
> On Monday 09 January 2006 00:34, Matthew Garrett wrote:
> > Hmm. Do you have any infrastructure for revoking open file descriptors
> > when a user logs out?
> 
> Open file descriptors have nothing to do with it. The device permissions are 
> set by different pam modules on different distributions (pam_console, 
> pam_resmgr).

Right. But what stops a user writing an application that opens a device, 
hangs around after the user logs out and then provides access to the 
user when logged in remotely?

Handwavy problem scenario - user A logs in, is given access to the 
soundcard. Starts running a program that when given appropriate signals 
will record from the system microphone. Logs out. Waits for user B, who 
he suspects is having an affair with his wife, and then monitors any 
conversations that user B has. ACLs on their own don't seem to solve 
this any more than just statically assigning group membership to users.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
