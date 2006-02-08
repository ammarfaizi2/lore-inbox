Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030484AbWBHDgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030484AbWBHDgi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 22:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030493AbWBHDgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 22:36:38 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:34250 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030484AbWBHDgh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 22:36:37 -0500
Date: Tue, 7 Feb 2006 21:36:33 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Sam Vilain <sam@vilain.net>,
       Rik van Riel <riel@redhat.com>, Kirill Korotaev <dev@openvz.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, clg@fr.ibm.com, haveblue@us.ibm.com,
       greg@kroah.com, alan@lxorguk.ukuu.org.uk, arjan@infradead.org,
       saw@sawoct.com, devel@openvz.org, Dmitry Mishin <dim@sw.ru>,
       Andi Kleen <ak@suse.de>, Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: The issues for agreeing on a virtualization/namespaces implementation.
Message-ID: <20060208033633.GA8784@sergelap.austin.ibm.com>
References: <m1bqxju9iu.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.63.0602062239020.26192@cuia.boston.redhat.com> <43E83E8A.1040704@vilain.net> <43E8D160.4040803@watson.ibm.com> <20060207201908.GJ6931@sergelap.austin.ibm.com> <43E90716.4020208@watson.ibm.com> <m17j86dds4.fsf_-_@ebiederm.dsl.xmission.com> <43E92EDC.8040603@watson.ibm.com> <20060208004325.GA15061@ms2.inr.ac.ru> <m1k6c6bm57.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1k6c6bm57.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric W. Biederman (ebiederm@xmission.com):
> Alexey Kuznetsov <kuznet@ms2.inr.ac.ru> writes:
> 
> > Hello!
> >
> >> >2) What is the syscall interface to create these namespaces?
> >> >   - Do we add clone flags?  
> >> >     (Plan 9 style)
> >> 
> >> Like that approach .. flexible .. particular when one has well specified 
> >> namespaces.
> >> 
> >> >   - Do we add a syscall (similar to setsid) per namespace?
> >> >     (Traditional unix style)?
> >> 
> >> Where does that approach end .. what's wrong with doing it at clone() time ?
> >
> > That most of those namespaces need a special setup rather than a plain copy?
> >
> > F.e. what are you going to do with NETWORK namespace? The only valid thing
> > to do is to prepare a new context and to configure its content (addresses,
> > routing tables, iptables...) later. So that, in this case it is natural
> > to inherit the context through clone() and to create new context
> > with a separate syscall.
> 
> With a NETWORK namespace what I implemented was that you get a empty
> namespace with a loopback interface.
> 
> But setting up the namespace from the inside is clearly the sane thing
> todo.

What I tried to do in a proof of concept long ago was to have
CLONE_NETNS mean that you get access to all the network devices, but
then you could drop/add them.  Conceptually I prefer that to getting an
empty namespace, but I'm not sure whether there's any practical use
where you'd want that...

-serge
