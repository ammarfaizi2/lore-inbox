Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbTE0Oqq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 10:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263738AbTE0Oqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 10:46:46 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:11527 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263726AbTE0Oqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 10:46:44 -0400
Subject: Re: [BK PATCHES] add ata scsi driver
From: James Bottomley <James.Bottomley@steeleye.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       jgarzik@pobox.com
In-Reply-To: <Pine.LNX.4.44.0305270734320.20127-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0305270734320.20127-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 27 May 2003 10:59:51 -0400
Message-Id: <1054047595.1975.64.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-27 at 10:36, Linus Torvalds wrote:
    Btw, in case you wonder why I care about names and organization, it's 
    because with the names and organization comes assumptions and 
    expectations.
    
    One prime example of this is cdrecord, and the incredible braindamage that
    the name "SCSI" foisted upon it. Why? Because everybody (ie schily)  
    _knows_ that SCSI is addressed by bus/id/lun, and thinks that anything
    else is wrong. So you have total idiocies like the "cdrecord -scanbus"  
    crap for finding your device, and totally useless naming that makes no 
    sense in any sane environment.
    
    Calling something SCSI when it isn't brings on these kinds of bad things: 
    people make assuptions that aren't sensible or desireable.
    
    Names have power. There's baggage and assumptions in a name. In the case
    of SCSI, there is a _lot_ of baggage.
    
I took this one on board a long time ago.  Even in the SCSI world, FC
devices don't think in terms of PUN, they think in terms of WWN.

If you look at the mid layer (and I don't promise this to be complete
yet) we're moving away from referring to things by host/channel/id/lun. 
Now we just have host/device list in most places.  About the only place
we convert back to the numbers is to print messages.

We're certainly not there yet, since we need to support legacy
interfaces like /proc/scsi/scsi.  But eventually you'll probably see us
using the sysfs name instead of the id (FC devices will probably stuff
WWNs in here, other things may use numbers) and lun (not sure how we'll
represent SCSI-3 LUN hierarchies yet).  Hopefully, it will be possible
to make the mid layer entirely unaware of any id/lun distinction so it
could be configured for a flatter host/device space instead.

James




