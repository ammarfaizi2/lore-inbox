Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263024AbUIDV6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbUIDV6f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 17:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263100AbUIDV6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 17:58:35 -0400
Received: from gsstark.mtl.istop.com ([66.11.160.162]:18060 "EHLO
	stark.xeocode.com") by vger.kernel.org with ESMTP id S263024AbUIDV6b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 17:58:31 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Brad Campbell <brad@wasp.net.au>, Greg Stark <gsstark@mit.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Crashed Drive, libata wedges when trying to recover data
References: <87oekpvzot.fsf@stark.xeocode.com> <4136E277.6000408@wasp.net.au>
	<87u0ugt0ml.fsf@stark.xeocode.com> <413868CE.7070303@wasp.net.au>
	<1094220595.7923.14.camel@localhost.localdomain>
In-Reply-To: <1094220595.7923.14.camel@localhost.localdomain>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 04 Sep 2004 17:58:23 -0400
Message-ID: <87y8jppugw.fsf@stark.xeocode.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > Jeff, do we really have to wait 30 seconds for a timeout? If the drive hits an unreadble spot I 
> > would have thought it would come back to us with a read error rather than timing out the command.
> 
> The drive will retry for a few seconds then fail. The failure now
> generates a SCSI medium error to the core scsi layer and it does like to
> issue a few retries. The default retry count for scsi is probably too
> high for SATA given the drive retries.

Certainly over an hour seems a little excessive:

$ time dd bs=512 count=1  if=/dev/sda4 of=/dev/null
dd: reading `/dev/sda4': Input/output error
0+0 records in
0+0 records out

real    67m59.382s
user    0m0.001s
sys     0m0.002s

bash-2.05b# time mount /dev/sda4 /u4
/dev/sda4: Input/output error
mount: you must specify the filesystem type

real    71m59.322s
user    0m0.000s
sys     0m0.004s
bash-2.05b# 

-- 
greg

