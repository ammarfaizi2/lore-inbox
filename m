Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262824AbVA1X5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262824AbVA1X5S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 18:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262823AbVA1X5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 18:57:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:47287 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262822AbVA1X5M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 18:57:12 -0500
Date: Fri, 28 Jan 2005 15:57:13 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: Lee Revell <rlrevell@joe-job.com>,
       Martin Josefsson <gandalf@wlug.westbo.se>, linux-kernel@vger.kernel.org,
       "Trever L. Adams" <tadams-lists@myrealbox.com>
Subject: Re: [Bug 4081] New: OpenOffice crashes while starting due to a  
 threading error
Message-ID: <20050128155713.6f3ef6d8@dxpl.pdx.osdl.net>
In-Reply-To: <41FACEC5.6070703@comcast.net>
References: <217740000.1106412985@[10.10.2.4]>
	<41F30E0A.9000100@osdl.org>
	<1106482954.1256.2.camel@tux.rsn.bth.se>
	<20050126132504.3295e07d@dxpl.pdx.osdl.net>
	<41F97E07.2040709@comcast.net>
	<20050128093104.61a7a387@dxpl.pdx.osdl.net>
	<1106954493.3051.8.camel@krustophenia.net>
	<41FACEC5.6070703@comcast.net>
Organization: Open Source Development Lab
X-Mailer: Sylpheed-Claws 0.9.13 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2005 18:46:13 -0500
Parag Warudkar <kernel-stuff@comcast.net> wrote:

> Lee Revell wrote:
> 
> >  
> >
> >>munmap(0x955838, 8192)                  = -1 EINVAL (Invalid argument)
> >>munmap(0x80d7ff0, 3221222108)           = -1 EINVAL (Invalid argument)
> >>--- SIGSEGV (Segmentation fault) @ 0 (0) ---
> >>    
> >>
> >
> >No, it really looks like OO tried to munmap() something incorrectly.
> >3,221,222,108 bytes at offset 0x80d7ff0?
> >
> >Lee
> >
> >  
> >
> May be that's another OO.o bug which gets triggered by failure to open 
> /dev/dri? Actually Stephen had OO working fine with earlier kernels, 
> where possibly /dev/dri/* permissions were appropriate and it was able 
> to open it - With new kernel the permissions seem to be improper which 
> is confirmed by strace --
> 
> open("/dev/dri/card0", O_RDWR)          = -1 EACCES (Permission denied)
> 
> Should be filed as a bug with OO.org - it shouldnt segfault due to DRI permissions..
> 
> Parag

Note: on 2.6.10
	/dev/dri/card0	crw-rw-rw-
on 2.6.11-rc2
	/dev/dri/card0	crw-rw----
	/dev/dri/card1	crw-rw----

Changing permissions seems to fix (it for startup), will try more and see
if udev remembers not to turn them back.

-- 
Stephen Hemminger	<shemminger@osdl.org>
