Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbUJLNFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUJLNFf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 09:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUJLNFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 09:05:35 -0400
Received: from open.hands.com ([195.224.53.39]:58841 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S261234AbUJLNFW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 09:05:22 -0400
Date: Tue, 12 Oct 2004 14:16:22 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: jonathan@jonmasters.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: how do you call userspace syscalls (e.g. sys_rename) from inside kernel
Message-ID: <20041012131622.GX22010@lkcl.net>
References: <20041008130442.GE5551@lkcl.net> <35fb2e5904101117156b033f6b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35fb2e5904101117156b033f6b@mail.gmail.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hiya jon,

i'm placing _a_ version at http://hands.com/~lkcl/fuse.xattr.2.tgz.

it's the "mostly userspace" version, with hacked-up xattrs that "track"
what the userspace code does, inside the kernel.

due to having to implement fuse "getxattr" and friends in
kernel-space (in order to avoid having the -512 error message
returned to selinux/hooks.c), there are two locations in the
code where you must specify the proxy point:

1) example/fusexmp.c you must change "/home/sez" to your-directory.

2) kernel/util.c likewise.

in 1) it is the location where userspace file access occurs.  2) is
obviously matching the userspace xattr access.

i _do_ have a version of fuse where
pretty-much-everything-but-the-inode-allocation-which-is-done-in-libfuse-has-been-moved-to-kernel.

i've been examining a number of kernel modules (ncpfs primarily)
in an attempt to understand how to move libfuse's userspace
inode allocation system into kernelspace.

i'm tempted to abandon fuse and use lufs instead... that has a directory
cache in userspace but at least it appears to allocate inodes in
kernel (using iunique()).

hmmm...


On Tue, Oct 12, 2004 at 01:15:34AM +0100, Jon Masters wrote:
> On Fri, 8 Oct 2004 14:04:42 +0100, Luke Kenneth Casson Leighton
> <lkcl@lkcl.net> wrote:
> > could someone kindly advise me on the location of some example code in
> > the kernel which calls one of the userspace system calls from inside the
> > kernel?
> 
> Hi Luke,
> 
> I enjoyed your recent talk at OxLUG in which you mentioned this
> briefly. Could you please send me the source that you are working on
> so that I can take a look and make suggestions if tha'ts useful - I
> posted to the OxLUG list but you're not actually on it and although I
> now have your address from someone, this post reminded me.
> 
> I've copied lkml for two reasons - a). Someone else might want to take
> a look. b). I sat and talked with Luke for a while about this, he's
> not a typical "I want to do stuff in the kernel I should be doing from
> userspace" kind of person in my opinion (there might still be a better
> way but until I see more what he's actually doing then I can't work
> out what).
> 
> Jon.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />

