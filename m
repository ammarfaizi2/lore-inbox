Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268220AbUHQNNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268220AbUHQNNe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 09:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268228AbUHQNNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 09:13:33 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:64677 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S268220AbUHQNNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 09:13:08 -0400
Date: Tue, 17 Aug 2004 15:12:09 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408171312.i7HDC9ih029439@burner.fokus.fraunhofer.de>
To: andreas.messer@gmx.de, schilling@fokus.fraunhofer.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1 Mis-detect CRDW as CDROM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Andreas Messer <andreas.messer@gmx.de>
>Joerg Schilling wrote:
>> Judging from the number of reports, I would guess that the Linux kernel is
>> much more insecure than cdrecord.
>>
>> What some people did (chmod on /dev/ entries) was definitely always a
>> bigger security risk than running cdrecord suid root.

>I, dont think, that running cdrecord suid root is a risk, but i think, that 
>there are much more cd-recording applications, not based on cdrecord, which 
>may be insecure. Or perhaps someone will write a little programm, wich will 
>override the firmware.
>I think its a good way to filter the commands within the kernel. Its a 
>additional security-barrage. 

I did not say that it should not be done at all. I only don't like that it
has been introduced without warning.

Next week, I will publish cdrtools-2.01-final and thus there is code freeze now.
Only extreme bugs _inside_ cdrtools will be fixed and only if this is possible
with knowing all side effects.

As I already wrote: libscg already has the ability to switch to euid 0 before
a SCSI command is send and to switch back to the old euid directly after the 
SCSI command returns. But this has only been introduced and tested on Solaris.
Making it work on Linux too would be a feature extension which is not possible
while in code freeze.

Also note that it is questionable whether this change really increases the 
security. In case that the check is only done at open() time, cdrecord could
later switch into a state that does not allow to become root again later.
In case you need root privs for sending generic SCSI, cdrecord needs to keep
its ability to become root again later. If there was a possible buffer overrun
problem, then a user could just push seteuid(0) before execl("/bin/sh".....
when creating an expliot.


Of course, all security issues that are independent from buffer overflows
will not happen with a uid switching cdrecord.

In general, applications that directly access hardware should be audited to be
secure and trusted. 

BTW: I am planning to make cdrecord usable on a rootless Solaris 10 in the 
near future. You then of course would need to use pfksh as your shell.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
