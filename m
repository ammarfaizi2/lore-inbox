Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265639AbSJSRiq>; Sat, 19 Oct 2002 13:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265640AbSJSRiq>; Sat, 19 Oct 2002 13:38:46 -0400
Received: from ma-northadams1b-3.bur.adelphia.net ([24.52.166.3]:11393 "EHLO
	ma-northadams1b-3.bur.adelphia.net") by vger.kernel.org with ESMTP
	id <S265639AbSJSRio>; Sat, 19 Oct 2002 13:38:44 -0400
Date: Sat, 19 Oct 2002 13:44:45 -0400
From: Eric Buddington <eric@ma-northadams1b-3.bur.adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: Re: can chroot be made safe for non-root?
Message-ID: <20021019134445.B28191@ma-northadams1b-3.bur.adelphia.net>
Reply-To: ebuddington@wesleyan.edu
References: <20021016015106.E30836@ma-northadams1b-3.bur.adelphia.net> <87n0pevq5r.fsf@ceramic.fifi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <87n0pevq5r.fsf@ceramic.fifi.org>; from phil@fifi.org on Tue, Oct 15, 2002 at 11:44:32PM -0700
Organization: ECS Labs
X-Eric-Conspiracy: there is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 11:44:32PM -0700, Philippe Troin wrote:
> > Would it be reasonable to allow non-root processes to chroot(), if the
> > chroot syscall also changed the cwd for non-root processes?
> 
> No.
> 
>   fd = open("/", O_RDONLY);
>   chroot("/tmp");
>   fchdir(fd);
> 
> and you're out of the chroot.

I see. From my aesthetic, it would make sense for chroots to 'stack',
such that once a directory is made the root directory, its '..' entry
*always* points to itself, even after another chroot(). That would
prevent the above break (you could be outside the new root, but you
still couldn't back out past the old root), though perhaps at an
unacceptable in complexity.

I do like the idea of preventing multiple chroots, as a second option.

Thanks to everyone for all the useful comments.

-Eric
