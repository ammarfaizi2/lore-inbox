Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbUBTTlD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 14:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbUBTTlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 14:41:02 -0500
Received: from buserror-extern.convergence.de ([212.84.236.66]:45956 "EHLO
	heck") by vger.kernel.org with ESMTP id S261374AbUBTTPA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 14:15:00 -0500
Date: Fri, 20 Feb 2004 20:14:41 +0100
From: Johannes Stezenbach <js@convergence.de>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: James Simmons <jsimmons@infradead.org>, Greg KH <greg@kroah.com>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: HOWTO use udev to manage /dev
Message-ID: <20040220191441.GA17178@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Andries Brouwer <aebr@win.tue.nl>,
	James Simmons <jsimmons@infradead.org>, Greg KH <greg@kroah.com>,
	linux-hotplug-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20040219194610.GB13934@kroah.com> <Pine.LNX.4.44.0402192020100.26894-100000@phoenix.infradead.org> <20040220005237.GA7079@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040220005237.GA7079@pclin040.win.tue.nl>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 20, 2004 at 01:52:37AM +0100, Andries Brouwer wrote:
> On Thu, Feb 19, 2004 at 08:21:25PM +0000, James Simmons wrote:
> 
> > Okay. If I change the major number of serial ttys inside the kernel 
> > of course udev would properly handle this. Now the question is would this 
> > break userland applications using the serial port?
> 
> Yes, a few of them.
> Ordinarily, userland software uses pathnames in /dev.
> But some software knows too much.
> 
> In dietlibc-0.20 one can read:
> 
> char *ttyname(int fd) {
> ...
>   if (S_ISCHR(s.st_mode)) {
>     n=minor(s.st_rdev);
>     switch (major(s.st_rdev)) {
>     case 4:
> ...
>     case 2:
> ...
>     case 136:
>     case 137:
>     case 138:
>     case 139:
> ...
> }
> 
> This code knows about the actual values of majors.
> There are lots of examples like this.

dietlibc actually uses readlink from /proc/sef/fd/. The code
you quote is used only if one #undef SLASH_PROC_OK in dietfeatures.h.
Few people will use this, and those that do probably have a
good reason.

Johannes
