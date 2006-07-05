Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964954AbWGEVli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964954AbWGEVli (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 17:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbWGEVli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 17:41:38 -0400
Received: from mail.fieldses.org ([66.93.2.214]:34185 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S964954AbWGEVli
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 17:41:38 -0400
Date: Wed, 5 Jul 2006 17:41:33 -0400
To: Bill Davidsen <davidsen@tmr.com>
Cc: Theodore Tso <tytso@mit.edu>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features
Message-ID: <20060705214133.GA28487@fieldses.org>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de> <20060704010240.GD6317@thunk.org> <44ABAF7D.8010200@tmr.com> <20060705125956.GA529@fieldses.org> <44AC2B56.8010703@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44AC2B56.8010703@tmr.com>
User-Agent: Mutt/1.5.11+cvs20060403
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2006 at 05:12:54PM -0400, Bill Davidsen wrote:
> J. Bruce Fields wrote:
> >Or we could add an entirely separate attribute that's guaranteed to
> >increase whenever the ctime is updated, and that doesn't necessarily
> >have any connection with time--call it a version number or something.
> >
> There are versions in both VMS and the ISO filesystem. I have a sneaking 
> suspicion that those of us who ever use them are few and far between. 
> The other issue is that unless the field is time, programs like make 
> can't really use it, at least without becoming Linux specific.

Sure.

> I'm not sure exactly how a "version" value would be used other than 
> detecting the fact that the file had been changed in some way.

I agree.  But "detecting the fact that the file has been changed" is a
really important use!  I think the challenge would be to come up with
applications that really depend on timestamps and that use them for
anything *other* than detecting when a file has changed.

(OK, so make is a special case--it cares not only about whether a file
has changed, but also about whether it has changed more recently than
some other file.  But I'd think a simple version would useful to any
network filesystem, or more generally to anything that caches a view of
the filesystem either on another machine or in userspace.)

> Feel free to show me, I seem to come up empty on using this value.

Betraying my own interests--the NFSv4 protocol (unlike v2 or v3) uses a
specialized "change" attribute to maintain cache consistency instead of
depending on mtime/ctime.  So nfsd would be one immediate in-kernel
user.  Currently we're using ctime, which causes obvious problems.

But an improved ctime--one that actually increased whenever the file
changed--would also do the job.

--b.
