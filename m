Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267692AbTBNPJR>; Fri, 14 Feb 2003 10:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268422AbTBNPJR>; Fri, 14 Feb 2003 10:09:17 -0500
Received: from zmamail01.zma.compaq.com ([161.114.64.101]:58885 "EHLO
	zmamail01.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S267692AbTBNPJQ>; Fri, 14 Feb 2003 10:09:16 -0500
Date: Fri, 14 Feb 2003 09:20:12 +0600
From: steve cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Accessing the same disk via multiple channels 
Message-ID: <20030214032012.GA5481@zuul.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Lars Marowsky-Bree (lmb@suse.de) wrote:

> SuSE (Jens Axboe and myself) have also done work on the md multipathing,
> supporting failover and load balancing and in general giving the code a rinse;
> as well as extensions to mdadm to make them work.
> 
Yay!  We noticed that if a controller fails in such a way that
no interrupts are generated then md driver doesn't notice anything is 
wrong.  Commands don't fail, but don't complete either.  I played around with
feature in the low level driver to periodically send a no-op command
down to the controller and fail all outstanding commands and disable
the controller if that command didn't come back pretty quickly, that 
seemed to work pretty well in a failover type situation. 
(Better than putting a timeout on every command.)  Also, md multipath 
doesn't notice if the backup path has failed, to warn the user that 
redundancy is no longer in effect.  (Though if you set up things so i/o 
is going down both paths, not such a big deal, as md will notice.
Probably you know all this already.

> The patches currently live at http://lars.marowsky-bree.de/dl/md-mp/
> 
> (And are included in SuSE's kernel release, of course ;-)
> 
> Currently, for 2.5 / 2.6, I think I really like the SCSI midlayer stuff. In
> the past, I didn't, because it constrains everything to SCSI. But then,
> everything so far _has_ been SCSI, except for weird arch stuff like s390(x)
> DASDs ;-)

Well, the cciss driver is not a SCSI driver (except for purpsoes of 
tape drives & tape changers) and HP/Compaq has sold more than one 
million of those controllers (does popularity mean they aren't 
"weird"? :-), and we have mulitpath capable storage boxes they 
can connect to.

-- steve

