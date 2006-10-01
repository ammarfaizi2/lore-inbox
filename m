Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbWJAQT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbWJAQT2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 12:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbWJAQT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 12:19:27 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:58518 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1751231AbWJAQT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 12:19:26 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 1 Oct 2006 09:19:23 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Jeff Garzik <jeff@garzik.org>
cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fs/eventpoll: error handling micro-cleanup
In-Reply-To: <451FE7E3.4050503@garzik.org>
Message-ID: <Pine.LNX.4.64.0610010911231.21285@alien.or.mcafeemobile.com>
References: <20061001124352.GA30263@havoc.gtf.org>
 <Pine.LNX.4.64.0610010900540.21285@alien.or.mcafeemobile.com>
 <451FE7E3.4050503@garzik.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Oct 2006, Jeff Garzik wrote:

> Davide Libenzi wrote:
> > On Sun, 1 Oct 2006, Jeff Garzik wrote:
> > 
> > > While reviewing the 'may be used uninitialized' bogus gcc warnings,
> > > I noticed that an error code assignment was only needed if an error had
> > > actually occured.
> > 
> > But that saved one line of code, and there are countless occurences in the
> > kernel of such code pattern ;)
> 
> I'm not sure there are countless occurrences with PTR_ERR().  The line is
> incorrect (but harmless) if inode is a valid pointer...

I just tried a `find /usr/src/linux-2.6.16/ -type f -exec grep -H -C 2 PTR_ERR {} \;`
and looked at the cases where the error variable is assigned in any case 
before the test. Same code pattern as, like:

error = -EFAULT;
if (copy_from_user(...))
	goto kaboom;

Again, expect a big patch if you're gonna fix all those ;)



- Davide


