Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316538AbSFPTYo>; Sun, 16 Jun 2002 15:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316533AbSFPTYn>; Sun, 16 Jun 2002 15:24:43 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:49420 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S316532AbSFPTYm>;
	Sun, 16 Jun 2002 15:24:42 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200206161924.g5GJOYN515160@saturn.cs.uml.edu>
Subject: Re: /proc/scsi/map
To: garloff@suse.de (Kurt Garloff)
Date: Sun, 16 Jun 2002 15:24:33 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org (Linux kernel list),
       linux-scsi@vger.kernel.org (Linux SCSI list)
In-Reply-To: <20020615133606.GC11016@gum01m.etpnet.phys.tue.nl> from "Kurt Garloff" at Jun 15, 2002 03:36:06 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kurt Garloff writes:
> garloff@pckurt:/raid5/Kernel/src $ cat /proc/scsi/map
> # C,B,T,U       Type    onl     sg_nm   sg_dev  nm      dev(hex)
> 0,0,00,00       0x05    1       sg0     c:15:00 sr0     b:0b:00
> 1,0,01,00       0x05    1       sg1     c:15:01 sr1     b:0b:01
> 1,0,02,00       0x01    1       sg2     c:15:02 osst0   c:ce:00
> 1,0,03,00       0x05    1       sg3     c:15:03 sr2     b:0b:02
> 1,0,05,00       0x00    1       sg4     c:15:04 sda     b:08:00
> 1,0,09,00       0x00    1       sg5     c:15:05 sdb     b:08:10
> 2,0,01,00       0x05    1       sg6     c:15:06 sr3     b:0b:03
> 2,0,02,00       0x01    1       sg7     c:15:07 osst1   c:ce:01
> 2,0,03,00       0x05    1       sg8     c:15:08 sr4     b:0b:04
> 2,0,05,00       0x00    1       sg9     c:15:09 sdc     b:08:20
> 2,0,09,00       0x00    1       sg10    c:15:0a sdd     b:08:30
> 3,0,10,00       0x00    1       sg11    c:15:0b sde     b:08:40
> 3,0,12,00       0x00    1       sg12    c:15:0c sdf     b:08:50
>
> This allows a simple script to parse the map and create device
> nodes as needed.
...
> Obviously, it can only report the assignment of high-level drivers,
> if they are loaded, otherwise the last two columns will stay empty.
> (sg is handled especially, as we know it supports all devices.)
> If we attach a third high-level device driver, two more columns
> would show up. (Is this variable column number format a problem?)

The variable column format is of course annoying, but use
it if you must. The also-annoying alternative is to pick
a fill character that would be easy for a beginner to
handle in a script. Maybe one of:  @ - . / ?

The header line is far worse. It's too terse to be very helpful.
It gets in the way of every person writing a parser. Even in
your example script, you had to hack your way around it:

> +while read cbtu tp onl sgnm sgdev othnm othdev oothnm oothdev rest; do
> +  # Skip comment line(s)
> +  if test "${cbtu:0:1}" = "#"; then continue; fi
> +  # If we're just dealing with one device, do skip the others
> +  if test ! -z "$CMPAGAINST" -a "$CMPAGAINST" != "$cbtu"; then continue;
>  fi
