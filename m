Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262242AbTICNkn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 09:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262296AbTICNj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 09:39:56 -0400
Received: from ns1.mvps.org ([158.64.60.224]:42611 "EHLO
	edge.zoo.securewave.com") by vger.kernel.org with ESMTP
	id S262242AbTICNiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 09:38:12 -0400
Subject: Re: mmap(MAP_PRIVATE) question
From: Gianni Tedesco <giannit@securewave.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030903102804.GA21455@mail.jlokier.co.uk>
References: <1062581651.489.5.camel@lemsip>
	 <20030903102804.GA21455@mail.jlokier.co.uk>
Content-Type: text/plain
Message-Id: <1062596228.1356.17.camel@lemsip>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 03 Sep 2003 15:37:08 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-09-03 at 12:28, Jamie Lokier wrote:
> The page cache page is mapped into the application just like a shared
> mapping, until the application writes to the mapped region and
> triggers the copy-on-write fault.

that clears it up somewhat :)

> On the other hand you may not.  On some of the architectures which
> Linux supports, the CPU's cache is not sufficiently coherent to
> guarantee that what is written with write(), or by another process,
> will be seen in this application's memory.  Indeed, you might see a
> mixture of some of the written data and some of the data before it was
> written, with no particular guarantee of which bits of data or in what
> order.

Well, the thing I'm interested in is people overwriting parts of shared
libraries (at least those opened with dlopen). In my tests, I am using
mmap/msync to overwrite the library rodata section with
MS_SYNC|MS_INVALIDATE. When I do this the running copy (using
MAP_PRIVATE) appears unmodified, but no ETXTBSY error is given. What you
are saying would seem to indicate that the running program *should* be
modified.

Perhaps MS_INVALIDATE doesn't bother invalidating MAP_PRIVATE mappings?
Or am I missing a trick here? :)

(this is on intel btw).

-- 
Gianni Tedesco <giannit@securewave.com>

