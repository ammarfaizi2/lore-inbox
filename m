Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263980AbTDNWKB (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 18:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263965AbTDNWIT (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 18:08:19 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:54248 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263968AbTDNWHV (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 18:07:21 -0400
Date: Mon, 14 Apr 2003 15:21:21 -0700
From: Greg KH <greg@kroah.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Oliver Neukum <oliver@neukum.org>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [RFC] /sbin/hotplug multiplexor
Message-ID: <20030414222121.GA6266@kroah.com>
References: <200304150004.19213.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304150004.19213.arnd@arndb.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 15, 2003 at 12:04:04AM +0200, Arnd Bergmann wrote:
> Oliver Neukum wrote:
> 
> > Well, for a little elegance you might introduce subdirectories for each type
> > of hotplug event and use only them.
> 
> I was just about to propose the same. Please use subdirs or namespaced files
> like in:
> 
> for I in "${DIR}/$1".* "${DIR}/"default.* ; do
> 	test -x $I && $I $1
> done

Hm, default looks good, but why would it have a .*?  How about:

for I in "${DIR}/$1/"* "${DIR}/"default/* ; do 

That way the programs that really care about only one subsystem can be
easily added, while everyone else can drop into the default directory
(which odds are, everyone will want to be in...)

Sound ok?

> Note that a single event can not only cause one hotplug event for many devices
> but also _multiple_ events for every device. E.g. enabling a dasd devices
> will cause hotplug to be called for the local subchannel devices as well as
> the actual (remote) disk. Maybe someone adds hotplug calls for partitions
> and logical volumes.
> Since dasds are usually not larger than 2GB, you are quite likely
> to enable many at the same time. Imagine you get 500 disks * 4 events * 10
> agents in response to a single user command...

Damm, you s390 people, always showing everyone else up :)

Ok, I'll take the '&' out for now, and serialize things within a single
hotplug call.

thanks,

greg k-h
