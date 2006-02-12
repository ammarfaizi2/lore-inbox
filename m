Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbWBLCDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWBLCDX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 21:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWBLCDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 21:03:23 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:25108 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S932185AbWBLCDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 21:03:22 -0500
X-IronPort-AV: i="4.02,105,1139212800"; 
   d="scan'208"; a="403881716:sNHT32994490"
To: Andrew Morton <akpm@osdl.org>, mst@mellanox.co.il
Cc: Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [git patch review 1/4] IPoIB: Don't start send-only joins while
 multicast thread is stopped
X-Message-Flag: Warning: May contain useful information
References: <1139689341370-68b63fa9b8e76d91@cisco.com>
	<20060211140209.57af1b16.akpm@osdl.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Sat, 11 Feb 2006 18:03:18 -0800
In-Reply-To: <20060211140209.57af1b16.akpm@osdl.org> (Andrew Morton's
 message of "Sat, 11 Feb 2006 14:02:09 -0800")
Message-ID: <ada8xsh49ll.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 12 Feb 2006 02:03:21.0496 (UTC) FILETIME=[7FE56980:01C62F78]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Roland Dreier <rolandd@cisco.com> wrote:
 > >
 > >  +	spin_lock_irq(&priv->lock);
 > >  +	set_bit(IPOIB_MCAST_STARTED, &priv->flags);
 > >  +	spin_unlock_irq(&priv->lock);
 > 
 > Strange to put a lock around an atomic op like that.
 > 
 > Sometimes it's valid.   If another cpu was doing:
 > 
 > 	spin_lock(lock);
 > 
 > 	if (test_bit(IPOIB_MCAST_STARTED))
 > 		something();
 > 	...
 > 	if (test_bit(IPOIB_MCAST_STARTED))
 > 		something_else();
 > 
 > 	spin_unlock(lock);
 > 
 > then the locked set_bit() makes sense.
 > 
 > But often it doesn't ;)

Good point.  Michael, any reason why the lock is there around the
set_bit()?  (And similarly for the corresponding clear_bit())

Thanks,
 Roland
