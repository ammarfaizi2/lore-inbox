Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264814AbSKEImC>; Tue, 5 Nov 2002 03:42:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264815AbSKEImC>; Tue, 5 Nov 2002 03:42:02 -0500
Received: from users.linvision.com ([62.58.92.114]:13965 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S264814AbSKEImB>; Tue, 5 Nov 2002 03:42:01 -0500
Date: Tue, 5 Nov 2002 09:47:42 +0100
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "David D. Hagood" <wowbagger@sktc.net>,
       Rik van Riel <riel@conectiva.com.br>, "Theodore Ts'o" <tytso@mit.edu>,
       Dax Kelson <dax@gurulabs.com>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: Filesystem Capabilities in 2.6?
Message-ID: <20021105094741.A32344@bitwizard.nl>
References: <3DC47659.4060006@sktc.net> <Pine.LNX.4.44.0211021803240.2300-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211021803240.2300-100000@home.transmeta.com>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2002 at 06:05:09PM -0800, Linus Torvalds wrote:
> 
> On Sat, 2 Nov 2002, David D. Hagood wrote:
> > Linus Torvalds wrote:
> > >
> > > And pathnames are a _hell_ of a lot better and straightforward interface
> > > than inode numbers are. It's confusing when you change the permission on
> > > one path to notice that another path magically changed too.
> > 
> > Would this not allow a user to add permissions to a file, by creating a 
> > new directory entry and linking it to an existing inode?
> > 
> > Would that not be a greater security hole?
> 
> No. The file itself has _no_ capabilities at all. If you just link to it,
> you can give it whatever capabilities _you_ have as a user (well, normal
> users don't really have any capabilities to give, but you get the idea).

Capabilties done right, means that normal users DO have capabilities. 
Normal users have the capability to call normal syscalls like "read", 
"write" and "execve".

And once you have these included in the capabilities (which normal users
and programs normally have by default), you can take them away if you
want. For example, a non-scripting webserver may not require any use of
the "execve" system call.

Oh, it's easy to get a "vector" of over 100 capabilities this way. This
might be inefficient. Thus, it would be required that we get two levels:
first level as you're thinking of it: split capabilities for what 
"root" now has, and the other also splitting the "normal user"'s 
capabilities (and splitting the root-kinds even further).



		Roger.

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* The Worlds Ecosystem is a stable system. Stable systems may experience *
* excursions from the stable situation. We are currently in such an      * 
* excursion: The stable situation does not include humans. ***************
