Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261734AbTCZP6Z>; Wed, 26 Mar 2003 10:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261744AbTCZP6Z>; Wed, 26 Mar 2003 10:58:25 -0500
Received: from waste.org ([209.173.204.2]:64493 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S261734AbTCZP6X>;
	Wed, 26 Mar 2003 10:58:23 -0500
Date: Wed, 26 Mar 2003 10:09:09 -0600
From: Matt Mackall <mpm@selenic.com>
To: Lincoln Dale <ltd@cisco.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, ptb@it.uc3m.es,
       Justin Cormack <justin@street-vision.com>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ENBD for 2.5.64
Message-ID: <20030326160908.GG20244@waste.org>
References: <3E81132C.9020506@pobox.com> <200303252053.h2PKrRn09596@oboe.it.uc3m.es> <3E81132C.9020506@pobox.com> <5.1.0.14.2.20030326182627.0387b1a0@mira-sjcm-3.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20030326182627.0387b1a0@mira-sjcm-3.cisco.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 26, 2003 at 06:31:31PM +1100, Lincoln Dale wrote:
> At 11:55 PM 25/03/2003 -0600, Matt Mackall wrote:
> >> Yeah, iSCSI handles all that and more.  It's a behemoth of a
> >> specification.  (whether a particular implementation implements all that
> >> stuff correctly is another matter...)
> >
> >Indeed, there are iSCSI implementations that do multipath and
> >failover.
> 
> iSCSI is a transport.
> logically, any "multipathing" and "failover" belongs in a layer above it -- 
> typically as a block-layer function -- and not as a transport-layer 
> function.
>
> multipathing belongs elsewhere -- whether it be in MD, LVM, EVMS, DevMapper 
> PowerPath, ...

Funny then that I should be talking about Cisco's driver. :P

iSCSI inherently has more interesting reconnect logic than other block
devices, so it's fairly trivial to throw in recognition of identical
devices discovered on two or more iSCSI targets..
 
> >Both iSCSI and ENBD currently have issues with pending writes during
> >network outages. The current I/O layer fails to report failed writes
> >to fsync and friends.
> 
> these are not "iSCSI" or "ENBD" issues.  these are issues with VFS.

Except that the issue simply doesn't show up for anyone else, which is
why it hasn't been fixed yet. Patches are in the works, but they need
more testing:

http://www.selenic.com/linux/write-error-propagation/

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
