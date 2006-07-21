Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbWGUWQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWGUWQw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 18:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWGUWQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 18:16:52 -0400
Received: from mail.gmx.net ([213.165.64.21]:19417 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751238AbWGUWQt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 18:16:49 -0400
X-Authenticated: #271361
Date: Sat, 22 Jul 2006 00:16:43 +0200
From: Edgar Toernig <froese@gmx.de>
To: =?ISO-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Cc: Kari Hurtta <hurtta+gmane@siilo.fmi.fi>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RFC/PATCH] revoke/frevoke system calls
Message-Id: <20060722001643.58b03bbb.froese@gmx.de>
In-Reply-To: <20060720210901.GA29485@atjola.homenet>
References: <Pine.LNX.4.58.0607201504040.18901@sbz-30.cs.Helsinki.FI>
	<5dd5c0nixe.fsf@attruh.keh.iki.fi>
	<20060720210901.GA29485@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Björn Steinbrink wrote:
>
> On 2006.07.20 23:02:53 +0300, Kari Hurtta wrote:
> > Pekka J Enberg <penberg@cs.Helsinki.FI> writes in
> > gmane.linux.file-systems,gmane.linux.kernel:
> > 
> > > From: Pekka Enberg <penberg@cs.helsinki.fi>
> > > 
> > > [...]
> > > After we have done that to all file descriptors, we close the files and 
> > > take down mmaps.
> > 
> > What permissions is needed revoke access of other users open
> > files ?
> > [...]
> > BSD manual page for revoke(2) seems say:
> > 
> >     Access to a file may be revoked only by its owner or the super user.
> 
> In do_revoke() there is:
> 
> +	if (current->fsuid != inode->i_uid && !capable(CAP_FOWNER)) {
> +		ret = -EPERM;
> +		goto out;
> 
> That pretty much matches what the BSD manpage says.

Urgs, so any user may remove mappings from another process and
let it crash?

Reading revoke man pages, it seems the system call was meant for
tty devices.  While I can see the generic case  to be useful for
forced unmount, it seems pretty dangerous to allow any user to
revoke file access and tear down mappings.

Who needs the generic case anyway?  IMO that's too much rope.
The effect on affected processes is nearly unpredictable.
IMHO, fuser is "good enough(tm)".

Btw, grep revoke POSIX.txt -> nil.

Ciao, ET.
