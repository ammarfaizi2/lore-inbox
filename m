Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbVCIPaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbVCIPaI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 10:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVCIPaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 10:30:08 -0500
Received: from sta.galis.org ([66.250.170.210]:60297 "HELO sta.galis.org")
	by vger.kernel.org with SMTP id S261609AbVCIPaA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 10:30:00 -0500
From: "George Georgalis" <george@galis.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
  users@spamassassin.apache.org,
  misc@list.smarden.org,
  supervision@list.skarnet.org,
  mkettler@evi-inc.com,
  nix@esperi.org.uk
Date: Wed, 9 Mar 2005 10:29:59 -0500
To: Nix <nix@esperi.org.uk>
Cc: linux-kernel@vger.kernel.org, users@spamassassin.apache.org,
       misc@list.smarden.org, supervision@list.skarnet.org,
       mkettler@evi-inc.com
Subject: Re: a problem with linux 2.6.11 and sa
Message-ID: <20050309152958.GB4042@ixeon.local>
References: <20050303214023.GD1251@ixeon.local> <6.2.1.2.0.20050303165334.038f32a0@192.168.50.2> <20050303224616.GA1428@ixeon.local> <871xaqb6o0.fsf@amaterasu.srvr.nix> <20050308165814.GA1936@ixeon.local> <871xap9dfg.fsf@amaterasu.srvr.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871xap9dfg.fsf@amaterasu.srvr.nix>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 01:06:11PM +0000, Nix wrote:

>> An interesting technique that allows a program (such as a log writer)
>> to run as an unprivileged user, while receiving privileged data. (taken
>> almost verbatim from Gerrit Pape's socklog)
>> 
>> #!/bin/sh
>> exec </proc/kmsg
>> exec 2>&1
>> exec softlimit -m 2000000 setuidgid nobody socklog ucspi
>> 
>> This script, run by root takes its stdin from /proc/kmsg then combines
>> its stdout and stderr, and exec-switches to the socklog program run
>> as an ucspi application listening to the domain stream socket, as
>> nobody:nogroup, with memory consumption limited to 2Mb. (and sends
>> log to stdout)
>
>This is definitely redirection, not piping. As far as I know the
>implementation of redirection in the kernel remains unchanged: certainly
>the need to buffer piped data doesn't exist in this case, and since the
>redesign was of the buffering, this is probably not your problem :)
>
>> It worked flawlessly until several kernel revs back when the kernel
>> started protecting kmsg and wouldn't allow the user program to receive
>> it,
>
>Indeed.
>
>>       result: nothing sent to the logging program and no error. The fix
>> was to run socklog as root instead of nobody.
>
>You should be able to open it as root and read from it as another user:
>i.e., your technique above shouldn't break. (I'd hope.)

Here is a nice proof that kmsg did become a problem around 2.6.0
http://article.gmane.org/gmane.comp.misc.pape.general/595
http://thread.gmane.org/gmane.comp.misc.pape.general/590


It (Gerrit Pape's technique) very defiantly stopped working a few revs
back (2.6.7?). I'm seeing a similar failed read from /dev/rtc and
mplayer with 2.6.10, now too.

http://lkml.org/lkml/2005/3/8/226

while read file; do mplayer $file ; done <mediafiles.txt

Failed to open /dev/rtc: Permission denied

for file in `cat mediafiles.txt`; do mplayer $file ; done

works.

// George

-- 
George Georgalis, systems architect, administrator Linux BSD IXOYE
http://galis.org/george/ cell:646-331-2027 mailto:george@galis.org
