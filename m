Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbUAAW6G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 17:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbUAAW6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 17:58:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:51605 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261850AbUAAW57 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 17:57:59 -0500
Date: Thu, 1 Jan 2004 14:57:42 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nigel Cunningham <ncunningham@clear.net.nz>
cc: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
       Arjan van de Ven <arjanv@redhat.com>, Jon Smirl <jonsmirl@yahoo.com>,
       dri-devel <dri-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Dri-devel] 2.6 kernel change in nopage
In-Reply-To: <1072990656.25583.18.camel@laptop-linux>
Message-ID: <Pine.LNX.4.58.0401011455130.5282@home.osdl.org>
References: <20031231182148.26486.qmail@web14918.mail.yahoo.com>
 <1072958618.1603.236.camel@thor.asgaard.local> <1072959055.5717.1.camel@laptop.fenrus.com>
 <1072959820.1600.252.camel@thor.asgaard.local> <20040101122851.GA13671@devserv.devel.redhat.com>
 <1072967278.1603.270.camel@thor.asgaard.local> <Pine.LNX.4.58.0401011205110.2065@home.osdl.org>
 <1072990656.25583.18.camel@laptop-linux>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 2 Jan 2004, Nigel Cunningham wrote:
> 
> Of course there are also advantages to _not_ using the file-per-kernel
> version scheme.

No there isn't.

The thing is, you should keep those "file-per-OS" files as small as 
possible, and only contain the things that are literally different. 
Because:

>		 Keeping one set of files means time is not wasted
> applying the same change to multiple variations

If the files only contain the actual differences, this just isn't an 
issue. Those files are per-OS _anyway_, so regardless of how you do it 
(with #ifdef's inside our outside the code etc), you'd have several 
versions.

And having separate files means that you don't uglify the code for another 
OS or another version and hide the _real_ issues.

But yes, it assumes that you can cleanly abstract out the differences.

		Linus
