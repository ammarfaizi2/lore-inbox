Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbVGTRyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVGTRyW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 13:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVGTRyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 13:54:22 -0400
Received: from orb.pobox.com ([207.8.226.5]:35814 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261413AbVGTRyU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 13:54:20 -0400
Date: Wed, 20 Jul 2005 12:54:09 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: "Moore, Eric Dean" <Eric.Moore@lsil.com>, Olaf Hering <olh@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH 22/82] remove linux/version.h from drivers/message/fus ion
Message-ID: <20050720175409.GB1573@otto>
References: <91888D455306F94EBD4D168954A9457C03281EB4@nacos172.co.lsil.com> <20050720031249.GA18042@humbolt.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050720031249.GA18042@humbolt.us.dell.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Domsch wrote:
> On Tue, Jul 19, 2005 at 06:07:41PM -0600, Moore, Eric Dean wrote:
> > On Tuesday, July 12, 2005 8:17 PM, Matt Domsch wrote:
> > > In general, this construct:
> > > 
> > > > > -#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,6))
> > > > > -static int inline scsi_device_online(struct scsi_device *sdev)
> > > > > -{
> > > > > -	return sdev->online;
> > > > > -}
> > > > > -#endif
> > > 
> > > is better tested as:
> > > 
> > > #ifndef scsi_device_inline
> > > static int inline scsi_device_online(struct scsi_device *sdev)
> > > {
> > >     return sdev->online;
> > > }
> > > #endif
> > > 
> > > when you can.  It cleanly eliminates the version test, and tests for
> > > exactly what you're looking for - is this function defined.
> > > 
> > 
> > What you illustrated above is not going to work.
> > If your doing #ifndef around a function, such as scsi_device_online, it's
> > not going to compile
> > when scsi_device_online is already implemented in the kernel tree.
> > The routine scsi_device_online is a function, not a define.  For a define
> > this would work.
> 
> Sure it does, function names are defined symbols.
> 

$ cat foo.c
static int foo(void) { return 0; }
#ifndef foo
static int foo(void) { return 0; }
#endif

$ gcc -c foo.c
foo.c:3: error: redefinition of 'foo'
foo.c:1: error: previous definition of 'foo' was here

I believe #ifdef/#ifndef can test only preprocessor symbols.

Nathan
