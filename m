Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261895AbULOF2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbULOF2m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 00:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbULOF2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 00:28:42 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:9643 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261895AbULOF2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 00:28:01 -0500
Message-ID: <41BFCB66.3090809@namesys.com>
Date: Tue, 14 Dec 2004 21:28:06 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Masover <ninja@slaphack.com>
CC: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: file as a directory
References: <200411301631.iAUGVT8h007823@laptop11.inf.utfsm.cl>	 <41ACA7C9.1070001@namesys.com>	 <1103043518.21728.159.camel@pear.st-and.ac.uk>	 <41BF21BC.1020809@namesys.com> <1103059622.2999.17.camel@grape.st-and.ac.uk> <41BFC1C5.1070302@slaphack.com>
In-Reply-To: <41BFC1C5.1070302@slaphack.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover wrote:

> Peter Foldiak wrote:
> | On Tue, 2004-12-14 at 17:24, Hans Reiser wrote:
> |
> |>Peter, I think you are right, though it might be useful to have the
> |>default be dirname/..../glued and to allow users to link
> |>dirname/..../filebody to
> |>dirname/..../something_else_if_they_want_it_to_not_be_glued, and to have
> |>dirname/..../filebody or whatever it is linked to be what they get if
> |>they read the directory as a file.
> |
> |
> | Yes. I assume you mean that dirname in itself should always be
> | interpreted as dirname/..../glued, which by default would be a linked to
> | dirname/..../filebody, the latter being the file content, right?
>
> I think he means the other way.
>     cat foo
> is the same as
>     cat foo/.../filebody
> where "filebody" is some sort of link to (maybe) foo/.../glued.
>
> Understand that you want to allow "normal" files which are not "glued"
> anything, but also "glued" files which are composed of sub-files.
>
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

Interesting....

>
> This could be done with pipes and daemons, but it's not as easy to
> manage and seems impossible to do as efficiently (with built-in caching,
> etc.)

Explain the value of caching executable output more please.

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

Are you sure that having more than one "...." is needed?  Hmmm, 
interesting, must think about it.

>
> These two steps essentially create userspace "plugins", and do away with
> having to mount other kernel layers such as lufs (or whatever its
> current implementation is).

I don't follow this point above.

> It does have one important implication, though:
>
> It's important that "metas" or "..." or whatever we've decided on should
> _not_ be mutable by a "userspace" plugin that I have described, nor
> should any meta-files created by kernel plugins. There would be other
> security implications, of course -- user should still not be able to
> create files that are owned by other users and setuid. I'm not sure
> where such checks should go, but we want mortal users to be able to add
> whatever plugins they want, while super-users can feel safe using the
> metas interface to manipulate user files.
>
> I think the issues with directory-as-a-file were the same problems you
> get when you allow hardlinked directories -- that you'd eventually have
> to ditch reference counting for a garbage collector, which is hellishly
> impractical. I don't have a solution to that, other than dropping
> hardlinks entirely.

This issue is overblown.  Other fields have solved this problem. 

>
> Hmm. Why do we need hardlinks? I forget.

