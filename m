Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030305AbWFZPWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030305AbWFZPWd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 11:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbWFZPWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 11:22:33 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:62165 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030295AbWFZPWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 11:22:31 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Daniel Lezcano <dlezcano@fr.ibm.com>
Cc: Andrey Savochkin <saw@sw.ru>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, serue@us.ibm.com, haveblue@us.ibm.com,
       clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>, dev@sw.ru,
       herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       viro@ftp.linux.org.uk
Subject: Re: [patch 2/6] [Network namespace] Network device sharing by view
References: <20060609210202.215291000@localhost.localdomain>
	<20060609210625.144158000@localhost.localdomain>
	<20060626134711.A28729@castle.nmd.msu.ru>
	<449FF5A0.2000403@fr.ibm.com>
Date: Mon, 26 Jun 2006 09:21:19 -0600
In-Reply-To: <449FF5A0.2000403@fr.ibm.com> (Daniel Lezcano's message of "Mon,
	26 Jun 2006 16:56:32 +0200")
Message-ID: <m1k674uemo.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Lezcano <dlezcano@fr.ibm.com> writes:

> Andrey Savochkin wrote:
>> Hi Daniel,
>
> Hi Andrey,
>
>> It's good that you kicked off network namespace discussion.
>> Although I wish you'd Cc'ed someone at OpenVZ so I could notice it earlier :).
>
> devel@openvz.org ?
>
>> When a device presents an skb to the protocol layer, it needs to know to which
>> namespace this skb belongs.
>> Otherwise you would never get rid of problems with bind: what to do if device
>> eth1 is visible in namespace1, namespace2, and root namespace, and each
>> namespace has a socket bound to 0.0.0.0:80?
>
> Exact. But, the idea was to retrieve the namespace from the routes.

The problem is that if you start at the routes you have to do things
at layer 3 and you can't do anything at layer 2.  (i.e. You can't use DHCP).
You loose a whole lot of flexibility and power when you make it a
layer 3 only mechanism.

> IMHO, I think there are roughly 2 network isolation implementation:
>
> 	- make all network ressources private to the namespace
>
> 	- keep a "flat" model where network ressources have a new identifier
> which is the network namespace pointer. The idea is to move only some network
> informations private to the namespace (eg port range, stats, ...)

The problem is that you have to add a lot of new logic which is very
hard to get right and has some really weird corner cases that are very
hard to understand.  

- That makes the patches hard to review.  
- It makes it hard for the implementors to get it right.
- It means that there will be corner cases that the users don't
  understand.
- It is less flexible/powerful in what you can express?

I've been down that route it sucks.  Anything more than the simple
filter at bind time is asking for real trouble until you do the whole
thing.

Eric
