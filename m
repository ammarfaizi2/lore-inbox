Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266785AbUBRACN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 19:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266809AbUBRACN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 19:02:13 -0500
Received: from stewie.egr.unlv.edu ([131.216.22.9]:15521 "EHLO
	mail.egr.unlv.edu") by vger.kernel.org with ESMTP id S266785AbUBRACG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 19:02:06 -0500
Subject: Re: fh_verify: no root_squashed access hundreds of times a second
	again
From: Andrew Gray <grayaw@Egr.UNLV.EDU>
To: linux-kernel@vger.kernel.org
Organization: University of Nevada Las Vegas
Message-Id: <1077062525.3090.14.camel@blargh.egr.unlv.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.5.3 (1.5.3-1) 
Date: Tue, 17 Feb 2004 16:02:05 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Solution found.  At least to my particular situation.

We have a bunch of SunBlades.  As part of their login in, the dtlogin
program tries to access <homedir>/.dt/sessions/lastsession.  It is
operating as root at this point, i.e. unauthenticated as the user.

For some reason, when it makes this request, if the user's home
directory doesn't allow access, the NFS server returns that it's a NFS
Stale Handle.  For some other odd reason, when dtlogin gets this, it
just immediately retries.  This leads to the hundreds of times per
second worth of accesses we were seeing. 

Combine this with having about a dozen machines all doing it at the same
time yields the problem we were seeing.

The solution in our case was to allow world-execute permissions on the
user home directories so dt could get at the file.

While this prevents the problem from occuring, further investigation is
probably needed as to why this interaction between Solaris and the Linux
kernel NFS daemon occurs.

Posted here in hopes that it will help someone else out with this
problem.

