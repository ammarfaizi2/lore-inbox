Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274928AbTGaXRx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 19:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274919AbTGaXPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 19:15:31 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:5895 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S274915AbTGaXPF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 19:15:05 -0400
Date: Thu, 31 Jul 2003 16:15:01 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: fun or real: proc interface for module handling?
Message-ID: <20030731231501.GC23607@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <20030731121248.GQ264@schottelius.org> <yw1xptjqub7q.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xptjqub7q.fsf@users.sourceforge.net>
User-Agent: Mutt/1.3.27i
X-Message-Flag: Unauthorised duplication and storage of this email is a violation of international copyright law and is subject to prosecution.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 31, 2003 at 02:34:01PM +0200, Måns Rullgård wrote:
> Nico Schottelius <nico-kernel@schottelius.org> writes:
> 
> > I was just joking around here, but what do you think about this idea:
> >
> > A proc interface for module handling:
> >    /proc/mods/
> >    /proc/mods/<module-name>/<link-to-the-modules-use-us>
> >
> > So we could try to load a module with
> >    mkdir /proc/mods/ipv6
> > and remove it and every module which uses us with
> >    rm -r /proc/mods/ipv6
> 
> So far, so good.
> 
> > Modul options could be passed my
> >    echo "psmouse_noext=1" > /proc/mods/psmouse/options
> > which would also make it possible to change module options while running..
> 
> How would options be passed when loading?  Some modules require that
> to load properly.  Also, there are lots of options that can't be
> changed after loading.  To enable this, I believe the whole option
> handling would need to be modified substantially.  Instead of just
> storing the values in static variables, there would have to be some
> means of telling the module that its options changed.  Then there's
> the task of hacking all modules to support this...

How about
	ln -s noext=1,speed=6 /proc/module/psmouse
to create it with options required on load.

Symlink is the only node creator that allows arbitrary
content.

Otherwise, to be consistent with one value/file, it seem
that instead of an options file you write to each option
should have its own file.  Options that can only be set
during load would be readonly files.

Drifting slightly off-topic for this.  Wouldn't it be less
costly to have the configuration options be extended
attributes of a file or directory instead of separate files
in a directory?  I've been wondering this for some time.
I wouldn't want dynamic values, such as counters, to be
extended attributes but values that never change could be.
Extended attributes provide a nice NAME=VALUE implicitly in
a consistent way without having to have all those inodes.

DISCLAIMER:
	i don't use modules myself so the options in my
	examples are unlikely to be valid.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
