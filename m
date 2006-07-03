Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbWGCOxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWGCOxw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 10:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932069AbWGCOxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 10:53:52 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:26631 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id S1750933AbWGCOxv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 10:53:51 -0400
Message-ID: <20060703185350.A16826@castle.nmd.msu.ru>
Date: Mon, 3 Jul 2006 18:53:50 +0400
From: Andrey Savochkin <saw@swsoft.com>
To: Sam Vilain <sam@vilain.net>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>
Cc: hadi@cyberus.ca, Herbert Poetzl <herbert@13thfloor.at>,
       Alexey Kuznetsov <alexey@sw.ru>, viro@ftp.linux.org.uk,
       devel@openvz.org, dev@sw.ru, Andrew Morton <akpm@osdl.org>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       Daniel Lezcano <dlezcano@fr.ibm.com>,
       Ben Greear <greearb@candelatech.com>, Dave Hansen <haveblue@us.ibm.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: strict isolation of net interfaces
References: <20060627225213.GB2612@MAIL.13thfloor.at> <1151449973.24103.51.camel@localhost.localdomain> <20060627234210.GA1598@ms2.inr.ac.ru> <m1mzbyj6ft.fsf@ebiederm.dsl.xmission.com> <20060628133640.GB5088@MAIL.13thfloor.at> <1151502803.5203.101.camel@jzny2> <44A44124.5010602@vilain.net> <44A450D1.2030405@fr.ibm.com> <20060630023947.GA24726@sergelap.austin.ibm.com> <44A49121.4050004@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <44A49121.4050004@vilain.net>; from "Sam Vilain" on Fri, Jun 30, 2006 at 02:49:05PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam, Serge, Cedric,

On Fri, Jun 30, 2006 at 02:49:05PM +1200, Sam Vilain wrote:
> Serge E. Hallyn wrote:
> > The last one in your diagram confuses me - why foo0:1?  I would
> > have thought it'd be
> >
> > host                  |  guest 0  |  guest 1  |  guest2
> > ----------------------+-----------+-----------+--------------
> >   |                   |           |           |
> >   |-> l0      <-------+-> lo0 ... | lo0       | lo0
> >   |                   |           |           |
> >   |-> eth0            |           |           |
> >   |                   |           |           |
> >   |-> veth0  <--------+-> eth0    |           |
> >   |                   |           |           |
> >   |-> veth1  <--------+-----------+-----------+-> eth0
> >   |                   |           |           |
> >   |-> veth2   <-------+-----------+-> eth0    |
> >
> > [...]
> >
> > So conceptually using a full virtual net device per container
> > certainly seems cleaner to me, and it seems like it should be
> > simpler by way of statistics gathering etc, but are there actually
> > any real gains?  Or is the support for multiple IPs per device
> > actually enough?
> >   
> 
> Why special case loopback?
> 
> Why not:
> 
> host                  |  guest 0  |  guest 1  |  guest2
> ----------------------+-----------+-----------+--------------
>   |                   |           |           |
>   |-> lo              |           |           |
>   |                   |           |           |
>   |-> vlo0  <---------+-> lo      |           |
>   |                   |           |           |
>   |-> vlo1  <---------+-----------+-----------+-> lo
>   |                   |           |           |
>   |-> vlo2   <--------+-----------+-> lo      |
>   |                   |           |           |
>   |-> eth0            |           |           |
>   |                   |           |           |
>   |-> veth0  <--------+-> eth0    |           |
>   |                   |           |           |
>   |-> veth1  <--------+-----------+-----------+-> eth0
>   |                   |           |           |
>   |-> veth2   <-------+-----------+-> eth0    |

I still can't completely understand your direction of thoughts.
Could you elaborate on IP address assignment in your diagram, please?  For
example, guest0 wants 127.0.0.1 and 192.168.0.1 addresses on its lo
interface, and 10.1.1.1 on its eth0 interface.
Does this diagram assume any local IP addresses on v* interfaces in the
"host"?

And the second question.
Are vlo0, veth0, etc. devices supposed to have hard_xmit routines?

Best regards

Andrey
