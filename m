Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262884AbTJPMxy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 08:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262887AbTJPMxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 08:53:54 -0400
Received: from intra.cyclades.com ([64.186.161.6]:16845 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262884AbTJPMxw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 08:53:52 -0400
Date: Thu, 16 Oct 2003 09:52:30 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: andrea@suse.de, <riel@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.23-pre VM regression?
Message-ID: <Pine.LNX.4.44.0310160949230.2388-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrea, 

Martin first reported problems with "gzip -dc file | less" (280MB file).
less was getting killed. He had no swap... I asked him to add some swap
and it works now. Fine. 

The thing is that with 2.4.22 less was being killed, but with 2.4.23-pre
he gets:

>> And yes, the app was killed:
> >
> > __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> > VM: killing process named
> > __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> > VM: killing process gpm
> > __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> > VM: killing process sendmail
> > __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> > VM: killing process less

So a lot of processes which should not get killed are dying. This is
really bad. I was afraid it could happen and it did.

What now? Resurrect OOM-killer? 

> > Hi,
> >   it's a long time I haven't seen sthis messages, but it just happened that
> > I did on my laptop ASUS L3880C(1GB RAM). The message show on
> > 2.4.23-pre5+acpi20030918 and 2.4.23-pre7. The application get's killed on
> > 2.4.22-acpi20030918 too, just without the "0-order allocation" message.
> > I enabled in kernel the VM allocation debug option when configuring, but
> > apparently I have to turn it on also somewhere else. *Documentation* is
> > missing: 1) the help in "make config/menuconfig" etc. doesn't say anything,
> > the Documentation subdirectory doesn't say anything except "debug" as
> > kernel boot option on command-line(I did that too, but no change) and also
> > linux kernel-FAQ doesn't say either. :(
> >
> > How I tested?
> > `gzip -dc file | less' and pressed `G' to jump to the very end of the file.
> > The filesize is 280MB only. In a while, the mouse stopps moving for a
> > while, than the system gets sometimes unloaded, fan is raises it's RPM's up
> > and down town to time, and mouse cursor eventually does a move and then
> > less command gets killed. In dmesg I found:
> >
> > __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> > VM: killing process less

With 2.4.22:

> 2.4.22-acpi-20030918 with HIGHMEM gives only in dmesg:
>
> Out of Memory: Killed process 1904 (less).




