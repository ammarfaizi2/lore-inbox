Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263763AbTJORib (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 13:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263764AbTJORia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 13:38:30 -0400
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:2547 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S263763AbTJORiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 13:38:23 -0400
Date: Wed, 15 Oct 2003 11:37:19 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Nikita Danilov <Nikita@Namesys.COM>,
       Erik Mouw <erik@harddisk-recovery.com>,
       Josh Litherland <josh@temp123.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Transparent compression in the FS
Message-ID: <20031015113719.E1593@schatzie.adilger.int>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	Nikita Danilov <Nikita@Namesys.COM>,
	Erik Mouw <erik@harddisk-recovery.com>,
	Josh Litherland <josh@temp123.org>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl> <16269.20654.201680.390284@laputa.namesys.com> <20031015142738.GG24799@bitwizard.nl> <16269.23199.833564.163986@laputa.namesys.com> <Pine.LNX.4.53.0310151150370.7350@chaos> <16269.29716.461117.338214@laputa.namesys.com> <Pine.LNX.4.53.0310151253001.7576@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.53.0310151253001.7576@chaos>; from root@chaos.analogic.com on Wed, Oct 15, 2003 at 01:19:09PM -0400
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 15, 2003  13:19 -0400, Richard B. Johnson wrote:
> On Wed, 15 Oct 2003, Nikita Danilov wrote:
> > It could not if block-level compression is used. Which is the only
> > solution, given random-access to file bodies.
> 
> Then the degenerative case is no compression at all. There is no
> advantage to writing a block that is 1/N full of compressed data.
> You end up having to write the whole block anyway.

In the ext2 compression code, they compress maybe 8 source blocks into
(hopefully) some smaller number of compressed blocks.  Yes, there is still
a minimum block size, but you can save some reasonable fraction of the
total space (e.g. 8 blocks down to 4.5 blocks still gives you 5/8 = 37%
compression, although not 50%).  You get more efficient compression the
more source blocks you use, although your "damage area" grows in case of
error.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

