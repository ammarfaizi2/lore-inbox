Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265828AbUF2RGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265828AbUF2RGb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 13:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265840AbUF2RGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 13:06:31 -0400
Received: from mail.aknet.ru ([217.67.122.194]:10510 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S265828AbUF2RG0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 13:06:26 -0400
Message-ID: <40E1A19C.6090607@aknet.ru>
Date: Tue, 29 Jun 2004 21:06:36 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Rohland <cr@sap.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch][rfc] expandable anonymous shared mappings
References: <Pine.LNX.4.44.0406282242320.14234-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0406282242320.14234-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugh.

Hugh Dickins wrote:
> But I've never heard that complained of before, 
> you're exaggerating to say we're deeply in a mess here.  I'd
What I wanted to say is only that shmem_file_setup()
does exactly the same thing - creates and truncates
the file itself. But this is no longer important
as I finally realized your points.

> Sorry, I was talking SysV shm there.
Excellent point btw! I verified that, mremap() on
the SysV shm gives me the same nice SIGBUS. I feel
much better right now:) I was wrong assuming that
expanding the shared mapping with mremap() should
be valid in any case, SysV shm is an obvious example,
and it resembles the anon-shm the way they both do
not have an FD accessible.
So yes, I finally realized that my proposal is
nothing more than an extension to the otherwise
functional interface, and should not be traded as
a bugfix. And yes, the inability to shrink it back
is also not friendly. As for not allowing children
to expand, I'd vote for MAP_DONTEXPAND flag, but
this already have nothing to do with my original
proposal, so no need to worry about it.
Thanks for you time and explanations, after all they
worked out right:)

>> http://www.ussg.iu.edu/hypermail/linux/kernel/9603.2/0692.html
> up past history to support your case.  But I'm afraid this does
> not actually add support to your case (certainly doesn't subtract
> from it either) - it's about using mremap to track extensions
> to a file extended by other means.
Well, what I meant pointing to this URL, was this:
---
In most 
cases (at least for the malloc case) this will be a anonymous mapping, 
but it's by no means an error to extend any mapping you have created.
---
Either I read it the completely wrong way, or it
is no longer valid, but in the light of the above,
it seems like indeed this doesn't add the support
to my case.

> Yes, it would make it simpler, but not significantly simpler.
You are right.

> You could ask instead for an mtruncate system call (similarly
Good idea, why not? :)

> [snip surprise at SIGBUS beyond end of shared object]
But you snipped the most important part:)
Now I understand, however, the problems I had with
mremap(), have nothing special to do with the anon-shm,
it just seems to be the usual thing with that syscall.
It is full of surprises, it will map a zero-page to you,
it will give you a SIGBUS, it will do everything
but not what you really want from it:) I always
wanted to have the more reliable mremap(). Not the
one that can expand everything in the world, but
the one that returns the value you can rely upon,
as all the other syscalls do. But the way I wanted
to achieve it (by implementing the "proper" nopage handler
for anon-shm) is definitely not the right one. That's
why I was very happy when you proposed the .mremap
handlers per vma, but since this have nothing to do
with the current subject, I should probably go
complaining about mremap() elsewhere.

Thank you and Christoph for the very usefull
discussion. It was usefull maybe again only
for me, but I hope you weren't bored with it too
much either.

Thanks!

