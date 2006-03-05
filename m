Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWCEESr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWCEESr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 23:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWCEESr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 23:18:47 -0500
Received: from sccrmhc14.comcast.net ([204.127.200.84]:44449 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1750825AbWCEESq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 23:18:46 -0500
Subject: Re: SEEK_HOLE and SEEK_DATA support?
From: Nicholas Miell <nmiell@comcast.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Jim Dennis <jimd@starshine.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060304190538.0a94b4a0.akpm@osdl.org>
References: <20060302214929.GA16523@starshine.org>
	 <20060304190538.0a94b4a0.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 04 Mar 2006 20:18:37 -0800
Message-Id: <1141532317.2991.21.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-04 at 19:05 -0800, Andrew Morton wrote:
> jimd@starshine.org (Jim Dennis) wrote:
> >
> > 
> >  All,
> > 
> >  Has there been any thought about adding SEEK_HOLE and SEEK_DATA (*)
> >  support to Linux?  
> > 
> >  I ask primarily because of the interplay between 64-bit systems and
> >  things like /var/log/lastlog (which appears as a 1.2TiB file due to
> >  the nfsnobody UID of 4294967294).
> > 
> >  (I'm realize that adding support for these additional seek() flags
> >  wouldn't solve the problem ... archiving tools would still have to
> >  implement it.  And I can also hear the argument that Red Hat and other
> >  distributions should re-implement lastlog handling to use a more modern
> >  and efficient hashing/index format and perhaps that they should set
> >  nfsnobody to "-1" ... I'd be curious if those details are driven by
> >  some published standard or if they are artifacts of porting.  I'd also
> >  be curious what's happened with other 64-bit UNIX ports and whether
> >  this issue ever came up in Linux ports to the Alpha or other 64-bit
> >  processors).
> > 
> >  As a stray data point I just did a quick experiment and just doing
> >  a time cat /var/log/lastlog > /dev/null took about:
> > 
> >  36.33user 2453.99system 41:35.90elapsed 99%CPU 
> >     (0avgtext+0avgdata 0maxresident)k
> >     0inputs+0outputs (133major+15minor)pagefaults 0swaps
> > 
> > 
> >  On an otherwise idle 2GHz dual Opteron (yes, of course the extra
> >  CPU is wasted for this job), reading SCSI disk hanging off a Fusion MPT 
> >  controller.
> > 
> >  From what I hear our Networker processes pore over these NULs for about
> >  two hours any time someone fails to exclude /var/log/lastlog from their
> >  backup list.
> 
> This can already be solved in userspace (and I'm sure it already has been
> in some backup programs).  Use the FIBMAP ioctl() against the fd to find
> out whether a particular block in the file is actually instantiated.
> 
> Not all filesystems necessarily implement FIBMAP, so one would need to fall
> back to sucky mode if FIBMAP failed.
> 

FIBMAP is a privileged operation.

-- 
Nicholas Miell <nmiell@comcast.net>

