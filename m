Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161265AbWGNQrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161265AbWGNQrn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 12:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161266AbWGNQrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 12:47:43 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:9361 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161265AbWGNQrn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 12:47:43 -0400
Date: Fri, 14 Jul 2006 11:46:40 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Cedric Le Goater <clg@fr.ibm.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH -mm 5/7] add user namespace
Message-ID: <20060714164640.GC25303@sergelap.austin.ibm.com>
References: <20060711075051.382004000@localhost.localdomain> <20060711075420.937831000@localhost.localdomain> <m1fyh7eb9i.fsf@ebiederm.dsl.xmission.com> <44B50088.1010103@fr.ibm.com> <m1psgaag7y.fsf@ebiederm.dsl.xmission.com> <20060714141728.GE28436@sergelap.austin.ibm.com> <m1fyh4w7ju.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1fyh4w7ju.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric W. Biederman (ebiederm@xmission.com):
> "Serge E. Hallyn" <serue@us.ibm.com> writes:
> >> No.  The uids in a filesystem are interpreted in some user namespace
> >> context.  We can discover that context at the first mount of the
> >> filesystem.  Assuming the uids on a filesystem are the same set
> >> of uids your process is using is just wrong.
> >
> > But, when I insert a usb keychain disk into my laptop, that fs assumes
> > the uids on it's fs are the same as uids on my laptop...
> 
> I agree that setting the fs_user_namespace at mount time is fine.
> However when we use a mount that a process in another user namespace
> we need to not assume the uids are the same.
> 
> Do you see the difference?

Aaah - so you don't want to store this on the fs.  So this is actually
like what I had mentioned many many emails ago?

> > much wider community on.  I.e. the cifs and nifs folks.  I haven't even
> > googled to see what they say about it.
> 
> Yes.
> 
> >> Yes.  Your patch does lay some interesting foundation work.
> >> But we must not merge it upstream until we have a complete patchset
> >> that handles all of the user namespace issues.
> >
> > Don't think Cedric expected this to be merged  :)  Just to start
> > discussion, which it certainly did...
> 
> If we could have [RFC] in front of these proof of concept patches
> it would clear up a lot of confusion.

Agreed.

> > If we're going to talk about keys (which I'd like to) I think we need to
> > decide whether we are just using them as an easy wider-than-uid
> > identifier, or if we actually need cryptographic keys to prevent
> > "identity theft"  (heheh).  I don't know that we need the latter for
> > anything, but of course if we're going to try for a more general
> > solution, then we do.
> 
> Actually I was thinking something as mundane as a mapping table.  This
> uid in this namespace equals that uid in that other namespace.

I see.

That's also what I was imagining earlier, but it seems crass somehow.
I'd almost prefer to just tag a mount with a user namespace implicitly,
and only allow the mounter to say 'do' or 'don't' allow this to be read
by users in another namespace.  Then in the 'don't' case, user joe
[1000] can't read files belonging to user jack [1000] in another
namespace.  It's stricter, but clean.

But whether we do mapping tables or simple isolation, I do still like
the idea of pursuing the use of the keystore for global uids.

thanks,
-serge
