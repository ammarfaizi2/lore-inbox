Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbWF3Csl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWF3Csl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 22:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbWF3Csl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 22:48:41 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:30385 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S1750810AbWF3Csk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 22:48:40 -0400
Message-ID: <44A49121.4050004@vilain.net>
Date: Fri, 30 Jun 2006 14:49:05 +1200
From: Sam Vilain <sam@vilain.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060521)
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Cedric Le Goater <clg@fr.ibm.com>, hadi@cyberus.ca,
       Herbert Poetzl <herbert@13thfloor.at>, Alexey Kuznetsov <alexey@sw.ru>,
       viro@ftp.linux.org.uk, devel@openvz.org, dev@sw.ru,
       Andrew Morton <akpm@osdl.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, Andrey Savochkin <saw@swsoft.com>,
       Daniel Lezcano <dlezcano@fr.ibm.com>,
       Ben Greear <greearb@candelatech.com>, Dave Hansen <haveblue@us.ibm.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: strict isolation of net interfaces
References: <m1psgulf4u.fsf@ebiederm.dsl.xmission.com> <44A1689B.7060809@candelatech.com> <20060627225213.GB2612@MAIL.13thfloor.at> <1151449973.24103.51.camel@localhost.localdomain> <20060627234210.GA1598@ms2.inr.ac.ru> <m1mzbyj6ft.fsf@ebiederm.dsl.xmission.com> <20060628133640.GB5088@MAIL.13thfloor.at> <1151502803.5203.101.camel@jzny2> <44A44124.5010602@vilain.net> <44A450D1.2030405@fr.ibm.com> <20060630023947.GA24726@sergelap.austin.ibm.com>
In-Reply-To: <20060630023947.GA24726@sergelap.austin.ibm.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge E. Hallyn wrote:
> The last one in your diagram confuses me - why foo0:1?  I would
> have thought it'd be
>
> host                  |  guest 0  |  guest 1  |  guest2
> ----------------------+-----------+-----------+--------------
>   |                   |           |           |
>   |-> l0      <-------+-> lo0 ... | lo0       | lo0
>   |                   |           |           |
>   |-> eth0            |           |           |
>   |                   |           |           |
>   |-> veth0  <--------+-> eth0    |           |
>   |                   |           |           |
>   |-> veth1  <--------+-----------+-----------+-> eth0
>   |                   |           |           |
>   |-> veth2   <-------+-----------+-> eth0    |
>
> [...]
>
> So conceptually using a full virtual net device per container
> certainly seems cleaner to me, and it seems like it should be
> simpler by way of statistics gathering etc, but are there actually
> any real gains?  Or is the support for multiple IPs per device
> actually enough?
>   

Why special case loopback?

Why not:

host                  |  guest 0  |  guest 1  |  guest2
----------------------+-----------+-----------+--------------
  |                   |           |           |
  |-> lo              |           |           |
  |                   |           |           |
  |-> vlo0  <---------+-> lo      |           |
  |                   |           |           |
  |-> vlo1  <---------+-----------+-----------+-> lo
  |                   |           |           |
  |-> vlo2   <--------+-----------+-> lo      |
  |                   |           |           |
  |-> eth0            |           |           |
  |                   |           |           |
  |-> veth0  <--------+-> eth0    |           |
  |                   |           |           |
  |-> veth1  <--------+-----------+-----------+-> eth0
  |                   |           |           |
  |-> veth2   <-------+-----------+-> eth0    |


Sam.
