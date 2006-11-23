Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757178AbWKWRGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757178AbWKWRGB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 12:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757284AbWKWRGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 12:06:01 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:6067 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S1757178AbWKWRGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 12:06:00 -0500
Date: Thu, 23 Nov 2006 18:05:57 +0100
To: Andreas Leitgeb <avl@logic.at>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: possible bug in ide-disk.c (2.6.18.2 but also older)
Message-ID: <20061123170557.GY6851@gamma.logic.tuwien.ac.at>
Reply-To: avl@logic.at
References: <20061120145148.GQ6851@gamma.logic.tuwien.ac.at> <20061120152505.5d0ba6c5@localhost.localdomain> <20061120165601.GS6851@gamma.logic.tuwien.ac.at> <20061120172812.64837a0a@localhost.localdomain> <20061121115117.GU6851@gamma.logic.tuwien.ac.at> <20061121120614.06073ce8@localhost.localdomain> <20061122105735.GV6851@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061122105735.GV6851@gamma.logic.tuwien.ac.at>
User-Agent: Mutt/1.3.28i
From: Andreas Leitgeb <avl@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2006 at 11:57:35AM +0100, Andreas Leitgeb wrote:
> Last evening I got my hands back on that machine,
> checked the kernel-config, and saw that GPT was 
> already *unselected*!
> Actually, the whole "Advanced partition..."-bundle
> was unchecked.

Meanwhile I also found this bugreport (for ubuntu):
  https://launchpad.net/distros/ubuntu/+source/linux-source-2.6.15/+bug/26119
which has quite a few "me,too"s, most of them referring to the 
same (as mine) Seagate 40GB model ST340823A, some others to a 
seagate 20GB model.
And, they are better than me at collecting relevant facts ;-)

Btw., this excerpt:
  hdc: Host Protected Area detected.
          current capacity is 78165360 sectors (40020 MB)
          native  capacity is 78165361 sectors (40020 MB)
  hdc: Host Protected Area disabled.
  hdc: 78165361 sectors (40020 MB) w/1024KiB Cache, CHS=65535/16/63, UDMA(100)
  hdc: cache flushes not supported

looked the same for me those days,  but when retrying lately
with a yet unpatched 2.6.18.3, it reported the current capacity
as 78165359 (one less!) (but the native capacity still 78165361)

After patching away the "addr++;", the logs now say:
  hda: 78165360 sectors (40020 MB) w/512KiB Cache, CHS=65535/16/63, UDMA(100)
and I really got 78165360 sectors according to /proc/ide/hda/capacity.

PS:
Will this turn out as:
  "drive is broken, no kernel workaround will be done, end this thread"
or is a real solution in any way realistic?

