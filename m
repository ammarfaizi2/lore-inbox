Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbWBHDym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWBHDym (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 22:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWBHDym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 22:54:42 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:24213 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932073AbWBHDyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 22:54:41 -0500
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Hubertus Franke <frankeh@watson.ibm.com>, Sam Vilain <sam@vilain.net>,
       Rik van Riel <riel@redhat.com>, Kirill Korotaev <dev@openvz.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, clg@fr.ibm.com, haveblue@us.ibm.com,
       greg@kroah.com, alan@lxorguk.ukuu.org.uk, arjan@infradead.org,
       saw@sawoct.com, devel@openvz.org, Dmitry Mishin <dim@sw.ru>,
       Andi Kleen <ak@suse.de>, Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: The issues for agreeing on a virtualization/namespaces
 implementation.
References: <m1bqxju9iu.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.63.0602062239020.26192@cuia.boston.redhat.com>
	<43E83E8A.1040704@vilain.net> <43E8D160.4040803@watson.ibm.com>
	<20060207201908.GJ6931@sergelap.austin.ibm.com>
	<43E90716.4020208@watson.ibm.com>
	<m17j86dds4.fsf_-_@ebiederm.dsl.xmission.com>
	<43E92EDC.8040603@watson.ibm.com>
	<20060208004325.GA15061@ms2.inr.ac.ru>
	<m1k6c6bm57.fsf@ebiederm.dsl.xmission.com>
	<20060208033633.GA8784@sergelap.austin.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 07 Feb 2006 20:52:15 -0700
In-Reply-To: <20060208033633.GA8784@sergelap.austin.ibm.com> (Serge E.
 Hallyn's message of "Tue, 7 Feb 2006 21:36:33 -0600")
Message-ID: <m1d5hybj80.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:

>
> What I tried to do in a proof of concept long ago was to have
> CLONE_NETNS mean that you get access to all the network devices, but
> then you could drop/add them.  Conceptually I prefer that to getting an
> empty namespace, but I'm not sure whether there's any practical use
> where you'd want that...

My observation was that the network stack does not come out cleanly
as a namespace unless you adopt the rule that a network device
belongs to exactly one network namespace.

With that rule dealing with the network stack is just a matter of making
some currently global variables/data structures per container.

A pain to do the first round but easy to maintain once you are there
and the logic of the code doesn't need to change.

Eric
