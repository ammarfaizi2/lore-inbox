Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264500AbUIVLLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbUIVLLR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 07:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264571AbUIVLLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 07:11:16 -0400
Received: from open.hands.com ([195.224.53.39]:38810 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S264500AbUIVLK4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 07:10:56 -0400
Date: Wed, 22 Sep 2004 12:21:59 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FUSE fusexmp proxy example solves umount problem!
Message-ID: <20040922112159.GD20688@lkcl.net>
References: <20040922004941.GC14303@lkcl.net> <1095845610.2613.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095845610.2613.4.camel@laptop.fenrus.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2004 at 11:33:30AM +0200, Arjan van de Ven wrote:
> On Wed, 2004-09-22 at 02:49, Luke Kenneth Casson Leighton wrote:
> > what do people think about a filesystem proxy kernel module?
> > has anyone heard of such a beast already?
> > (which can also do xattrs)
> > 
> > fusexmp.c (in file system in userspace package) does stateless
> > filesystem proxy redirection.
> > 
> > this is a PERFECT solution to the problem of users removing media
> > from drives without warning. 
> 
> eh and the 2.6 kernel doesn't deal with it? It really is supposed to
> deal with it nicely already...

okay.

the reason that fusexmp works is because it doesn't actually touch the
filesystem except on an operation: there's no state information stored,
no file handles kept open, no directory handles kept open.

an implementation of this same functionality (a filesystem proxy)
in the linux kernel would involve:

- creating proxy inodes

- reconstructing the full path name

  d_path(dentry, mnt, full_path, sizeof(full_path));

  then prefixing that with the mount point and then issuing a
  proxy command.


now, if the solution to this problem in the linux kernel is broken
because someone forgot to deal with opendir() then _great_.

in the meantime...

l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />

