Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266357AbUGAWm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266357AbUGAWm4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 18:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266360AbUGAWm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 18:42:56 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:16537 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266357AbUGAWmw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 18:42:52 -0400
Date: Thu, 1 Jul 2004 15:42:15 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] task name handling in proc fs
Message-ID: <20040701224215.GC5090@w-mikek2.beaverton.ibm.com>
References: <20040701220510.GA6164@w-mikek2.beaverton.ibm.com> <20040701151935.1f61793c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040701151935.1f61793c.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2004 at 03:19:35PM -0700, Andrew Morton wrote:
> Mike Kravetz <kravetz@us.ibm.com> wrote:
> >
> > --- linux-2.6.7/fs/proc/array.c	Wed Jun 16 05:19:36 2004
> > +++ linux-2.6.7.ptest/fs/proc/array.c	Thu Jul  1 17:44:14 2004
> > @@ -97,14 +97,14 @@
> >  		name++;
> >  		i--;
> >  		*buf = c;
> > -		if (!c)
> > +		if (!*buf)
> >  			break;
> > -		if (c == '\\') {
> > -			buf[1] = c;
> > +		if (*buf == '\\') {
> > +			buf[1] = *buf;
> >  			buf += 2;
> >  			continue;
> >  		}
> > -		if (c == '\n') {
> > +		if (*buf == '\n') {
> >  			buf[0] = '\\';
> >  			buf[1] = 'n';
> >  			buf += 2;
> 
> What is this code for?

The code is copying the task name from 'c' to 'buf' one character
at a time.  It is then 'post processing' the characters.  Currently,
the post processing is based on the value of c which is part of the
source string (task->curr).  However, it is possible for the source
string to change during this copy (think exec).  In such a case I
think it is better to base the 'post processing' on the character
that already has been safely been copied to the target string rather
than the character in the source string which might have changed.

-- 
Mike
