Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbTKXX5f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 18:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbTKXX5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 18:57:34 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:15884 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S261793AbTKXX5a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 18:57:30 -0500
Date: Mon, 24 Nov 2003 15:57:24 -0800
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: x86: SIGTRAP handling differences from 2.4 to 2.6
Message-ID: <20031124235724.GH5873@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <bppjkt$ik0$1@cesium.transmeta.com> <Pine.LNX.4.44.0311230954460.17378-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311230954460.17378-100000@home.osdl.org>
User-Agent: Mutt/1.3.27i
X-Message-Flag: This space available
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 23, 2003 at 09:59:47AM -0800, Linus Torvalds wrote:
> 
> On 22 Nov 2003, H. Peter Anvin wrote:
> > 
> > Okay... I'm going to ask the obvious dumb question:
> > 
> > Why do we bother special-casing init at all?
> 
> Because the kernel depends on it existing. "init" literally _is_ special 
> from a kernel standpoint, because its' the "reaper of zombies" (and, may I 
> add, that would be a great name for a rock band).
> 
> So without init, the kernel wouldn't have anybody to fall back on when a 
> parent process dies, and would become very very unhappy. Historically it 
> actually oopsed the kernel.
> 
> UNIX semantics literally _require_ that "getppid()" should return 1 if 
> your parent dies, and that's "current->p_parent->tgid". So we have to have 
> a parent with pid 1, and thus init really _is_ special.
> 
> Yeah, we could have _other_ special cases (we could create another process 
> that is invisible and has pid 1), but the fact is, _some_ special case is 
> required. It might as well be "you can't kill init".

For a normal init where is pretty bullet resistant having it
unkillable makes sense.  If init were somehow to go
pathological the whole system is suspect.

On the other hand, there are some who run something besides
the usual init. In that case it might make sense to allow
init to respawn.  -- speculation only.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
