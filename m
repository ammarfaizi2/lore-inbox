Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262901AbSJLLgW>; Sat, 12 Oct 2002 07:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262905AbSJLLgW>; Sat, 12 Oct 2002 07:36:22 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:33040 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S262901AbSJLLgU>; Sat, 12 Oct 2002 07:36:20 -0400
Date: Sat, 12 Oct 2002 13:42:05 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 - (NUMA))
Message-ID: <20021012114205.GB32511@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0210041610220.2465-100000@home.transmeta.com> <200210060130.g961UjY2206214@pimout2-ext.prodigy.net> <3DA7647C.3060603@namesys.com> <20021012012807.1BB5B635@merlin.webofficenow.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021012012807.1BB5B635@merlin.webofficenow.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Oct 2002, Rob Landley wrote:

> I'm also looking for an "unmount --force" option that works on something 
> other than NFS.  Close all active filehandles (the programs using it can just 
> deal with EBADF or whatever), flush the buffers to disk, and unmount.  None 
> of this "oh I can't do that, you have a zombie process with an open file...", 
> I want  "guillotine this filesystem pronto, capice?" behavior.

Seconded.

The patch at the URL below used to work back with 2.4.9, I did not track
what has become of it, if it still applies, I haven't needed it recently
or if so, Alt-SysRq was fair enough for me. Maybe just updating this
badfs and forced umount patch for 2.4.20 would suffice:

http://www.moses.uklinux.net/patches/forced-umount-2.4.9.patch

It gives me one reject in fs/super.c that I don't know how to fix:

***************
*** 1145,1150 ****
  		return retval;
  	}
  
  	spin_lock(&dcache_lock);
  
  	if (atomic_read(&sb->s_active) > 1) {
--- 1172,1180 ----
  		return retval;
  	}
  
+ 	if (flags&MNT_FORCE)
+ 		quiesce_filesystem(mnt);
+ 
  	spin_lock(&dcache_lock);
  
  	if (atomic_read(&sb->s_active) > 1) {
