Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263491AbUBKBsi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 20:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263513AbUBKBsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 20:48:38 -0500
Received: from h24-82-88-106.vf.shawcable.net ([24.82.88.106]:43917 "HELO
	tinyvaio.nome.ca") by vger.kernel.org with SMTP id S263491AbUBKBsg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 20:48:36 -0500
Date: Tue, 10 Feb 2004 17:49:04 -0800
From: Mike Bell <kernel@mikebell.org>
To: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev, thoughts from a devfs user
Message-ID: <20040211014903.GC4915@tinyvaio.nome.ca>
References: <20040210113417.GD4421@tinyvaio.nome.ca> <20040210170157.GA27421@kroah.com> <20040210175548.GN4421@tinyvaio.nome.ca> <20040210181932.GI28111@kroah.com> <20040210184302.GP4421@tinyvaio.nome.ca> <20040210201119.GA1253@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210201119.GA1253@thunk.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 03:11:19PM -0500, Theodore Ts'o wrote:
> At least some races are inherent to the idea of having a filesystem
> which is mounted on /dev.  At some level, this seems to be your main
> complaint to the udev/sysfs combination --- that you cannot mount some
> particular magic filesystem on top of /dev.  But think about it.  If
> you are having the kernel specify a specific name, and then allow
> devfsd program to override it (but have it magically appear in /dev if
> devfsd is not running) it is very hard to avoid the races, and it
> certainly makes it hard to do anything other than the one sender, one
> receiver model.

OK, but I wasn't talking about overriding. In fact, I was taking it as
read that the devfs-type solution can't override (which it sort of
COULD, but as you say it has races) but would instead have its userspace
daemon create nodes _in addition to_ the kernel created ones, based on
user policy. Or symlinks, whatever the user space daemon wants.

> If instead you have a filesystem which fundamentally must be mounted
> somewhere else, such that there is no question that it can't be
> mounted on /dev, and you have a notifer which tells you what's going
> on --- well, you have the udev/sysfs combination.  

Agreed. 

> You could pontentially do this if you mount the devfs filesystem on
> /devfs, but as near as I can tell, that was just a stalking horse by
> the devfs folks who tried to be all things to all people.  If you're
> going to mount devfs on /devfs, then udev/sysfs does a better job,
> because that's what it's designed to do.

Yes, agreed. If anything, that was one of the points I was trying to
make, that udev/sysfs is similar in concept to devfsd with devfs mounted
somewhere other than /dev (please nobody tell me how sysfs and devfs are
different, I know. I meant for the purposes of the udev/devfs user space
programs, they're fulfiling the same purpose. Getting a major and minor
from the kernel to the userspace daemon by creating a file on a
kernel-generated filesystem.)

What I would like to see is a kernel generated /dev with
kernel-specified paths. A userspace daemon, whether you call it udev or
devfsd, would then manage alternate (in addition to, not instead of)
naming schemes according to the sysadmin's whim and permissions of
device nodes and other things that just don't make sense to do in kernel
space.
