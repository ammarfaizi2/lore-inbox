Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbVCHDiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVCHDiZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 22:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbVCGUWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 15:22:00 -0500
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:2440 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261761AbVCGTnO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 14:43:14 -0500
From: Blaisorblade <blaisorblade@yahoo.it>
To: jerome lacoste <jerome.lacoste@gmail.com>,
       David Howells <dhowells@redhat.com>
Subject: Re: [patch 1/1] fix syscallN() macro errno value checking for i386
Date: Sat, 5 Mar 2005 18:59:07 +0100
User-Agent: KMail/1.7.2
Cc: Arnd Bergmann <arnd@arndb.de>, akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20050129010145.1C42F8C9E4@zion> <200501301800.22706.arnd@arndb.de> <5a2cf1f605013010305f8270de@mail.gmail.com>
In-Reply-To: <5a2cf1f605013010305f8270de@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200503051859.08103.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 January 2005 19:30, jerome lacoste wrote:
> On Sun, 30 Jan 2005 18:00:22 +0100, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Sünnavend 29 Januar 2005 02:01, blaisorblade@yahoo.it wrote:
> > > From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> > > Cc: David Howells <dhowells@redhat.com>
> > >
> > > The errno values which are visible for userspace are actually in the
> > > range -1 - -129, not until -128 (): this value was added:
> > >
> > > #define       EKEYREJECTED    129     /* Key was rejected by service */
> > >
> > > And this would break ucLibc (for what I heard).
> > >
> > > This is just a quick-fix, because putting a macro inside errno.h
> > > instead of having it copied in two places would be probably nicer.
> >
> > Yes. Note that your patch only fixes the bug on i386. The code has been
> > copied to many other architectures, and some of them have been updated
> > less recently and are checking for values lower than 128. There should
> > really be a way to keep them all in sync.
>
> what about something along?
>
> #define EKEYNEXT    130     /* key counter */
>
> and
>
>  if ((unsigned long)(res) >= (unsigned long)(-EKEYNEXT)) {
Yes, I agree with you... I didn't do it that way because of this mail:

"Subject: Re: Fw: Re: [patch 02/11] uml: fix compilation for missing headers
From: David Howells <dhowells@redhat.com>
To: Andrew Morton <akpm@osdl.org>
CC: blaisorblade_spam@yahoo.it
Date: Fri Jan 14 12:19:33 2005
[....]
> I think that the max errno value should become a macro defined in errno.h.

I agree with him on this, but I seem to remember that this didn't go down very
well.

David"

Now, I don't know why it was not done that way, but I wanted to do a quick-fix 
to merge it. Somebody please fix it definitively... in 2.6.11 official this 
is still unfixed.

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


