Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbWBTKFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbWBTKFe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 05:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbWBTKFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 05:05:34 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:25699 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S964818AbWBTKFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 05:05:32 -0500
Message-ID: <43F994C3.9080403@sw.ru>
Date: Mon, 20 Feb 2006 13:06:59 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       vserver@list.linux-vserver.org, Herbert Poetzl <herbert@13thfloor.at>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Greg <gkurz@fr.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Rik van Riel <riel@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
Subject: Re: (pspace,pid) vs true pid virtualization
References: <20060215145942.GA9274@sergelap.austin.ibm.com>	<m11wy4s24i.fsf@ebiederm.dsl.xmission.com>	<20060216142928.GA22358@sergelap.austin.ibm.com> <m17j7vqmy1.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m17j7vqmy1.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>This is to support using pidspaces for vservers, and creating
>>migrateable sub-pidspaces in each vserver.
> 
> 
> Agreed.
> 
> Now this case is very interesting, because supporting it creates
> interesting restrictions on the rest of the problem, and
> unless I miss something this is where the OpenVZ implementation
> currently falls down.
why do you think so? VPIDs approach supports nested pspaces easily. 
Moreover it can be used in any configuration. See below.

> Which names does the intermediate pidspace (vserver) see the child
> pidspace with
options:
- all pspaces except for host system can live fully with virtual pids
- you can restrict what parent pspace can see from it's child. and as in 
your case you can see only "init".
- you can make fully isolated pspaces, where these problems doesn't 
arise at all.


> Which names does the initial pidspace see the child pid space with?
initial pidspace always sees "global" pids.

>>>- Do we need to be able to be able to ptrace/kill individual processes
>>>  in a pid space, from the outside, and why?
>>
>>I think this is completely unnecessary so long as a process can enter a
>>pidspace.
See my other emails. This is required.
1. Enter doesn't always work. e.g. due to resource limitations.
2. you may don't want to install some apps inside, especiall taking into 
account that libs in VPS can be broken.

>>But you have, haven't you?  Namely, how can openvz provide it's
>>customers with a global view of all processes without putting 5 years of
>>work into a new sysadmin interface?
> Well I think we can reuse most of the old sysadmin interfaces yes.
Doesn't look so.

Kirill


