Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261615AbVAXUUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbVAXUUt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 15:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbVAXUTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 15:19:45 -0500
Received: from cantva.canterbury.ac.nz ([132.181.2.27]:8207 "EHLO
	cantva.canterbury.ac.nz") by vger.kernel.org with ESMTP
	id S261615AbVAXUQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 15:16:15 -0500
Date: Tue, 25 Jan 2005 09:15:43 +1300 (NZDT)
From: Dave van Leeuwen <dave@elec.canterbury.ac.nz>
Subject: Re: [NFS] [BUG] Onboard Ethernet Pro 100 on a SMP box: a very strange
 errors
In-reply-to: <20050122014646.A1038@natasha.ward.six>
To: Denis Zaitsev <zzz@anda.ru>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       nfs@lists.sourceforge.net
Message-id: <Pine.SOL.4.21.0501250910340.14951-100000@lupus.elec.canterbury.ac.nz>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Denis,
I bought a Intel STL2 mobo based machine a few years ago. I'm not sure
what the network controller on it is, as it is turned off.  I had a
problem where the card works fine until it gets loaded.  Then things went
pear shaped.  There was a bios upgrade to fix this problem.  I never
installed the bios patch as I had spare network cards.
You may find that you are just reaching the point where the card fails to
work correctly.

Hope this helps,
Dave. 

Dave van Leeuwen
Analyst Programmer
University of Canterbury
New Zealand

On Sat, 22 Jan 2005, Denis Zaitsev wrote:

> The long story is:
> 
> There is a Dual-processor Intel Server Board STL2 with two P-III/800
> and an onboard Intel 82557-based ethernet card.  The box has all the
> /usr and nearly all of the /var filesystems mounted over NFS.  And the
> box works for months without any problems around the NFS.  So, I think
> that the ethernet card just works fine.
> 
> But I have some enigmatic problems when I copying _some_ files from an
> NFS to the local fs: the process is freezes on the middle.
> 
> 1) Only _some_ files can't be copied.  There are:
> 
>    gcc-testsuite-3.4-20041217.tar.bz2
> 
>    krb5-1.3.6-signed.tar
> 
>    X430src-1.tgz
> 
>    They are the well-known sources from the well-known ftp and web
>    places.  And I don't think that it's the full list, just the files
>    for which I have met the problem.
> 
> 2) Only _these_ files can't be copied.  Any other is copied plainly.
> 
> 3) These files _never_ can be copied.
> 
> 4) The copy process always freezes at the same place (per file - the
>    each file has its own place).
> 
> In short: it's a list of files, on which the copying is always freezes
> and always freezes exactly the same way.  And there are no any
> exception - I have freezeng each time.
> 
> The freezing is forever.  The freezed process is in D state, its
> /proc/PID/wchan contains page_sync.  Each such process eats 1.0 from
> /proc/loadavg.  And the process can't be killed by any signal.
> 
> Then, copying by dd bs=1024 ... just succeeds.  After that cp succeeds
> too - I think it's because of caching.
> 
> Then, there is no visual correlation with the size of the file.  So,
> it seems that the content of the file is involved...  But it is
> enigmatic.
> 
> The NIC works fine all the other time, so there no suspicions about
> hardware problems.
> 
> The other NIC - 3C905 PCI external card doesn't show the problem - all
> the files are just copied.
> 
> An either driver for Ethernet Pro 100 - e100 or eepro100 - show the
> same result, but eepro100 logs periodicaly:
> 
>         eth0: wait_for_cmd_done timeout!
> 
> e100 logs nothing.
> 
> So, it doesn't ever look like a driver bug...
> 
> The kernels tested: 2.6.8.1, 2.6.9, 2.6.10.
> 
> GLIBC used: 2.3.2.
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
> Tool for open source databases. Create drag-&-drop reports. Save time
> by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
> Download a FREE copy at http://www.intelliview.com/go/osdn_nl
> _______________________________________________
> NFS maillist  -  NFS@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/nfs
> 

