Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262594AbTCZW3c>; Wed, 26 Mar 2003 17:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262595AbTCZW3c>; Wed, 26 Mar 2003 17:29:32 -0500
Received: from waste.org ([209.173.204.2]:22702 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S262594AbTCZW3a>;
	Wed, 26 Mar 2003 17:29:30 -0500
Date: Wed, 26 Mar 2003 16:40:26 -0600
From: Matt Mackall <mpm@selenic.com>
To: Lincoln Dale <ltd@cisco.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, ptb@it.uc3m.es,
       Justin Cormack <justin@street-vision.com>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ENBD for 2.5.64
Message-ID: <20030326224026.GO20244@waste.org>
References: <5.1.0.14.2.20030326182627.0387b1a0@mira-sjcm-3.cisco.com> <3E81132C.9020506@pobox.com> <200303252053.h2PKrRn09596@oboe.it.uc3m.es> <3E81132C.9020506@pobox.com> <5.1.0.14.2.20030326182627.0387b1a0@mira-sjcm-3.cisco.com> <5.1.0.14.2.20030327085031.04aa7128@mira-sjcm-3.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20030327085031.04aa7128@mira-sjcm-3.cisco.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 27, 2003 at 09:10:14AM +1100, Lincoln Dale wrote:
> At 10:09 AM 26/03/2003 -0600, Matt Mackall wrote:
> >> >Indeed, there are iSCSI implementations that do multipath and
> >> >failover.
> >>
> >> iSCSI is a transport.
> >> logically, any "multipathing" and "failover" belongs in a layer above 
> >it --
> >> typically as a block-layer function -- and not as a transport-layer
> >> function.
> >>
> >> multipathing belongs elsewhere -- whether it be in MD, LVM, EVMS, 
> >DevMapper
> >> PowerPath, ...
> >
> >Funny then that I should be talking about Cisco's driver. :P
> 
> :-)
> 
> see my previous email to Jeff.  iSCSI as a transport protocol does have a 
> muxing capability -- but its usefulness is somewhat limited (imho).
> 
> >iSCSI inherently has more interesting reconnect logic than other block
> >devices, so it's fairly trivial to throw in recognition of identical
> >devices discovered on two or more iSCSI targets..
> 
> what logic do you use to identify "identical devices"?
> same data reported from SCSI Report_LUNs?  or perhaps the same data 
> reported from a SCSI_Inquiry?

Sorry, can't remember.
 
> does one now need to add logic into the kernel to provide some multipathing 
> for HDS disks?

No, most of it was done in userspace.

> >> >Both iSCSI and ENBD currently have issues with pending writes during
> >> >network outages. The current I/O layer fails to report failed writes
> >> >to fsync and friends.
> >>
> >> these are not "iSCSI" or "ENBD" issues.  these are issues with VFS.
> >
> >Except that the issue simply doesn't show up for anyone else, which is
> >why it hasn't been fixed yet. Patches are in the works, but they need
> >more testing:
> >
> >http://www.selenic.com/linux/write-error-propagation/
> 
> oh, but it does show up for other people.  it may be that the issue doesn't 
> show up at fsync() time, but rather at close() time, or perhaps neither of 
> those!

Write errors basically don't happen for people who have attached
storage unless their drives die. Which is why the fact that the
pagecache completely ignores I/O errors has gone unnoticed for years..
 
> code looks interesting.  i'll take a look.
> hmm, must find out a way to intentionally introduce errors now and see what 
> happens!

We stumbled on it by pulling cables to make failover happen.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
