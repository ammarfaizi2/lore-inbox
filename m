Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262173AbVAYWKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262173AbVAYWKK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 17:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262172AbVAYWHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 17:07:11 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:2462 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262173AbVAYWDI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 17:03:08 -0500
Subject: Re: [RFC] shared subtrees
From: Ram <linuxram@us.ibm.com>
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <41F6BE58.50208@sun.com>
References: <20050113221851.GI26051@parcelfarce.linux.theplanet.co.uk>
	 <20050116160213.GB13624@fieldses.org>
	 <20050116180656.GQ26051@parcelfarce.linux.theplanet.co.uk>
	 <20050116184209.GD13624@fieldses.org>
	 <20050117061150.GS26051@parcelfarce.linux.theplanet.co.uk>
	 <20050117173213.GC24830@fieldses.org> <1106687232.3298.37.camel@localhost>
	 <41F6BE58.50208@sun.com>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1106690563.3298.43.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 25 Jan 2005 14:02:43 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-25 at 13:47, Mike Waychison wrote:
 ...snip...
> > 
> > Question 2:
> > 
> > When a mount gets propogated to a slave, but the slave
> > has mounted something else at the same place, and hence 
> > that mount point is masked, what will happen?
> > 
> >         Concrete example:
> > 
> >         mount <device1> /tmp/mnt1
> >         mkdir -p /tmp/mnt1/a/b
> >         mount --rbind /tmp/mnt1 /tmp/mnt2
> >         mount --make-slave /tmp/mnt2
> 
> EINVAL.  You should only be able to demote a mountpoint to a slave if it
> was part of a p-node (shared).

oops. I had the following in mind.

	mount <device1> /tmp/mnt1
      **  mount --make-shared /tmp/mnt1  **
        mkdir -p /tmp/mnt1/a/b
        mount --rbind /tmp/mnt1 /tmp/mnt2
        mount --make-slave /tmp/mnt2

In this case it cannot be EINVAL, because /tmp/mnt1 and /tmp/mnt2 will
both be part of a pnode and hence /tmp/mnt2 can be demoted to be a
slave. 
> 
> >         mount <device2> /tmp/mnt2/a
> >         rm -f /tmp/mnt2/a/*
> > 
> >         what happens when a mount is attempted on /tmp/mnt1/a/b?
> >         will that be reflected in /tmp/mnt2/a ?
> > 
> >         I believe the answer is 'no', because that part of the subtree 
> >         in /tmp/mnt2 no more mirrors its parent subtree.
> > 
> > RP 
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> - --
> Mike Waychison
> Sun Microsystems, Inc.
> 1 (650) 352-5299 voice
> 1 (416) 202-8336 voice
> 
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> NOTICE:  The opinions expressed in this email are held by me,
> and may not represent the views of Sun Microsystems, Inc.
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.5 (GNU/Linux)
> Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org
> 
> iD8DBQFB9r5YdQs4kOxk3/MRApT3AJ9xxpdacU0mp8IvsY395MDtEktJ+wCeOvRT
> /g7qXO9nGxMT/iFAZoUO8F4=
> =9D2G
> -----END PGP SIGNATURE-----
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

