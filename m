Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbTEVIhf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 04:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbTEVIhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 04:37:35 -0400
Received: from mrburns.nildram.co.uk ([195.112.4.54]:7684 "EHLO
	mrburns.nildram.co.uk") by vger.kernel.org with ESMTP
	id S262687AbTEVIhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 04:37:33 -0400
Date: Thu, 22 May 2003 09:50:36 +0100
From: Joe Thornber <thornber@sistina.com>
To: Linux Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>,
       Alexander Viro <viro@math.psu.edu>
Subject: Device-mapper filesystem interface
Message-ID: <20030522085036.GD441@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I thought I'd kick off a thread concerning the filesystem interface
for device-mapper after it came up on last nights 'must-fix' meeting.

To recap:

Alasdair Kergon and I spent a lot of time thinking last autumn about
how to best map the dm semantics onto an fs.  The end result was this
very rough and ready patchset:

http://people.sistina.com/~thornber/patches/2.5-unstable/2.5.51/2.5.51-dmfs-1.tar.bz2

The reception was not favourable.  People didn't like the way creating
a directory was analagous to creating a device, or the fact that these
device directories were pre-populated with table, status and
dependency files.  Gregkh was the only person who put forward
alternatives ideas (sysfs), and I don't think even he had thought
through how all of the dm functionality was going to be mapped.  eg,
with dmfs as it stands the 'wait for event' ioctl has translated into
a poll on the status file, ie wait until the status file changes - I
think this is neat.

I must admit I rather let the issue die; having played with these fs
ideas I do not see any particular advantage over the ioctl interface.
It will involve more code on the kernel side (which I will need help
with since I know v. little about the vfs), and more code on the
userland side.  I can't even argue that the fs interface makes it
easier for scripting languages to use dm, since the simple dmsetup
tool will always be far simpler to use than poking about in the fs.

I've always been careful to keep core dm seperate from the interface,
interfaces can be seperate modules, and multiple interfaces can be
present at the same time - they are just clients of the core dm code.
So let's treat dmfs as a seperate project.  I'm happy to work on it,
but I don't have the enthusiasm to drive it, especially after the luke
warm response to my initial attempts.

- Joe

