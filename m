Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbWDSRjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWDSRjY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 13:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbWDSRjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 13:39:24 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:8586 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750903AbWDSRjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 13:39:23 -0400
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
	<m1u08pld7d.fsf@ebiederm.dsl.xmission.com>
	<1145467159.31812.21.camel@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 19 Apr 2006 11:37:00 -0600
In-Reply-To: <1145467159.31812.21.camel@localhost.localdomain> (Dave
 Hansen's message of "Wed, 19 Apr 2006 10:19:18 -0700")
Message-ID: <m1zmihjwlf.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:

> On Wed, 2006-04-19 at 10:52 -0600, Eric W. Biederman wrote:
>> Dave Hansen <haveblue@us.ibm.com> writes:
>> 
>> > Besides ipc and utsnames, can anybody think of some other things in
>> > sysctl that we really need to virtualize?
>> 
>> All of the networking entries.
> ...
>> Only in that you attacked the wrong piece of the puzzle.
>> The strategy table entries simply need to die, or be rewritten
>> to use the appropriate proc entries.
>
> If we are limited to ipc, utsname, and network, I'd be worried trying to
> justify _too_ much infrastructure.  The network namespaces are not going
> to be solved any time soon.  Why not have something like this which is a
> quite simple, understandable, minor hack?

Because it doesn't affect what happens in /proc/sys !
Strategy routines only affect sys_sysctl.

As strategy routines I have no real problems with them.
I haven't looked terribly closely yet.

>> The proc entries are the real interface, and the two pieces
>> don't share an implementation unfortunately.
>
> You're saying that the proc interface doesn't use the ->strategy entry?
> That isn't what I remember, but I could be completely wrong.

Exactly.   I have a patch I will be sending out shortly that
make sys_sysctl a compile time option (so we can seriously start killing it)
and it compiles out the strategy routines and /proc/sys still works :)

Eric
