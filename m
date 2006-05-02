Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbWEBWEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWEBWEL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 18:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWEBWEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 18:04:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29352 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932244AbWEBWEJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 18:04:09 -0400
Date: Tue, 2 May 2006 18:03:37 -0400
From: Dave Jones <davej@redhat.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Wu Fengguang <wfg@mail.ustc.edu.cn>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jens Axboe <axboe@suse.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [RFC] kernel facilities for cache prefetching
Message-ID: <20060502220337.GB15286@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Wu Fengguang <wfg@mail.ustc.edu.cn>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Jens Axboe <axboe@suse.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
	Badari Pulavarty <pbadari@us.ibm.com>
References: <20060502075049.GA5000@mail.ustc.edu.cn> <1146556724.32045.19.camel@laptopd505.fenrus.org> <20060502080619.GA5406@mail.ustc.edu.cn> <1146558617.32045.23.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1146558617.32045.23.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2006 at 10:30:17AM +0200, Arjan van de Ven wrote:

 > one interesting thing that came out of the fedora readahead work is that
 > most of the bootup isn't actually IO bound. 

Here's another interesting datapoint.
A huge proportion of I/O done during bootup is _completely_ unnecessary.

Profiling just a few of the places that seemed to stall yielded some
lovely things, like cupsd reading in and parsing descriptions for
every printer ever known to man, even if there's no printer connected.
Or my favorite.. hald reloading and reparsing the same XML hardware description
files.. ~50 times, _each_.

Utterly insane.

(And these aren't Fedora specific problems btw, every distro shipping those
 bits will have the same dumb behaviour [modulo versions])

		Dave

-- 
http://www.codemonkey.org.uk
