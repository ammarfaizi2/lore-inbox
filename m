Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261978AbULPSyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261978AbULPSyW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 13:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbULPSyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 13:54:22 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:3220 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261978AbULPSwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 13:52:54 -0500
Message-ID: <41C1D984.8030707@namesys.com>
Date: Thu, 16 Dec 2004 10:52:52 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Masover <ninja@slaphack.com>
CC: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org, Nate Diller <ndiller@namesys.com>
Subject: Re: file as a directory
References: <200411301631.iAUGVT8h007823@laptop11.inf.utfsm.cl>	 <41ACA7C9.1070001@namesys.com>	 <1103043518.21728.159.camel@pear.st-and.ac.uk>	 <41BF21BC.1020809@namesys.com> <1103059622.2999.17.camel@grape.st-and.ac.uk> <41BFC1C5.1070302@slaphack.com> <41BFCB66.3090809@namesys.com> <41C0D3F8.1020408@slaphack.com>
In-Reply-To: <41C0D3F8.1020408@slaphack.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover wrote:

> Hans Reiser wrote:
> [...]
> | Explain the value of caching executable output more please.
>
> If executables become "plugins" (see below), there is a performance loss
> to be made up by caching.  For instance, if we have an executable which
> calls "tar", which we attach to a tarball, we want to cache the
> extracted files.

This requires writing the plugin to have explicit caching of output.  It 
could be quite interesting actually.

>   It's even more urgent when people start writing
> perl/python/ruby executables to deal with system configuration files,
> such as /etc/passwd.  It's allright for passwd to take half a second to
> generate, so long as we cache that output, and thus only spend the half
> second when passwd is modified, instead of every time a user logs in.
> |
> |>
> |> | The component objects themselves could be full objects, so they
> |> | themselves could have sub-components.
> |>
> |> Right.
> |>
> |> Also, there should be an inverse. For instance, a file-as-directory 
> type
> |> object should have a "contents" object, usually a normal directory, but
> |> which could conceivably be any type of object, including a code-ish
> |> object which implements a filesystem. Accessing foo/ would be the same
> |> as accessing foo/.../contents, only because "..." (or whatever we use
> |> for meta-files) is outside the actual directory namespace,
> |> foo/.../contents/... refers to the metas of object "contents", 
> which are
> |> different than the metas of object "foo".
> |
> |
> | Are you sure that having more than one "...." is needed?  Hmmm,
> | interesting, must think about it.
>
> Yes. foo is a file, foo/contents is another file (an executable).  But
> maybe the executable has contents too -- with an extra "...", you can do
> things like "foo/.../contents/.../contents", where the first "contents"
> controls what you get from "ls foo/", and the second "contents" controls
> what you get from "ls foo/.../contents/".
>
> |>
> |> These two steps essentially create userspace "plugins", and do away 
> with
> |> having to mount other kernel layers such as lufs (or whatever its
> |> current implementation is).
> |
> |
> | I don't follow this point above.
>
> lufs is (or was) a kernel filesystem which talks to a user daemon.  The
> daemon does all the work, so you don't have to do things like windows
> emulation in the kernel in order to get captive-ntfs to work.
>
> The reason we don't do that for the whole filesystem is performance --
> after all, userland things are easier to write, debug, upgrade, and
> install/use than kernel things.
>
> If an executable can generate a directory listing or a whole directory
> structure, some files, and so on, then we only need a few reiser4 kernel
> plugins, and these userland executables can implement all the
> functionality of most kernel plugins people have thought of so far.
>
> The only problem is, it would be much slower than a kernel plugin.
> Caching solves that.
>
> Of course, someone still might find a situation where people really need
> to create a new kernel plugin, and that would be allowed.  But I doubt
> it would help that much, or we'd all be using TUX instead of Apache.
>
> [...]
>
> |> I think the issues with directory-as-a-file were the same problems you
> |> get when you allow hardlinked directories -- that you'd eventually have
> |> to ditch reference counting for a garbage collector, which is hellishly
> |> impractical. I don't have a solution to that, other than dropping
> |> hardlinks entirely.
> |
> |
> | This issue is overblown.  Other fields have solved this problem.
>
> Nevertheless, it's an issue that I don't have the skills to solve, and
> one that must be solved if we are ever to implement these concepts.
>
> If you have a solution, I'd love to hear it.

My solution is to tell Nate Diller that there is extensive literature on 
it, that it isn't really the big problem it is made out to be, and leave 
it to him to go read the literature and code it up after he finishes the 
required tasks of our current darpa contract.;-)
