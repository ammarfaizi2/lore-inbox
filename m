Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263579AbTEMVdv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 17:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263576AbTEMVdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 17:33:50 -0400
Received: from windlord.Stanford.EDU ([171.64.19.147]:909 "HELO
	windlord.stanford.edu") by vger.kernel.org with SMTP
	id S263572AbTEMVdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 17:33:47 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       David Howells <dhowells@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, openafs-devel@openafs.org
Subject: Re: [OpenAFS-devel] Re: [PATCH] in-core AFS multiplexor and PAG
 support
References: <Pine.LNX.4.44.0305130849480.1562-100000@home.transmeta.com>
	<1052840663.463.64.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1052840663.463.64.camel@dhcp22.swansea.linux.org.uk> (Alan
 Cox's message of "13 May 2003 16:44:24 +0100")
From: Russ Allbery <rra@stanford.edu>
Organization: The Eyrie
Date: Tue, 13 May 2003 14:46:27 -0700
Message-ID: <ylu1byo6z0.fsf@windlord.stanford.edu>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) XEmacs/21.4 (Portable Code,
 sparc-sun-solaris2.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> How does AFS currently handle this, can two logins of the same user have
> seperate PAGs ?

Yes.  In fact, that's the default situation and it requires some work to
get two logins of the same user into the same PAG.

AFS currently handles PAGs by creating "random" high-numbered groups and
putting the user into them, and then associating the token with that group
in the kernel.

One could debate whether it's best to put a user into the same PAG as
their other logins by default, but it's imperative that a user be able to
create a separate PAG when they wish to (so, for example, they can acquire
separate credentials in that new PAG without affecting the credentials and
PAG for their other running processes).

-- 
Russ Allbery (rra@stanford.edu)             <http://www.eyrie.org/~eagle/>
