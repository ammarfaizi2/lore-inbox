Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264128AbTDJTZC (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 15:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264131AbTDJTZC (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 15:25:02 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32518 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264128AbTDJTZA (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 15:25:00 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: msync() more expensive than fsync()?
Date: 10 Apr 2003 12:36:16 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b74h3g$55l$1@cesium.transmeta.com>
References: <3E92FAE6.8000300@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3E92FAE6.8000300@nortelnetworks.com>
By author:    Chris Friesen <cfriesen@nortelnetworks.com>
In newsgroup: linux.dev.kernel
> 
> Without any explicit flushing it takes 8 usec to log a message.
> 
> If I msync() only the pages that were touched in writing (usually 3 pages) it 
> takes 39 usecs to log a message.
> 
> If I fsync() the entire file (200KB) it takes 12 usec to log a message.
> 
> Why the additional cost for msync()?  I would have thought it would be faster 
> since it is explicitely for mmapped memory areas.  As a side note, the 
> difference is even more extreme if a file is used on a disk-backed filesystem.
> 

Because fsync() does less work.  In particular, fsync() doesn't do the
work you want: unlike msync() it doesn't guarantee that memory maps
are consistent with the filesystem.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
