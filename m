Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269518AbUICQt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269518AbUICQt4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 12:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269524AbUICQtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 12:49:20 -0400
Received: from gsstark.mtl.istop.com ([66.11.160.162]:391 "EHLO
	stark.xeocode.com") by vger.kernel.org with ESMTP id S269436AbUICQrE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 12:47:04 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg Stark <gsstark@mit.edu>, Brad Campbell <brad@wasp.net.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Crashed Drive, libata wedges when trying to recover data
References: <87oekpvzot.fsf@stark.xeocode.com> <4136E277.6000408@wasp.net.au>
	<87u0ugt0ml.fsf@stark.xeocode.com>
	<1094209696.7533.24.camel@localhost.localdomain>
	<87d613tol4.fsf@stark.xeocode.com>
	<1094219609.7923.0.camel@localhost.localdomain>
	<877jrbtkds.fsf@stark.xeocode.com>
	<1094224166.8102.7.camel@localhost.localdomain>
In-Reply-To: <1094224166.8102.7.camel@localhost.localdomain>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 03 Sep 2004 12:47:00 -0400
Message-ID: <871xhjti4b.fsf@stark.xeocode.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Gwe, 2004-09-03 at 16:58, Greg Stark wrote:
> > I've even unmounted the filesystem and tried mounting it again. Now I can't
> > even mount it without generating the error.
> 
> You may well need to reset or powercycle the drive to get it back from
> such a state.

Certainly I know power cycling fixes it. That's what I've been doing so far.

> > Sep  3 11:48:39 stark kernel: ata1: command 0x25 timeout, stat 0x59 host_stat 0x21
> > Sep  3 11:48:39 stark kernel: ata1: status=0x59 { DriveReady SeekComplete DataRequest Error }
> > Sep  3 11:48:39 stark kernel: ata1: error=0x01 { AddrMarkNotFound }
> 
> "Its dead Jim". Once you get a drive that dies totally (or just keeps
> posting up a hardware fail) after the error you are into forensics
> (and/or backup) land. 

There's nothing the driver can do to reset the drive or get back to a known
good protocol state?

The "ATA: abnormal status 0x59 on port 0xEFE7" makes me think it's just the
driver getting out of sync with the drive. But i guess that would be hard to
distinguish from the drive just going south.

Certainly if I had backups I would long since have given up on this. And I've
already managed to recover the most important stuff from the drive. At this
point I'm still missing some stuff I would like to be able to recover as much
as I can from.

But I'm mostly just interested in helping ensure the driver handles this case
as well as it can. Ideally it should printk errors and return i/o errors to
user-space but reset as necessary and still allow reading good blocks as much
as possible.

-- 
greg

