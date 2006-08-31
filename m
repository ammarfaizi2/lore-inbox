Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751654AbWHaPdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751654AbWHaPdS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 11:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751658AbWHaPdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 11:33:18 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:46883 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751388AbWHaPdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 11:33:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mE6xri8A7UuvaHaAJzXrRYsLAwrnKcVfeTqiI8G2uoaf0uBREuymzF2tKcGaD0iA6bvb7+9EanN2ZgPGf9XWHYMyi6Gof4fF5xFBZTfJjUoZ7BDADeZk0kayRiSHrmc+Kjq5o+ta9AmoPF+wn+OumGqReswZAk0WygjfdNleM9E=
Message-ID: <9a8748490608310833x22b0ca30s2130cc388e2bb392@mail.gmail.com>
Date: Thu, 31 Aug 2006 17:33:15 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Ben Greear" <greearb@candelatech.com>
Subject: Re: Unable to halt or reboot due to - unregister_netdevice: waiting for eth0.20 to become free. Usage count = 1
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Mark Evans" <evansmp@uhura.aston.ac.uk>,
       "Fred N. van Kempen" <waltje@uwalt.nl.mugnet.org>,
       "Ross Biro" <ross.biro@gmail.com>, davem@davemloft.net,
       yoshfuji@linux-ipv6.org, netdev@vger.kernel.org
In-Reply-To: <44F70092.3030300@candelatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9a8748490608310817v7d722f88u167b5a84d0ff67e8@mail.gmail.com>
	 <44F70092.3030300@candelatech.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/06, Ben Greear <greearb@candelatech.com> wrote:
> Jesper Juhl wrote:
> > Hi,
> >
> > I've got a small problem with 2.6.18-rc5-git2.
> >
> > I've got a vlan setup on eth0.20, eth0 does not have an IP.
> >
> > When I attempt to reboot or halt the machine I get the following
> > message from the loop in net/core/dev.c::netdev_wait_allrefs() where
> > it waits for the ref-count to drop to zero.
> > Unfortunately the ref-count stays at 1 forever and the server never
> > gets any further.
> >
> >  unregister_netdevice: waiting for eth0.20 to become free. Usage count = 1
> >
> > I googled a bit and found that people have had similar problems in the
> > past and could work around them by shutting down the vlan interface
> > before the 'lo' interface. I tried that and indeed, it works.
> >
> > Any idea how we can get this fixed?
>
> This is usually a ref-count leak somewhere.  Used to be IPv6 had
> issues..then there were some neighbor leaks...but these were fixed as
> far as I know.
>
Using IPv4 here.


> Can you reproduce this on older kernels?
>
I've not actively tried, but I do have several servers running various
older kernel releases with similar vlan setups and I'm not aware of
any problems with those. Only this new box that I'm using for testing
new kernels (currently) shows the problem, and I've only tried 2.6.8
and 2.6.18-rc5-git2 on the box so far (2.6.8 doesn't have the
problem).

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
