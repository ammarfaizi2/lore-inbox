Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266262AbUBJSoK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 13:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266256AbUBJSmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 13:42:49 -0500
Received: from h24-82-88-106.vf.shawcable.net ([24.82.88.106]:397 "HELO
	tinyvaio.nome.ca") by vger.kernel.org with SMTP id S266175AbUBJSmf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 13:42:35 -0500
Date: Tue, 10 Feb 2004 10:43:03 -0800
From: Mike Bell <kernel@mikebell.org>
To: linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev, thoughts from a devfs user
Message-ID: <20040210184302.GP4421@tinyvaio.nome.ca>
References: <20040210113417.GD4421@tinyvaio.nome.ca> <20040210170157.GA27421@kroah.com> <20040210175548.GN4421@tinyvaio.nome.ca> <20040210181932.GI28111@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210181932.GI28111@kroah.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 10:19:32AM -0800, Greg KH wrote:
> But devfs never used the dynamic major/minor code.  No one used it.
> It's not even present anymore in 2.6.  That shows that devfs does not
> solve this problem by itself.

Does udev solve this problem by itself? :) No, it is just agnostic to
the change being made in the kernel. Pretty much the same way devfsd
would be.

> Heh, you haven't ever converted a driver to use devfs have you?  If so,
> you would have seen the fact that you had to specify your devfs name in
> the driver interface.  That's hard coding the naming scheme in the
> kernel.

It's hard coding _a_ name in the kernel. And what's bad about having a 
constant name for the device, if the user can have their own alternate
names? If you ask me, that's many times BETTER than having every
system use totally different names for every device with no way to
predictably find a device by name. At least with devfs I know that
/dev/input/mice will be named /dev/input/mice. This "no policy in kernel
space" you claim as a benefit really amounts to "/dev/input/mice could
be named anything at all". The default config may have a predictable LSB
type name, but what you're talking about isn't the flexibility to have
it named anything you want, but the flexibility NOT to have an
alternate, predictable name as well. Why is that a good thing?

> And how flexible does devfsd allow you to specify your own naming
> scheme?  How can you get the info from devfsd that you need to provide a
> proper device name?  No one I know has ever does this.  And I know some
> people who tried real hard...

That's a valid point against the existing devfs/devfsd, there are a few
of those (the races, for instance). But it's not inherent to the idea of
a devfs.

> udev defaults to this.  Which is the sane thing to do.

I don't know about that. from what I remember of the original devfs
discussion, it was along the lines of "LSB involves every device in
/dev, and is dumb.  We need a new scheme, this is as good as any. Anyone
who has a better idea for how devices should be laid out, let me know."
