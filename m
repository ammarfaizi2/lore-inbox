Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317262AbSGHXtl>; Mon, 8 Jul 2002 19:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317263AbSGHXtk>; Mon, 8 Jul 2002 19:49:40 -0400
Received: from pD9E238F8.dip.t-dialin.net ([217.226.56.248]:17626 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317262AbSGHXtj>; Mon, 8 Jul 2002 19:49:39 -0400
Date: Mon, 8 Jul 2002 17:52:13 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Keith Owens <kaos@ocs.com.au>
cc: Patrick Mochel <mochel@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Driverfs updates 
In-Reply-To: <21467.1026171204@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.44.0207081745150.10105-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 9 Jul 2002, Keith Owens wrote:
> struct device_driver * get_driver(struct device_driver * drv)
> {
 +        struct device_driver *ret = NULL;
 +
 +        if (!drv)
 +                goto out;
 +        lock_somehow(drv->lock);
 +        if (drv->owner)
>                 if (!try_inc_mod_count(drv->owner))
 +                        goto out;
 +
 +        ret = drv;
 + out:
 +        unlock_somehow(drv->lock);
 +        return ret;
> }
> 
> I suggest you add a global driverfs_lock.

Better than locking all kernel threads, isn't it?

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

