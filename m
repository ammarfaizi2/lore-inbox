Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292126AbSBAW54>; Fri, 1 Feb 2002 17:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292127AbSBAW5r>; Fri, 1 Feb 2002 17:57:47 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:20998 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S292126AbSBAW5f>;
	Fri, 1 Feb 2002 17:57:35 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Larry McVoy <lm@bitmover.com>
Cc: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin 
In-Reply-To: Your message of "Fri, 01 Feb 2002 08:43:27 -0800."
             <20020201084327.D8664@work.bitmover.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 02 Feb 2002 09:57:22 +1100
Message-ID: <15713.1012604242@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Feb 2002 08:43:27 -0800, 
Larry McVoy <lm@bitmover.com> wrote:
>I do agree that there are times when you really want to collapse a pile
>of changes into one and I'm willing to write that code if it becomes
>agreed that it is widely useful.  It's maintaining both versions of 
>the changes, the collapsed and uncollapsed, that I don't want to do.

Hand waving solutions without seeing the bk code ...

Don't maintain both versions of the changes.

Everybody except the person with the uncollapsed set only sees the
collapsed set, no problem there.

The person with the uncollapsed set only has one version of the
changes, in the uncollapsed set.

Identify each externally visible patchset with a unique id, you
probably already do this.

Define a meta patchset entry which maps the uncollapsed line of patches
to the collapsed set.  That is, don't duplicate the changes, add a
mapping instead.

The meta entry maps the externally visible patchset to the internal set
by listing just the start and end point of the LOD.  These are the
entries that would be given to export patch.

Add a global repository option, show/hide detail.  The default is show
detail, the current behaviour.

For show detail, you cannot use meta patchset entries.  Everything is
visible to the rest of the world.

For hide detail, you must define meta entries for what you want to be
visible, the rest of the world can only see what you expose.  That is,
you cannot publish some detail entries and some meta entries, you must
choose one or the other at the repository level.

Meta sets are single level, no collapse within collapse.  A meta set is
externally visible, to collapse a meta set into a meta-meta set is
equivalent to rewriting the distributed bk history, don't allow that.

No duplication of changes.  No rewriting of bk history.  Users who want
to hide their detail changes and only expose the result can do so.
Users who only check in working (as opposed to hacking) code are not
affected.  Users who want the extra flexibility incur the cost of
defining meta sets before they can publish anything.

