Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267118AbTBPQL0>; Sun, 16 Feb 2003 11:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267120AbTBPQLZ>; Sun, 16 Feb 2003 11:11:25 -0500
Received: from node-c-58b2.a2000.nl ([62.194.88.178]:1920 "EHLO
	wsprwl.xs4all.nl") by vger.kernel.org with ESMTP id <S267118AbTBPQLY>;
	Sun, 16 Feb 2003 11:11:24 -0500
Message-ID: <3E4FBA7B.8010808@xs4all.nl>
Date: Sun, 16 Feb 2003 17:21:15 +0100
From: Ruud Linders <rkmp@xs4all.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Kai.Makisara@kolumbus.fi
Subject: Re: SCSI Tape hangs when no tape loaded (2.5.6x)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kai,

That did it !

I was running mt-st-0.5b, upgrading to 0.7 fixed the 'mt' command as
well as the 'stinit' command which caused my boot to delay for 2 minutes
as that was called from the boot scripts.

THanks
 >On Sun, 16 Feb 2003, Ruud Linders wrote:
 >
 >>
 >>
 >> On both 2.5.60 and 2.5.61 when there is no tape loaded in my SCSI DAT
 >> tape drive, access to the drive blocks for exactly 2 minutes
 >> before timing out and giving an I/O error.
 >>
 >> # mt stat
 >> ....... < 2 minutes later > ...
 >> /dev/tape: Input/output error
 >>
 >Does you mt open the tape device with the O_NONBLOCK option? If not, this
 >is what is expected. mt-st version >= 0.6 does use this option. I don't
 >know about other mt's.
 >
 >The open() behaviour of st was changed at 2.5.3 to conform with SUS
 >(blocking) and what the other Unices do (timeout). If the device is opened
 >without O_NONBLOCK, the driver waits for some time (default 2 minutes) for
 >the device to become ready. If it does not become ready, an error is 
returned.
 >
 >	Kai
 >
 >P.S. I just tested 2.5.61 and in my system 'mt status' without tape in
 >the drive works as expected (i.e., prints status immediately).
 >

