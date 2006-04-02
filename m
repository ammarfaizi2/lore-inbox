Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbWDBUri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbWDBUri (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 16:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbWDBUri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 16:47:38 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:25067 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932149AbWDBUrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 16:47:37 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC][PATCH 0/2] KABI example conversion and cleanup
Date: Sun, 2 Apr 2006 22:47:29 +0200
User-Agent: KMail/1.9.1
Cc: Sam Ravnborg <sam@ravnborg.org>, nix@esperi.org.uk, rob@landley.net,
       mmazur@kernel.pl, linux-kernel@vger.kernel.org,
       llh-discuss@lists.pld-linux.org
References: <200603141619.36609.mmazur@kernel.pl> <20060402175859.GA9839@mars.ravnborg.org> <1E3BAA12-E97A-410A-8CD1-837EE7F82DFE@mac.com>
In-Reply-To: <1E3BAA12-E97A-410A-8CD1-837EE7F82DFE@mac.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200604022247.29730.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 02 April 2006 21:30, Kyle Moffett wrote:
> > 3) 'Preprocess' include/ and generate a set of KABI files based on  
> > current set of (cleaned up) kernel header files.  'Preprocess in ''  
> > because a C-preprocessor will not be suitable.
> 
> I got the idea of preprocessing, but your sentence seems to have  
> gotten mangled somewhere.  Any chance you could clarify?  From what I  
> can see by looking through the current headers, preprocessing will  
> not solve some of the duplication I'd like to try to clean up.  One  
> example being the duplication of bitops in various macros all over  
> the place, FD_SET/FD_CLR/FD_ISSET being a prime example of that  
> duplication.  It would be really nice to be able to implement those  
> in terms of __set_bit, etc, however those macros themselves must be  
> made userspace-clean, including adding C89-compat macros for non-GCC  
> compilers and other mild ugliness, even though they'd never be  
> directly exposed for user programs.

These seem to be two completely independent problems. Reducing the
amount of duplication is a good thing all by itself that can be done
independent from finding a better way to provide the headers to 
user space.

About one year ago, I started down this route in order to autogenerate
something like linux-libc-headers from the kernel tree, but never got
around to submitting anything because I could not keep up with the
changes.

What I did there was to put a Makefile into each include directory
with a list of the files that should get installed (the list from
llc) and then add a headers_install target to Makefile that would
run each header file through an open-coded version of
'unifdef -U__KERNEL__ < include/$FILE > $PREFIX/include/$FILE'.

The advantage of this approach is that it minimises the amount of
change to each of the current header files while making it relatively
easy to audit by looking for wrong stuff (namespace pollution,
CONFIG_* dependencies, ...) in the installed headers.

	Arnd <><
