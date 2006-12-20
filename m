Return-Path: <linux-kernel-owner+w=401wt.eu-S1030370AbWLTVw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030370AbWLTVw5 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 16:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030371AbWLTVw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 16:52:57 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:58836 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030370AbWLTVw4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 16:52:56 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4589B09E.40503@s5r6.in-berlin.de>
Date: Wed, 20 Dec 2006 22:52:30 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061202 SeaMonkey/1.0.6
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
CC: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/4] New firewire stack - updated patches
References: <20061220005822.GB11746@devserv.devel.redhat.com> <458913AC.7080300@s5r6.in-berlin.de> <45897478.6070308@redhat.com> <45898785.4000209@s5r6.in-berlin.de> <458997B5.3040607@redhat.com>
In-Reply-To: <458997B5.3040607@redhat.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristian Høgsberg wrote:
> And as for gap count optimization, I just added that to my git repo.

What can I say.

...
> and the optimization is definitely noticable.  This is  a setup
> where the box and the disk are both connected to a hub so the max hops
> is 2, so we're using gap count 4:
...
> Though I see that Mac OS X uses a more conservative setting for a
> similiar topology, so maybe we need to add a bit or "margin" to the
> numbers from the table from 1394.

The table in IEEE 1394-1995 is not entirely safe. Use the one from IEEE
1394a-2000:

Hops  GC     Hops  GC     Hops  GC     Hops  GC     Hops  GC
   1   5        6  16       11  29       16  43       21  57
   2   7        7  18       12  32       17  46       22  59
   3   8        8  21       13  35       18  48       23  62
   4  10        9  24       14  37       19  51
   5  13       10  26       15  40       20  54

(It's certainly not necessary to optimize for more than ~8 hops.)

But note, this does not work anymore as soon as there is an 1394b node
in the mix --- at least with one or more 1394b repeater node, I'm not
sure about 1394b leaf nodes. Because of the potentially much larger
repeater delays of 1394b PHYs, the only suitable method to determine a
working least gap count of such setups is round-trip delay measurement
with ping packets. But a good compromise would be to run table-based gap
count optimization for 1394a environments and no optimization for 1394b
or mixed environments. (Even though the latter would also clearly
benefit from it.)
-- 
Stefan Richter
-=====-=-==- ==-- =-=--
http://arcgraph.de/sr/
