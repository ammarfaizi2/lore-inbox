Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbTKVKom (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 05:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262152AbTKVKom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 05:44:42 -0500
Received: from moutng.kundenserver.de ([212.227.126.184]:8902 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262139AbTKVKol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 05:44:41 -0500
From: Juergen Hasch <lkml@elbonia.de>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: Using get_cwd inside a module.
Date: Sat, 22 Nov 2003 11:45:39 +0100
User-Agent: KMail/1.5.4
Cc: Michael Welles <mike@bangstate.com>, linux-kernel@vger.kernel.org
References: <3FBEA83B.1060001@bangstate.com> <200311221033.35108.lkml@elbonia.de> <20031122101559.A30932@infradead.org>
In-Reply-To: <20031122101559.A30932@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311221145.39585.lkml@elbonia.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:464ad01b81b0f762cd239ce6f3ab8323
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 22. November 2003 11:15 schrieb Christoph Hellwig:
> On Sat, Nov 22, 2003 at 10:33:34AM +0100, Juergen Hasch wrote:
> > Am Samstag, 22. November 2003 09:30 schrieb Christoph Hellwig:
> > > The basic problem is that you shouldn't call syscalls from kernelspace.
> > > Have you looked at dnotify to look for changed files instead?
> >
> > Dnotify doesn't return the file names that changed, changedfiles does.
> > I've looked into this, because Samba would benefit from such a
> > functionality.
> >
> > So maybe it would be possible to teach dnotify to return file names
> > (e.g. using netlink) ?
>
> Well, you can't return filenames.  There's no unique path to a give
> file.
>
> What are the exact requirements of changedfiles or samba?

Samba needs to be able to notify a client machine, when a file in a 
directory changes (i.e. is added/removed/modified/renamed). The directory 
to be watched is given by the client and can include subdirectories.

Right now Samba on Linux uses dnotify to watch the given directory
and just returns an error (too many files changed). The client has
to find out for itself which files changed.
This breaks certain user applications (e.g. IIS), because they rely
on getting the file names back from Samba.
I have a patch which makes a copy of all directory information on 
each dnotify event and looks for the changed files. This works but
obviously doesn't scale too well for many files in a directory.

...Juergen

