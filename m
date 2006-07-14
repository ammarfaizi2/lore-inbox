Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422640AbWGNRAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422640AbWGNRAS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 13:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161269AbWGNRAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 13:00:18 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:42655 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1161267AbWGNRAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 13:00:16 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Cedric Le Goater <clg@fr.ibm.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Andrey Savochkin <saw@sw.ru>, Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH -mm 5/7] add user namespace
References: <20060711075051.382004000@localhost.localdomain>
	<20060711075420.937831000@localhost.localdomain>
	<m1fyh7eb9i.fsf@ebiederm.dsl.xmission.com>
	<44B50088.1010103@fr.ibm.com>
	<m1psgaag7y.fsf@ebiederm.dsl.xmission.com>
	<20060714141728.GE28436@sergelap.austin.ibm.com>
	<m1fyh4w7ju.fsf@ebiederm.dsl.xmission.com>
	<20060714164640.GC25303@sergelap.austin.ibm.com>
Date: Fri, 14 Jul 2006 10:58:57 -0600
In-Reply-To: <20060714164640.GC25303@sergelap.austin.ibm.com> (Serge
	E. Hallyn's message of "Fri, 14 Jul 2006 11:46:40 -0500")
Message-ID: <m1zmfct966.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> Quoting Eric W. Biederman (ebiederm@xmission.com):
>> "Serge E. Hallyn" <serue@us.ibm.com> writes:
>> >> No.  The uids in a filesystem are interpreted in some user namespace
>> >> context.  We can discover that context at the first mount of the
>> >> filesystem.  Assuming the uids on a filesystem are the same set
>> >> of uids your process is using is just wrong.
>> >
>> > But, when I insert a usb keychain disk into my laptop, that fs assumes
>> > the uids on it's fs are the same as uids on my laptop...
>> 
>> I agree that setting the fs_user_namespace at mount time is fine.
>> However when we use a mount that a process in another user namespace
>> we need to not assume the uids are the same.
>> 
>> Do you see the difference?
>
> Aaah - so you don't want to store this on the fs.  So this is actually
> like what I had mentioned many many emails ago?

Quite possibly.  I'm not certain where you go the idea I was thinking
of storing this on the fs.  I think you must have been thinking of
the Linux-Vserver implementation.

>> Actually I was thinking something as mundane as a mapping table.  This
>> uid in this namespace equals that uid in that other namespace.
>
> I see.
>
> That's also what I was imagining earlier, but it seems crass somehow.
> I'd almost prefer to just tag a mount with a user namespace implicitly,
> and only allow the mounter to say 'do' or 'don't' allow this to be read
> by users in another namespace.  Then in the 'don't' case, user joe
> [1000] can't read files belonging to user jack [1000] in another
> namespace.  It's stricter, but clean.
>
> But whether we do mapping tables or simple isolation, I do still like
> the idea of pursuing the use of the keystore for global uids.

Yes.  I guess my thinking is that the mapping effort and keys are an
enhancement after we get the basic user namespace working, to overcome
the limitations.

Eric
