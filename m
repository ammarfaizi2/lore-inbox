Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264856AbRFYQUz>; Mon, 25 Jun 2001 12:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264862AbRFYQUp>; Mon, 25 Jun 2001 12:20:45 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:60175 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S264856AbRFYQU3>;
	Mon, 25 Jun 2001 12:20:29 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5-ac12 kernel oops 
In-Reply-To: Your message of "Mon, 25 Jun 2001 09:02:19 MST."
             <20010625160219.84967784D9@mail.clouddancer.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 26 Jun 2001 02:20:23 +1000
Message-ID: <730.993486023@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jun 2001 09:02:19 -0700 (PDT), 
klink@clouddancer.com (Colonel) wrote:
>In clouddancer.list.kernel, Keith Owens wrote:
>>partition_name at c01aad00 and another at c014cba0.  Both
>>fs/partitions/msdos.c and drivers/md/md.c define that symbol, md
>
>and I have both in the kernel.
>Only the raid5 was active, the msdos stuff is a module for 'just in
>case'.  Something else triggered this, I've run raid for a long time
>without problems.

Both msdos and raid are in your kernel, msdos is not a module.

Don't be misled by ksymoops reporting duplicate symbols.  It reads the
entire symbol map and reports discrepancies as it does so, mainly to
pick up idiots who feed /proc/ksyms from 2.2 and System.map from 2.4.
Don't laugh, it happens!  Unless the trace shows raid or msdos are
implicated in the oops, you can ignore the ksymoops warning.

>>ksymoops has a hierarchy of trust.  System.map is more trustworthy than
>>/proc/ksyms because ksyms changes, especially if you rebooted after the
>>oops and before running ksymoops.
>
>Hmm, I would have thought that /proc was more up to date, because it
>would reflect changes.  No reboot, never even considered it (I've
>rescued too many junior sysadmins that think rebooting is _the_ answer).

/proc/ksyms is dynamic, it changes as modules are loaded and unloaded.
And often the oops is so bad that the machine is dead so reboot is the
only option, ksyms after reboot may be for a completely different
kernel.  If you want accurate ksyms and lsmod data to feed into
ksymoops, 'man insmod' and read section 'KSYMOOPS ASSISTANCE'.

