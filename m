Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261375AbTBSRKF>; Wed, 19 Feb 2003 12:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261398AbTBSRKF>; Wed, 19 Feb 2003 12:10:05 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:59276
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261375AbTBSRKB>; Wed, 19 Feb 2003 12:10:01 -0500
Subject: Re: PATCH: clean up the IDE iops, add ones for a dead iface
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1045674387.12533.48.camel@zion.wanadoo.fr>
References: <Pine.LNX.4.44.0302190853180.18995-100000@home.transmeta.com>
	 <1045674387.12533.48.camel@zion.wanadoo.fr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045678925.27427.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 19 Feb 2003 18:22:06 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-19 at 17:06, Benjamin Herrenschmidt wrote:
> Yup, you are right. Removing a disk from a controller shall return
> anything with bit 7 at 0 per spec, but removing the controller
> itself will return 0xff. Actually, in my "wait for BSY low" loop
> I added to the probe code for pmac (should be made generic sooner
> or later), I did special case 0xff.
> 
> So we should indeed fix the various bits in IDE. 0xff out of
> status, I beleive, never means anything and can always be considered
> as "this interface is gone".

I think thats the wrong approach too. We need to be defensive on things
like IDE probes. We just have to be sure that we -do- eventually say
'its bust', and when we know from hotplug a channel has vanished also
be sure to check the 'its dead jim' flag once I add it

