Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750952AbWDSQzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbWDSQzF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 12:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbWDSQzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 12:55:05 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:39305 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750952AbWDSQzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 12:55:04 -0400
To: Dave Hansen <haveblue@us.ibm.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Kirill Korotaev <dev@sw.ru>,
       linux-kernel@vger.kernel.org, herbert@13thfloor.at, devel@openvz.org,
       sam@vilain.net, xemul@sw.ru, James Morris <jmorris@namei.org>
Subject: Re: [RFC][PATCH 4/5] utsname namespaces: sysctl hack
References: <20060407095132.455784000@sergelap>
	<20060407183600.E40C119B902@sergelap.hallyn.com>
	<4446547B.4080206@sw.ru>
	<20060419152129.GA14756@sergelap.austin.ibm.com>
	<m1bquxmuk5.fsf@ebiederm.dsl.xmission.com>
	<1145463814.31812.13.camel@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 19 Apr 2006 10:52:54 -0600
In-Reply-To: <1145463814.31812.13.camel@localhost.localdomain> (Dave
 Hansen's message of "Wed, 19 Apr 2006 09:23:34 -0700")
Message-ID: <m1u08pld7d.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:

> Besides ipc and utsnames, can anybody think of some other things in
> sysctl that we really need to virtualize?

All of the networking entries.

> It seems to me that most of the other stuff is kernel-global and we
> simply won't allow anything in a container to touch it.
>
> That said, there may be things in the future that need to get added as
> we separate out different subsystems.  Things like min_free_kbytes could
> have a container-centric meaning (although I think that is probably a
> really bad one to mess with).
>
> I have a slightly revamped way of doing the sysv namespace sysctl code.
> I've attached a couple of (still pretty raw) patches.  Do these still
> fall in the "hacks" category?

Only in that you attacked the wrong piece of the puzzle.
The strategy table entries simply need to die, or be rewritten
to use the appropriate proc entries.

The proc entries are the real interface, and the two pieces
don't share an implementation unfortunately.

Eric
