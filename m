Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318773AbSHBJuP>; Fri, 2 Aug 2002 05:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318797AbSHBJuP>; Fri, 2 Aug 2002 05:50:15 -0400
Received: from [195.63.194.11] ([195.63.194.11]:37637 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S318773AbSHBJuO>; Fri, 2 Aug 2002 05:50:14 -0400
Message-ID: <3D4A5570.60704@evision.ag>
Date: Fri, 02 Aug 2002 11:48:32 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: martin@dalecki.de, linux-kernel@vger.kernel.org, dhinds@zen.stanford.edu
Subject: Re: Patch: linux-2.5.30: return hd_driveid to <linux/hdreg.h>
References: <20020801211436.A11035@adam.yggdrasil.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Adam J. Richter napisa³:
> 	IDE-108 moved struct hd_driveid from linux/hdreg.h to
> linux/ide.h.  However, user level code in pcmcia-cs-3.2.0/cardmgr/ide-info.c
> refers to hd_driveid, and including <linux/ide.h> results in a flood
> of conflicts with GNU C library headers.
> 
> 	The following patch returns struct hd_driveid to include/linux/hdreg.h
> and changes its u{8,16,32,64} references to __u{8,16,32,64} (which are
> types that the linux include files export for user level programs).
> 
> 	I have rebuilt the core kernel, drivers/{ide,scsi} and
> pcmcia-cs-3.2.0 with this change.  It fixes the pcmcia-cs-3.2.0
> compilation problems and does not appear to cause any new compilation
> errors in the kernel.

Please don't. This structure is not a property of the Linux kernel.
This struture is something which should simply be redeclared in 
pcmcia-cs and handled there. It is a "bug" on behalf of pcmcia-cs to
rely on the fact that accidentally some random kernel header
is daclaring it as well.


