Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265263AbUGISvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265263AbUGISvz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 14:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265300AbUGISvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 14:51:55 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:36071 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S265263AbUGISvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 14:51:50 -0400
From: jmerkey@comcast.net
To: Hans Reiser <reiser@namesys.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: Ext3 File System "Too many files" with snort
Date: Fri, 09 Jul 2004 18:51:43 +0000
Message-Id: <070920041851.1654.40EEE93E000E6414000006762200748184970A059D0A0306@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Jun 24 2004)
X-Authenticated-Sender: am1lcmtleUBjb21jYXN0Lm5ldA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




> >Andi,  
> >
> >Sounds like this is correct.    I will look at statfs().  I am very familiar 
> >with this section of linux 
> >with the VFS.  We should make this value 32 bit.  One solution would be to 
> >instrument a 
> >versioning field in the superblock so we can write the smarts into 
> ext3/2/reiser  
> >to handle
> >different on-disk structures.  when a supoerblock gets read, it could detect 
> >waht type of 
> >on disk structures are instrumented.  
> >  
> >
> Just use reiser4 which has disk format plugins.  reiserfs v3 should stay 
> stable and undisturbed.
> 

I was actually looking through your code when this message arrived.   I am sending out 
another unit Monday to the site installed with reiser and Suse Linux, Might I suggest 
perhaps you consider making the change in reiser for the larger field size to 32 bit (I 
am looking at the code at present, and it appears you are using the same inode 
structure as everyone else) and I will default these systems to reiser instead of EXT3 
for this application.  There's another FS (not NWFS) that actually writes the captured
network traffic streaming to the system at over 400 MB/S which folks haven't seen 
yet, it acts more like on on-disk LRU with huge cache units (137 MB each) 
but snort and the network forensic applications use a standard file system for 
reporting.  Reiser is a good choice if this limitation can be removed.

Veil Erfolg and Gluck.  

Danke,

Jeff

Bitte 



> >Jeff  
> >  
> >
> >>-Andi
> >>
> >>    
> >>
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >
> >
> >  
> >
> 
