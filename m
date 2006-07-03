Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbWGCNgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWGCNgG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 09:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWGCNgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 09:36:06 -0400
Received: from MAIL.13thfloor.at ([212.16.62.50]:23258 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1751166AbWGCNgE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 09:36:04 -0400
Date: Mon, 3 Jul 2006 15:36:02 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Sam Vilain <sam@vilain.net>,
       hadi@cyberus.ca, Alexey Kuznetsov <alexey@sw.ru>, viro@ftp.linux.org.uk,
       devel@openvz.org, dev@sw.ru, Andrew Morton <akpm@osdl.org>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrey Savochkin <saw@swsoft.com>, Daniel Lezcano <dlezcano@fr.ibm.com>,
       Ben Greear <greearb@candelatech.com>, Dave Hansen <haveblue@us.ibm.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: strict isolation of net interfaces
Message-ID: <20060703133602.GB25534@MAIL.13thfloor.at>
Mail-Followup-To: Cedric Le Goater <clg@fr.ibm.com>,
	"Serge E. Hallyn" <serue@us.ibm.com>, Sam Vilain <sam@vilain.net>,
	hadi@cyberus.ca, Alexey Kuznetsov <alexey@sw.ru>,
	viro@ftp.linux.org.uk, devel@openvz.org, dev@sw.ru,
	Andrew Morton <akpm@osdl.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Andrey Savochkin <saw@swsoft.com>,
	Daniel Lezcano <dlezcano@fr.ibm.com>,
	Ben Greear <greearb@candelatech.com>,
	Dave Hansen <haveblue@us.ibm.com>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	"Eric W. Biederman" <ebiederm@xmission.com>
References: <20060627225213.GB2612@MAIL.13thfloor.at> <1151449973.24103.51.camel@localhost.localdomain> <20060627234210.GA1598@ms2.inr.ac.ru> <m1mzbyj6ft.fsf@ebiederm.dsl.xmission.com> <20060628133640.GB5088@MAIL.13thfloor.at> <1151502803.5203.101.camel@jzny2> <44A44124.5010602@vilain.net> <44A450D1.2030405@fr.ibm.com> <20060630023947.GA24726@sergelap.austin.ibm.com> <44A4E72D.2060105@fr.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A4E72D.2060105@fr.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2006 at 10:56:13AM +0200, Cedric Le Goater wrote:
> Serge E. Hallyn wrote:
> > 
> > The last one in your diagram confuses me - why foo0:1?  I would
> > have thought it'd be
> 
> just thinking aloud. I thought that any kind/type of interface could be
> mapped from host to guest.
> 
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
> > I think we should avoid using device aliases, as trying to do
> > something like giving eth0:1 to guest1 and eth0:2 to guest2
> > while hiding eth0:1 from guest2 requires some uglier code (as
> > I recall) than working with full devices.  In other words,
> > if a namespace can see eth0, and eth0:2 exists, it should always
> > see eth0:2.
> > 
> > So conceptually using a full virtual net device per container
> > certainly seems cleaner to me, and it seems like it should be
> > simpler by way of statistics gathering etc, but are there actually
> > any real gains?  Or is the support for multiple IPs per device
> > actually enough?
> > 
> > Herbert, is this basically how ngnet is supposed to work?

hard to tell, we have at least three ngnet prototypes
and basically all variants are covered there, from
separate interfaces which map to real ones to perfect
isolation of addresses assigned to global interfaces

IMHO the 'virtual' interface per guest is fine, as
the overhead and consumed resources are non critical
and it will definitely simplify handling for the
guest side

I'd really appreciate if we could find a solution which
allows both, isolation and virtualization, and if the
bridge scenario is as fast as a direct mapping, I'm
perfectly fine with a big bridge + ebtables to handle
security issues

best,
Herbert

