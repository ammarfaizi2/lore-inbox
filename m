Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265133AbTFYWdU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 18:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265135AbTFYWdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 18:33:19 -0400
Received: from relay03.roc.ny.frontiernet.net ([66.133.131.36]:31710 "EHLO
	relay03.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S265133AbTFYWdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 18:33:14 -0400
Date: Wed, 25 Jun 2003 18:47:23 -0400
From: Scott McDermott <vaxerdec@frontiernet.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Dillow <dave@thedillows.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21: kernel BUG at ide-iops.c:1262!
Message-ID: <20030625184723.L9583@newbox.localdomain>
References: <1056493150.2840.17.camel@ori.thedillows.org> <20030624204828.I30001@newbox.localdomain> <1056513292.3885.2.camel@ori.thedillows.org> <1056542418.2460.22.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1056542418.2460.22.camel@dhcp22.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Wed, Jun 25, 2003 at 01:00:18PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox on Wed 25/06 13:00 +0100:
> Its a known problem. There are two approaches. Either
> rewrite the ide scsi reset code to use ide_abort
> infrastructure or switch ide-scsi back to the old
> abort/reset code not new_eh and use SCSI_RESET_PUNT so
> that the recovery is all handled by the ide layer.
> 
> For 2.4 the latter may be the best approach, for 2.5 it
> has to use new_eh

is this what

o       First crack at fixing the ide reset oopses      (me)

tries to fix?

The CDRW devices that have problems with Test Unit Ready
during finalization (like the GCC-4240N) are broken and this
won't fix that problem, but the fix you're talking about
will stop the kernel from crashing when it happens, do I
have that right?
