Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbVC3Flh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbVC3Flh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 00:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVC3Flh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 00:41:37 -0500
Received: from orb.pobox.com ([207.8.226.5]:50850 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261317AbVC3Fk5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 00:40:57 -0500
Date: Tue, 29 Mar 2005 21:40:47 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Aligning file system data
Message-ID: <20050330054047.GA3282@ip68-4-98-123.oc.oc.cox.net>
References: <424A2BD0.5010609@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424A2BD0.5010609@comcast.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2005 at 11:32:16PM -0500, John Richard Moser wrote:
> Does crossing a
> track boundary incur anything expensive?

AFAIK, yes. It's going to involve some kind of seeking (even a head
switch needs microjogging on modern drives), and it will certainly add
latency (although I don't remember how much, off the top of my head).

However, trying to control this from the kernel may be vastly harder
than you're expecting (assuming a modern hard drive). You may want to
look at these pages for more info:

http://www.storagereview.com/guide2000/ref/hdd/geom/tracksZBR.html
http://www.storagereview.com/guide2000/ref/hdd/geom/geomLogical.html

Also look at the last paragraph on this page -- not the paragraph with
the "Stop" sign, but the one after it:
http://www.storagereview.com/guide2000/ref/hdd/geom/formatDefect.html


I think this could in fact be done, but it would be a lot of effort,
and the kernel would need knowledge on a per-drive-model basis (or
at least it would need a way to obtain such knowledge from user space,
and the per-model knowledge would need to be stored there somehow).
For all I know, vendor-specific commands might also be needed in order
to find out which blocks are remapped, in order to use that knowledge to
avoid changing tracks spuriously. (And one other note: Since your device
almost certainly has many tracks with well over 256 sectors in reality,
your device is actually incapable of reading or writing a single track
with a single ATA command unless it supports LBA48.)

-Barry K. Nathan <barryn@pobox.com>
