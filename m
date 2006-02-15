Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422994AbWBOHeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422994AbWBOHeF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 02:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422996AbWBOHeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 02:34:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45744 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422994AbWBOHeE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 02:34:04 -0500
Date: Tue, 14 Feb 2006 23:32:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: psusi@cfl.rr.com, jzb@aexorsyst.com, linux-kernel@vger.kernel.org
Subject: Re: root=/dev/sda1 fails but root=0x0801 works...
Message-Id: <20060214233256.2969b4b7.akpm@osdl.org>
In-Reply-To: <20060215071018.GJ27946@ftp.linux.org.uk>
References: <200602132316.15992.jzb@aexorsyst.com>
	<43F1FA74.80607@cfl.rr.com>
	<20060214162458.GD27946@ftp.linux.org.uk>
	<20060214225950.3a697ec8.akpm@osdl.org>
	<20060215071018.GJ27946@ftp.linux.org.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@ftp.linux.org.uk> wrote:
>
> On Tue, Feb 14, 2006 at 10:59:50PM -0800, Andrew Morton wrote:
> > Al Viro <viro@ftp.linux.org.uk> wrote:
> > >
> > > Read init/do_mounts.c::name_to_dev_t().
> > >
> > 
> > I tried to do that a while ago, when I was trying to use it for
> > name_to_dev_t()ing in swsusp somewhere.
> > 
> > 
> > >From my notes at the time:
> > 
> >   a) It barfs if /sys is already mounted.
> 
> It's called from late boot code.
>  
> >   b) Fix that, mkdir and mount barf because it needs set_fs(KERNEL_DS)
> 
> It's called from late boot code, running as kernel thread.

Well.  I was trying to use it for something else...


> >   c) Fix that, it barfs because name_to_dev_t is just broken.  It is
> >      accessing the wrong pathnames in /sys.
> 
> Details, please.

I just don't remember, sorry.  From inspection it _looks_ OK.  But I do
remember getting -ENOENT, looking at the pathnames and deciding that it was
miles off.

swsusp has a habit of leaving a trailing \n at the end of resume_file, but
it was more than that.

And I threw away the patch which exercised this.  Oh well.

(Wonders whether software_resume()'s call to name_to_dev_t() can work and
if so, whether all that stuff as well as name_to_dev_t() can become __init).

