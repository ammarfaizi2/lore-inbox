Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269100AbUJQLVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269100AbUJQLVr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 07:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269102AbUJQLVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 07:21:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45989 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269100AbUJQLVp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 07:21:45 -0400
Date: Sun, 17 Oct 2004 07:20:14 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Alexandre Oliva <aoliva@redhat.com>
cc: jmoyer@redhat.com, "Stephen C. Tweedie" <sct@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [patch rfc] towards supporting O_NONBLOCK on regular files
In-Reply-To: <orzn2lpyfc.fsf@livre.redhat.lsd.ic.unicamp.br>
Message-ID: <Pine.LNX.4.58.0410170715240.16806@devserv.devel.redhat.com>
References: <16733.50382.569265.183099@segfault.boston.redhat.com>
 <20041005112752.GA21094@logos.cnet> <16739.61314.102521.128577@segfault.boston.redhat.com>
 <20041006120158.GA8024@logos.cnet> <1097119895.4339.12.camel@orbit.scot.redhat.com>
 <20041007101213.GC10234@logos.cnet> <1097519553.2128.115.camel@sisko.scot.redhat.com>
 <16746.55283.192591.718383@segfault.boston.redhat.com>
 <1097531370.2128.356.camel@sisko.scot.redhat.com>
 <16749.15133.627859.786023@segfault.boston.redhat.com>
 <16751.61561.156429.120130@segfault.boston.redhat.com>
 <orzn2lpyfc.fsf@livre.redhat.lsd.ic.unicamp.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 17 Oct 2004, Alexandre Oliva wrote:

> The reason Squid breaks is that poll (or is it select? I forget) says
> there's data to be read from cache files (as well as from error message
> files read during start up), but then read fails with -EAGAIN. If I
> bring the error files into memory with cat /etc/squid/errors/ERR*, then
> squid will successfully start up, and then, in order for it to not eat
> all the available CPU polling data files and attempting to read from
> them, I need to start a command line this:

the problem is that upon read() we dont 'kick' any IO if there's no data
available. I.e. the readahead-kicking is necessary after all, because
squid apparently assumes that re-trying a read will eventually succeed.  
(Tux on the other hand does not assume this and uses helper threads to
kick IO.)

	Ingo
