Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbUKSUX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbUKSUX5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 15:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbUKSUVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 15:21:38 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:4746 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261616AbUKSUOi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 15:14:38 -0500
Date: Fri, 19 Nov 2004 21:14:24 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Martin Schaffner <schaffner@gmx.li>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: HFS+ Bug which causes coreutils "make test" to fail
In-Reply-To: <76E0E3D3-3A52-11D9-B5E1-0003931E0B62@gmx.li>
Message-ID: <Pine.LNX.4.61.0411192032220.17266@scrub.home>
References: <CA837452-38E4-11D9-8FA5-0003931E0B62@gmx.li>
 <20041117195236.475d0922.akpm@osdl.org> <76E0E3D3-3A52-11D9-B5E1-0003931E0B62@gmx.li>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 19 Nov 2004, Martin Schaffner wrote:

> > > mkdir a; chmod 1777 a; touch a/b; su otheruser -c "rm -rf a"

The problem is that rm does a chdir into a/b after unlink fails and tries 
to treat it like a directory. It's rather unclear why rm does that.
HFS allows to chdir into a file right now, because it doesn't has enough 
information to distinguish it from a lookup (for the resource fork).
OTOH it's easily fixable within rm, lstat clearly says it's a regular 
file, so rm has no reason to treat it like a dir.

> > > The other failure related to the fact that all pipe files are suffixed
> > > by "|", and all links by "@" when doing "ls -1F" on HFS+

I don't see what HFS should do different here, ext2 does the same. Can you 
send me the strace output to demonstrate the difference?

bye, Roman
