Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbTEMQpD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 12:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbTEMQpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 12:45:03 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:63758 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261710AbTEMQo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 12:44:59 -0400
Date: Tue, 13 May 2003 09:57:13 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: David Howells <dhowells@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-fsdevel@vger.kernel.org>, <openafs-devel@openafs.org>
Subject: Re: [PATCH] in-core AFS multiplexor and PAG support
In-Reply-To: <1052840663.463.64.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0305130950030.1678-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 13 May 2003, Alan Cox wrote:
>
> With something like SELinux a PAG may belong to a role not to a user
> even though other limits like processes probably belong to the user as a
> whole. 

Hmm.. That doesn't make a lot of sense to me.

A "user" is by definition what the unix filesystem considers to be the
"atom of security". In fact, a "user" has no other meaning - except for
the notion of "root", which is obviously special and has meaning outside
of the scope of filesystems (and even here capabilities have tried to
separate out that meaning from the "user" definition).

But if we want to split up users into "roles", then sure, we can have a
"role" that is shared across processes. But I think that for _usability_
we really want that to be _shared_ by default, and anybody who wants to
split it should have to work at it. Exactly so that when you log in, and
use your private key to mount some encrypted volume, _all_ your processes
should by default get access to it. Even if the other ones were
independent logins (another window with another ssh session to that
machine).

In other words: I really think usability should count very high on the 
list of requirements. Much higher than SELinux.

		Linus

