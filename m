Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267623AbUBTBHK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 20:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267650AbUBTAzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 19:55:04 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:51461 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S267642AbUBTAwm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 19:52:42 -0500
Date: Fri, 20 Feb 2004 01:52:37 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: James Simmons <jsimmons@infradead.org>
Cc: Greg KH <greg@kroah.com>, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: HOWTO use udev to manage /dev
Message-ID: <20040220005237.GA7079@pclin040.win.tue.nl>
References: <20040219194610.GB13934@kroah.com> <Pine.LNX.4.44.0402192020100.26894-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0402192020100.26894-100000@phoenix.infradead.org>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: Servercave: kweetal.tue.nl 1183; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19, 2004 at 08:21:25PM +0000, James Simmons wrote:

> Okay. If I change the major number of serial ttys inside the kernel 
> of course udev would properly handle this. Now the question is would this 
> break userland applications using the serial port?

Yes, a few of them.
Ordinarily, userland software uses pathnames in /dev.
But some software knows too much.

In dietlibc-0.20 one can read:

char *ttyname(int fd) {
...
  if (S_ISCHR(s.st_mode)) {
    n=minor(s.st_rdev);
    switch (major(s.st_rdev)) {
    case 4:
...
    case 2:
...
    case 136:
    case 137:
    case 138:
    case 139:
...
}

This code knows about the actual values of majors.
There are lots of examples like this.

For stable use of Linux one must preserve the 16-bit legacy area.

On the other hand, if the goal is to find and eradicate all such
ugly uses of explicit device numbers, Linus' idea to make it all
random will certainly help.
(But a big grep for st_rdev might be more efficient.)

Andries
