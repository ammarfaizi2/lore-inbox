Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932661AbWBTUCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932661AbWBTUCF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 15:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932672AbWBTUCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 15:02:05 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:21667 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S932661AbWBTUCE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 15:02:04 -0500
Message-ID: <43FA202C.9060506@vilain.net>
Date: Tue, 21 Feb 2006 09:01:48 +1300
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
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
References: <20060215145942.GA9274@sergelap.austin.ibm.com> <43F3B820.8030907@vilain.net> <43F98933.2020703@sw.ru>
In-Reply-To: <43F98933.2020703@sw.ru>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:
> I think the first thing we have to do, is not to decide which pids we 
> want to see, but what and how we want to virtualize.

No, let's not even decide on that :).

I think where we've come to, is that there is no *important* difference
between virtualising on a per-process or a per-process family basis, so
long as you can suitably arrange arbitrary families it is equivalent to
the "pure" method of strict per-process virtualisation as Eric has been
implementing.

>> Depending on the flags on the XID, we can incorporate all the approaches
>> being tabled.  You want virtualised pids?  Well, that'll hurt a little,
>> but suit yourself - set a flag on your container and inside the
>> container you get virtualised PIDs.  You want a flat view for all your
>> vservers?  Fine, just use an XID without the virtualisation flag and
>> with the "all seeing eye" property set.  Or you use an XID _with_ the
>> virtualisation flag set, and then call a tuple-endowed API to find the
>> information you're after.
> This sounds good. But pspaces are also used for access controls. So this 
> should be incorparated there as well.

Yes, and I'm hoping that with the central structure there it should be
easy to start re-basing the Linux VServer patch as well as openvz and
any other similar technology people have.

Then we can cherry-pick features from any of the 'competing' solutions
in this space.

I have a preliminary patch, and hope to have a public submission this
week.

Sam.
