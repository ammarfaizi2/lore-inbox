Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbVKUIb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbVKUIb4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 03:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbVKUIb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 03:31:56 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:32745
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932225AbVKUIbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 03:31:55 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [RFC] sys_punchhole()
Date: Mon, 21 Nov 2005 00:46:44 -0600
User-Agent: KMail/1.8
Cc: Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>,
       andrea@suse.de, hugh@veritas.com, lkml <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
References: <1131664994.25354.36.camel@localhost.localdomain> <20051113150906.GA2193@spitz.ucw.cz> <1132178470.24066.85.camel@localhost.localdomain>
In-Reply-To: <1132178470.24066.85.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200511210046.45236.rob@landley.net>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 November 2005 16:01, Badari Pulavarty wrote:
> Hmm. Someone other than me asking for it ?
>
> I did the madvise() hack and asking to see if any one really needs
> sys_punchole().

I run into a potential use case for every once in a while.  For example, there 
was recent discussion on the User Mode Linux list about this, since the 
"physical memory" that uses is an mmaped file so the logical way to give 
unused memory back to the host OS (initially via a hotplug memory interface 
driven by some kind of daemon, since the pagecache expands to fill all 
available space even when the data is also redundantly cached by the host OS) 
would by via sys_punchole().

Of course UML's physmem file is normally on a tmpfs() mount, where 
madvise(DONTNEED) has special behavior to work like punch anyway.  So it 
looks like special cases to work around this lack can be added ad infinitum 
so there's never any immediate need for the actual generic functionality.

On the other hand, if you're going to support holes at all, having to recreate 
the file to get your hole back is kind of silly.  I personally think the 
ability to create holes in a new file but not create holes in an existing 
file is every bit as strange as being able to extend a file but not truncate 
it.  (See the java 1.1 api for an example of _that_ particular thinko...)

Rob
