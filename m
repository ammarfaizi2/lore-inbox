Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030340AbVKPOAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030340AbVKPOAw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 09:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030339AbVKPOAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 09:00:52 -0500
Received: from opus.cs.columbia.edu ([128.59.20.100]:3551 "EHLO
	opus.cs.columbia.edu") by vger.kernel.org with ESMTP
	id S1030336AbVKPOAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 09:00:51 -0500
Subject: Re: [PATCH 12/18] shared mount handling: bind and rbind
From: Shaya Potter <spotter@cs.columbia.edu>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: a1426z@gawab.com, torvalds@osdl.org, linuxram@us.ibm.com,
       viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, rob@landley.net
In-Reply-To: <E1EcIVw-0005ZH-00@dorka.pomaz.szeredi.hu>
References: <E1EZInj-0001Ez-AV@ZenIV.linux.org.uk>
	 <200511152129.04079.rob@landley.net>
	 <Pine.LNX.4.64.0511151948570.13959@g5.osdl.org>
	 <200511160835.28636.a1426z@gawab.com>
	 <E1EcIVw-0005ZH-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 08:59:36 -0500
Message-Id: <1132149576.8155.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.1 
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.0.3.2, Antispam-Data: 2005.11.16.9
X-PerlMx-Spam: Gauge=XXII, Probability=22%, Report='RELAY_IN_NJABL_DYNABLOCK 2.5, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __RELAY_IN_NJABL_DYNABLOCK 0, __SANE_MSGID 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-16 at 09:19 +0100, Miklos Szeredi wrote:
> > > This is why we have "pivot_root()" and "chroot()", which can both be used
> > > to do what you want to do. You mount the new root somewhere else, and then
> > > you chroot (or pivot-root) to it. And THEN you do 'chdir("/")' to move the
> > > cwd into the new root too (and only at that point have you "lost" the old
> > > root - although you can actually get it back if you have some file
> > > descriptor open to it).
> > 
> > Wouldn't this constitute a security flaw?
> > 
> > Shouldn't chroot jail you?
> 
> No, chroot should just change the root.
> 
> If you don't want to be able to get back the old root, just close all
> file descriptors _in addition_ to chroot() and chdir().

hah.  As long as you're running as root, chroot() again to a directory
below you, and you effectively broken the chroot and can make a relative
path to the old root. :)

I created a patch years ago that creates a chain of "chroot" points, and
any past chroot point would be considered a place that follow_dotdot
would consider a root.  There didn't seem much interest in the patch
though.

