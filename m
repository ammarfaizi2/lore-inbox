Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261825AbULOJ3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbULOJ3i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 04:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262278AbULOJ3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 04:29:38 -0500
Received: from psych.st-and.ac.uk ([138.251.11.1]:63360 "EHLO
	psych.st-andrews.ac.uk") by vger.kernel.org with ESMTP
	id S261825AbULOJ3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 04:29:34 -0500
Subject: Re: file as a directory
From: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>
To: David Masover <ninja@slaphack.com>
Cc: Hans Reiser <reiser@namesys.com>, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <41BFC1C5.1070302@slaphack.com>
References: <200411301631.iAUGVT8h007823@laptop11.inf.utfsm.cl>
	 <41ACA7C9.1070001@namesys.com>
	 <1103043518.21728.159.camel@pear.st-and.ac.uk>
	 <41BF21BC.1020809@namesys.com>
	 <1103059622.2999.17.camel@grape.st-and.ac.uk>
	 <41BFC1C5.1070302@slaphack.com>
Content-Type: text/plain
Message-Id: <1103102854.30601.12.camel@pear.st-and.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 15 Dec 2004 09:27:34 +0000
Content-Transfer-Encoding: 7bit
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-15 at 04:47, David Masover wrote:
> Peter Foldiak wrote:
> | Also, a pseudofile (e.g. dirname/..../structure ?) could be used to
> | specify how the files should be glued together. A simple question is,
> | for instance, what separators to use between the components, and what
> | ordering to use when putting the component objects together. (This
> | pseudofile could also determine more complicated ways of composing
> | objects.)
> 
> If the filesystem does caching, I'd rather have a type of executable
> which, read normally, appears as a stream of its own standard output.
> You'd get the actual file as something like bar/.../source.

This sounds better and more general than my proposed ..../structure
file. So could you explain this in a bit more detail?
Would for instance the simplest (and default?) glueing code in your
bar/..../source file be

cat *

which just concatenates all the subcomponents in no particular order?


> This could be done with pipes and daemons, but it's not as easy to
> manage and seems impossible to do as efficiently (with built-in caching,
> etc.)

How would you do it?

> 
> | The component objects themselves could be full objects, so they
> | themselves could have sub-components.
> 
> Right.
> 
> Also, there should be an inverse. For instance, a file-as-directory type
> object should have a "contents" object, usually a normal directory, but
> which could conceivably be any type of object, including a code-ish
> object which implements a filesystem. Accessing foo/ would be the same
> as accessing foo/.../contents, only because "..." (or whatever we use
> for meta-files) is outside the actual directory namespace,
> foo/.../contents/... refers to the metas of object "contents", which are
> different than the metas of object "foo".
> 
> These two steps essentially create userspace "plugins", and do away with
> having to mount other kernel layers such as lufs (or whatever its
> current implementation is). It does have one important implication, though:
> 
> It's important that "metas" or "..." or whatever we've decided on should
> _not_ be mutable by a "userspace" plugin that I have described, nor
> should any meta-files created by kernel plugins. There would be other
> security implications, of course -- user should still not be able to
> create files that are owned by other users and setuid. I'm not sure
> where such checks should go, but we want mortal users to be able to add
> whatever plugins they want, while super-users can feel safe using the
> metas interface to manipulate user files.

Sounds really interesting.

