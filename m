Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314079AbSESBNC>; Sat, 18 May 2002 21:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314083AbSESBNC>; Sat, 18 May 2002 21:13:02 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:57870 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S314079AbSESBNB>; Sat, 18 May 2002 21:13:01 -0400
Date: Sat, 18 May 2002 18:12:57 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: suid bit on directories
Message-ID: <20020518181257.Y840@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020518103432.5a3b4c67.michael@hostsharing.net> <20020518105252.A3897@enst.fr> <20020518123435.6905c1e0.michael@hostsharing.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 18, 2002 at 12:34:35PM +0200, Michael Hoennig wrote:
> Hi Cedric,
> 
> > > I do not even see a security hole if nobody other than the user itself
> > > and httpd/web can reach this area in the file system, anyway. And it
> > > is still the users decision that files in this (his) directory should
> > > belong to him.
> > 
> > I guess it is considered a security hole if a user can create files not
> > belonging to him.
> 
> where is it so much different from the guid flat on directories?  That way
> too, you could get rights of a group of which you are not a member.  As

You don't get the rights of the group.  This only allows the
file/directory you could have created anyway to be created with the
gid of the parent.  And you still are the owner so it can be
seen who is responsible for it existing.

The only possible way non-members could do this would be if
the directory has dangerous^Wrisky permissions allowing non-group
members to write in it.

I use sgid directories frequently.  Usually with
user-private-groups and umask of 002. It keeps lusers from
misusing chmod.

> far as I can see, all what has to be prevented, is to create files with
> suid flag set within such a folder - not even for a microsecond

_Please_ don't describe it this way.  We don't want any
files any time to be created with suid flag set
automatically.  Describe it as "the suid flag set _on_ the
directory" or "suid directory", etc.

> (race-condition).  Or do I miss something?  Other issues are quota, but
> this problem already exists with guid bit for directories.  And in my case
> (mod_php), it is even worse the way it is.

Group quotas are used even less than user quotas so i don't
consider them much of an issue (someone else probably does).
What i do consider an issue is user accountability.  There
are reasons besides quota only root can chown.

You haven't articulated how doing this would be of benefit to
anyone.  Leaving that aside you could work up a patch to
allow this behaviour.

Features would be:

	1 a non-default mount option. 

	2 either incompatible with quota or throwing up
 	  warnings if quota is enabled.

	3 ineffective if the directory is also sticky.

Personally i don't care for the idea but, hey, you can try.
As long as it doesn't become a default it won't affect me.


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
