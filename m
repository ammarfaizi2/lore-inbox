Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265198AbSLMRQ1>; Fri, 13 Dec 2002 12:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265201AbSLMRQ1>; Fri, 13 Dec 2002 12:16:27 -0500
Received: from dhcp-66-212-193-131.myeastern.com ([66.212.193.131]:58831 "EHLO
	mail.and.org") by vger.kernel.org with ESMTP id <S265198AbSLMRQZ>;
	Fri, 13 Dec 2002 12:16:25 -0500
To: Andrew Walrond <andrew@walrond.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Symlink indirection
References: <Pine.LNX.3.95.1021213102838.2190B-100000@chaos.analogic.com>
	<m3bs3pao5m.fsf@code.and.org> <3DFA0C20.3020000@walrond.org>
From: James Antill <james@and.org>
Content-Type: text/plain; charset=US-ASCII
Date: 13 Dec 2002 12:24:15 -0500
In-Reply-To: <3DFA0C20.3020000@walrond.org>
Message-ID: <m33cp1al34.fsf@code.and.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Walrond <andrew@walrond.org> writes:

> Hi James.
> 
> Thanks for the info; my application is now entirely plausible :)
> And apologies for asking an FAQ. (Google didn't throw up anything useful)

 Sorry, this was an error on my part, I shouldn't reply to Richard's
posts until I've calmed down.

> BTW is documented anywhere except the code?

 Apart from this mailing list, not AFAIK.

> >  The link count is for recursively following symlinks, as the
> > original
> 
> > question wanted to know ... and has been discussed on lkml numerous
> > times.
> >  Andrew, one extra piece of information you might not know is that
> > the
> 
> > above value doesn't come into play when the new symlink is the last
> > element in the new path, then you get a higher value.
> >  The full code...
> >         if (current->link_count >= max_recursive_link)
> 
> >                 goto loop;
> >         if (current->total_link_count >= 40)
> >                 goto loop;
> > [...]
> >         current->link_count++;
> >         current->total_link_count++;
> >         UPDATE_ATIME(dentry->d_inode);
> >         err = dentry->d_inode->i_op->follow_link(dentry, nd);
> >         current->link_count--;
> > ...Ie. a link from /a -> /b/c where "b" is a symlink takes the
> 
> > "max_recursive_link" value (5 on vanilla kernels) but if "/b/c" was a
> > symlink then you get to use the 40 value.

 The last part of the path is still part of the follow_link, and thus
subject to the non-total link_count value. The only times you get the
bigger value is...

/a     -> /b/c
/b     -> /b.1     -> /b.2     -> /b.3     -> /b.4
/b.4/c -> /b.4/c.1 -> /b.4/c.2 -> /b.4/c.3 -> /b.4/c.4

...here you can open /a even if you'll follow more than ->link_count
links.

-- 
# James Antill -- james@and.org
:0:
* ^From: .*james@and\.org
/dev/null
