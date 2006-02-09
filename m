Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932596AbWBIRWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932596AbWBIRWE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 12:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932532AbWBIRWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 12:22:04 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:26592 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S965253AbWBIRWC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 12:22:02 -0500
Date: Thu, 9 Feb 2006 18:21:58 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: 7eggert@gmx.de
cc: John Schmerge <schmerge@speakeasy.net>, linux-kernel@vger.kernel.org
Subject: Re: Question regarding /proc/<pid>/fd and pipes
In-Reply-To: <E1F6qZR-0002uc-Kc@be1.lrz>
Message-ID: <Pine.LNX.4.61.0602091818080.30108@yvahk01.tjqt.qr>
References: <5DRW7-322-1@gated-at.bofh.it> <E1F6qZR-0002uc-Kc@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>>   I know that the symlinks in the /proc/<pid>/fd directory point to
>> bogus filenames for pipes (i.e. 'pipe:[64682]') and am wondering if
>> every process that reads and writes from that pipe will share the same
>> bogus symlink name.
>

It is not really bogus. And it is not really real at the same time.
This is how it works AFAIU: pipes get created in pipefs (cat 
/proc/filesystems) (as do sockets in sockfs), and their dentry IS named 
"pipe:[46682]". You just can't see it because 1. you are prevented from 
mounting pipefs, 2. there are no readdir/etc. functions for pipefs 
implemented ATM.

>>   In essence, I'm wondering if there's any way to list all of the pid's
>> of processes using an anonomous pipe.
>
Hm. Do you mean list "all pids of procs using an anynymous pipe" or
"list all pids [...]" using an anonymous pipe... :)

AFAICS, the first is not possible; the latter is (a fork-and-exec 
thing) is something different.


Jan Engelhardt
-- 
