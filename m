Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291456AbSBAAah>; Thu, 31 Jan 2002 19:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291454AbSBAAa2>; Thu, 31 Jan 2002 19:30:28 -0500
Received: from zok.sgi.com ([204.94.215.101]:12231 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S291453AbSBAAaL>;
	Thu, 31 Jan 2002 19:30:11 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Larry McVoy <lm@bitmover.com>
Cc: Troy Benjegerdes <hozer@drgw.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin 
In-Reply-To: Your message of "Thu, 31 Jan 2002 09:19:14 -0800."
             <20020131091914.L1519@work.bitmover.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 01 Feb 2002 11:29:58 +1100
Message-ID: <21196.1012523398@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cc list trimmed.

On Thu, 31 Jan 2002 09:19:14 -0800, 
Larry McVoy <lm@bitmover.com> wrote:
>On Thu, Jan 31, 2002 at 11:13:37AM -0600, Troy Benjegerdes wrote:
>> Can you detect the 'collapsed vs full version' thing, and force it to be 
>> a merge conflict? That, and working LOD support would probably get most 
>> of what I want (until I try the new version and find more stuff I want 
>> :P)
>
>Are you sure you want that?  If so, that would work today, it's about a
>20 line script.  You clone the tree, collapse all the stuff into a new
>changeset, and pull.  It will all automerge.  But now you have the detailed
>stuff and the non-detailed stuff in the same tree, which I doubt is what
>you want.  I thought the point was to remove information, not double it.

That sounds almost like what I was looking for, with two differences.

(1) Implement the collapsed set so bk records that it is equivalent to
    the individual patchsets.  Only record that information in my tree.
    I need the detailed history of what changes went into the collapsed
    set, nobody else does.

(2) Somebody else creates a change against the collapsed set and I pull
    that change.  bk notices that the change is again a collapsed set
    for which I have local detail.  The external change becomes a
    branch off the last detailed patch in the collapsed set.

Example.

I have individual changes c1-c17 which are not externally visible.

Tell bk to generate collapsed patch A from c1-c17.  A is externally
visible, without the detailed internal change history of c1-c17.  This
is the equivalent of exporting a patch but it is recorded in bk.

I continue development with c18 onwards, based off c17.

Somebody makes change B against A.  B is externally visible.

I pull B.  bk recognises that B is against A for which local data
exists and therefore B is not really against A but is against c17.
bk creates B as a branch against c17, in parallel with c18.

Outside world sees A->B.  I see A[c1-c17], c17->c18 ..., c17->B (two
branches).

That processing model hides all the backtracking and partial checkins
from the outside world, which only sees the final patchset A, no
information overload.  It allows me to continue with internal
development with all the information that I need.  And it allows me to
automatically take back changes, identify that the changes are in
parallel to my internal changes and merge while keeping local details.

