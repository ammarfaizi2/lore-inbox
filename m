Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264097AbUFBUpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264097AbUFBUpi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 16:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264026AbUFBUpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 16:45:38 -0400
Received: from h001061b078fa.ne.client2.attbi.com ([24.91.86.110]:41354 "EHLO
	linuxfarms.com") by vger.kernel.org with ESMTP id S264097AbUFBUpg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 16:45:36 -0400
Date: Wed, 2 Jun 2004 16:46:56 -0400 (EDT)
From: Arthur Perry <kernel@linuxfarms.com>
X-X-Sender: kernel@tiamat.perryconsulting.net
To: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
cc: linux-kernel@vger.kernel.org, Al Piszcz <apiszcz@solarrain.com>
Subject: Re: How come dd if=/dev/zero of=/nfs/dev/null does not send packets
 over the network?
In-Reply-To: <5D3C2276FD64424297729EB733ED1F7606243695@email1.mitretek.org>
Message-ID: <Pine.LNX.4.58.0406021641300.14423@tiamat.perryconsulting.net>
References: <5D3C2276FD64424297729EB733ED1F7606243695@email1.mitretek.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If your goal is to simply push the network (and here I am assuming you are
just using nfs for that reason simply because it seemed easy to set up and
do), and using nfs to create an actual file on disk on the other side
isn't going to be fast enough, try using netcat instead.. no nfs.

You can have netcat listen on a socket at the receiving end and redirect
to /dev/null. It is initiated on the recieving end, thus /dev/null will be
referenced by that machine.
You then can connect to it on the sending end with netcat and source from
your /dev/zero.

I used to do this, and use 'time' to determine how long it took to move xx
bytes.
It's a quick and dirty really.. But works well for rough approximations.

Arthur Perry
Lead Linux Developer / Linux Systems Architect
Validation, CSU Celestica
Sair/Linux Gnu Certified Professional
Providing professional Linux solutions for 7+ years



On Wed, 2 Jun 2004, Piszcz, Justin Michael wrote:

> root@jpiszcz:~# mkdir /p500/dev
> root@jpiszcz:~# mount 192.168.0.253:/dev /p500/dev
> root@jpiszcz:~# echo blah > /p500/dev/null
> root@jpiszcz:~# ls -l /p500/dev/null
> crw-rw-rw-  1 root sys 1, 3 Jul 17  1994 /p500/dev/null
> root@jpiszcz:~# dd if=/dev/zero of=/p500/dev/null
>
> 6179737+0 records in
> 6179736+0 records out
>
> Instead it treats it as a local block device?
>
> Kernel 2.6.5.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
