Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265211AbUGISaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265211AbUGISaw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 14:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265212AbUGISaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 14:30:52 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:20717 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S265211AbUGISaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 14:30:46 -0400
From: jmerkey@comcast.net
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ext3 File System "Too many files" with snort
Date: Fri, 09 Jul 2004 18:30:45 +0000
Message-Id: <070920041830.21850.40EEE455000BE22E0000555A2200735446970A059D0A0306@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Jun 24 2004)
X-Authenticated-Sender: am1lcmtleUBjb21jYXN0Lm5ldA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> jmerkey@comcast.net writes:
> 
> > I may alter the on disk structures to increase this to something larger, say 
> 16,000,000,
> > which would break ext3 on other systems.  I will look at the code for this 
to 
> see if this is 
> > even possible without the FS meta data growing so huge, it renders 
performance 
> poor.
> > These types of limits should probably be done away with with an 
architectural 
> change, 
> 
> It's not only ext3 - one reason this limit is there because
> in the old stat st_nlink was 16bit only. Now that stat64 is there
> and glibc uses it by default it could be increased to 32bit, 
> but you would need to think what to do with old applications that 
> stat the directory. For files >2GB old stat returns an errno, 
> maybe this would need to be done for such directories too.
> 

Andi,  

Sounds like this is correct.    I will look at statfs().  I am very familiar 
with this section of linux 
with the VFS.  We should make this value 32 bit.  One solution would be to 
instrument a 
versioning field in the superblock so we can write the smarts into ext3/2/reiser  
to handle
different on-disk structures.  when a supoerblock gets read, it could detect 
waht type of 
on disk structures are instrumented.  

Jeff  
> -Andi
> 
