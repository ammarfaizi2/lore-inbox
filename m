Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbTESQnb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 12:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262157AbTESQnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 12:43:31 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:19987 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S262008AbTESQn3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 12:43:29 -0400
Date: Mon, 19 May 2003 18:56:23 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Christoph Hellwig <hch@infradead.org>,
       Martin Schlemmer <azarah@gentoo.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       KML <linux-kernel@vger.kernel.org>
Cc: davem@redhat.com, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Recent changes to sysctl.h breaks glibc
Message-ID: <20030519165623.GA983@mars.ravnborg.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Schlemmer <azarah@gentoo.org>,
	William Lee Irwin III <wli@holomorphy.com>,
	KML <linux-kernel@vger.kernel.org>, davem@redhat.com,
	Linus Torvalds <torvalds@transmeta.com>
References: <1053289316.10127.41.camel@nosferatu.lan> <20030518204956.GB8978@holomorphy.com> <1053292339.10127.45.camel@nosferatu.lan> <20030519063813.A30004@infradead.org> <1053341023.9152.64.camel@workshop.saharact.lan> <20030519124539.B8868@infradead.org> <1053348984.9142.98.camel@workshop.saharact.lan> <20030519140617.A15587@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030519140617.A15587@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 19, 2003 at 02:06:18PM +0100, Christoph Hellwig wrote:
> On Mon, May 19, 2003 at 02:56:25PM +0200, Martin Schlemmer wrote:
> > Point is just that people like you keep on bitching about not
> > using sanitized kernel headers, but do nothing about it, or
> > until today have said nothing about 'sanitized headers'.
> 
> Why don't you just get the glibc-kernheaders package from rawhide
> (or the equivalent from your prefered distribution) and stop
> complaining? 

Since this is brought up againg.

Today we have:
include/asm-<arch>
include/linux
include/<subsystem>

Within include/linux grep told me that "#ifdef __KERNEL__" was present
in 219 places. So a lot of header files are kept in a shape that allows
them to be included from user-land.

I see two possible solutions here:
1) Automate the process of creating sanitized user-land headers.
- It should be a trivial task to do - but will require some effort
  to be done right. Does any tool exist to do it today?
  Automation allows glibc to user kernel headers for a recent
  kernel without looking up a distribution specific set of header
  files somewhere.
  
  Dave M brougt up one issue the other day, when he added a new define
  to a header file. No need to wait for a distribution to pick up.

2) Create a user level hirachy under include/ [obviously 2.7 material]

include/linux/user
include/<subsystem>/user
include/asm-<arch>/user

In reality we will see a lot of files in include/linux that looks like:

sched.h:
part 1 - all relevant includes:
	#include <linux/.....>
	...
part 2 - user level interface
	#include <linux/user/sched.h>

part 3 - kernel specific definitions.
	extern rwlock_t tasklist_lock;
	extern spinlock_t mmlist_lock;

I am well aware that by default glibc shall NOT use kernel headers.
But IMHO it is too difficult to upgrate to a new version of the kernel
headers.

Care to explain what is wrong with the above approaches - I may have
missed something obvious.

	Sam

