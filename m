Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262746AbTKYPYt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 10:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262740AbTKYPYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 10:24:49 -0500
Received: from hosting-agency.de ([195.69.240.23]:62890 "EHLO mailagency.de")
	by vger.kernel.org with ESMTP id S262746AbTKYPYq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 10:24:46 -0500
From: Jakob Lell <jlell@JakobLell.de>
To: Jan Kara <jack@suse.cz>, Jamie Lokier <jamie@shareable.org>
Subject: Re: hard links create local DoS vulnerability and security problems
Date: Tue, 25 Nov 2003 16:27:04 +0100
User-Agent: KMail/1.5.4
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       linux-kernel@vger.kernel.org
References: <200311241736.23824.jlell@JakobLell.de> <20031124173527.GA1561@mail.shareable.org> <20031125144847.GA6748@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20031125144847.GA6748@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311251627.04335.jlell@JakobLell.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 November 2003 15:48, Jan Kara wrote:
> > Richard B. Johnson wrote:
> > > To prevent this, a user can set his default permissions so that
> > > neither group nor world can read the files. This is usually done
> > > by setting the attributes in the user's top directory.
> >
> > Correct, but the quota problem is genuine: what if I want to create a
> > lot of files in /home/jamie that are readable by other users, but I
> > want to be able to delete them at some later time and reuse my quota
> > for something else?
> >
> > This is quite a normal scenario on multi-user systems with quotas.
> >
> > You seem to be suggesting that the only method is to have a separate
> > partition for each user, which is absurd.
>
>   I agree that malicious user can make some user run out of quotas
> (actually he can do it even by more secret way by just opening the files
> - but for this at least read permission is needed). But I guess that
> reasonably capable admin discovers the problem and /bin/nologin as a
> login shell solves the problem...
Hello,
if it's a web server with thousands of users (and maybe millions of files 
in  /home), searching /home for files belonging to one user can take quite 
long (maybe hours). 
If the evil users can't create hard links and thus has to keep the file open 
instead of creating a hard link, the problem can quickly be found using lsof.
>
> > Another method is "tree quotas" which have come up on this list
> > before.  Hopefully they will be included one day; tree quotas seem
> > like they would solve this problem and some others.
>
>   Yes they would but denying hardlinks across 'quota trees' seems to be
> the easiest way of making them technically possible and so you end up in
> a similar situation as with some security patches...

This would also be a good way to fix the problem.
>
> 								Honza

Regards
  Jakob

