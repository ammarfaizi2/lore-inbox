Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbVJ0VJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbVJ0VJw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 17:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbVJ0VJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 17:09:52 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:19157
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932260AbVJ0VJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 17:09:51 -0400
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Evgeny Stambulchik <Evgeny.Stambulchik@weizmann.ac.il>
Subject: Re: Weirdness of "mount -o remount,rw" with write-protected floppy
Date: Thu, 27 Oct 2005 16:09:47 -0500
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <4360C0A7.4050708@weizmann.ac.il>
In-Reply-To: <4360C0A7.4050708@weizmann.ac.il>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510271609.47309.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 October 2005 06:57, Evgeny Stambulchik wrote:
> The bug is present in both 2.4 and 2.6, and is specific to floppy
> devices. Other RO media I tried (CDROM, RO-exported NFS) are partially
> OK, in the sense that a write attempt returns an error; however, "mount
> -o remount,rw" always returns success (this might be a bug in mount).

Busybox "mount" maintainer's ears perk up to see if this is relevant.  (After 
all, we have a separate implementation you can try to see if it's a tool 
bug.)

But no, this one's clearly a kernel error.  If the kernel is giving write 
errors against the device afterwards, than the kernel's internal state 
toggled successfully, which is all the mount syscall was trying to do.  Mount 
is just reporting whether or not the syscall succeeded, not whether or not it 
should have. :)

Rob
