Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266595AbUF3NHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266595AbUF3NHn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 09:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266663AbUF3NHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 09:07:43 -0400
Received: from cantor.suse.de ([195.135.220.2]:25733 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266595AbUF3NGN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 09:06:13 -0400
Date: Wed, 30 Jun 2004 15:02:48 +0200
From: Olaf Dabrunz <od@suse.de>
To: Timothy Miller <miller@techsource.com>
Cc: Pavel Machek <pavel@suse.cz>, alan <alan@clueserver.org>,
       "Fao, Sean" <Sean.Fao@dynextechnologies.com>,
       linux-kernel@vger.kernel.org, Amit Gud <gud@eth.net>
Subject: Re: Elastic Quota File System (EQFS)
Message-ID: <20040630130248.GC3614@suse.de>
Mail-Followup-To: Timothy Miller <miller@techsource.com>,
	Pavel Machek <pavel@suse.cz>, alan <alan@clueserver.org>,
	"Fao, Sean" <Sean.Fao@dynextechnologies.com>,
	linux-kernel@vger.kernel.org, Amit Gud <gud@eth.net>
References: <20040624220318.GE20649@elf.ucw.cz> <Pine.LNX.4.44.0406241544010.19187-100000@www.fnordora.org> <20040625001545.GI20649@elf.ucw.cz> <40DC62BD.3010607@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40DC62BD.3010607@techsource.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-Jun-04, Timothy Miller wrote:
> 
> I have a much simpler idea that both implements the EQFS and doesn't 
> touch the kernel.
> 
> Each user is given a quota which applies to their home directory.  (This 
> quota is not elastic and if everyone met their quota, everything would 
> fit.)  In addition, there is another directory or file system (could be 
> on the same disk or even the same partition) to which their quota 
> doesn't apply AT ALL.  Let's call this "scratch" space.
> 
> Periodically, a daemon checks the disk usage, and whenever the disk 
> usage approaches, say, 90%, its starts deleting the oldest files from 
> the scratch space until its gets below the watermark.
> 
> So anything in "/scratch/$USER/" is free to be deleted by the daemon.
> 
> BTW, they did something similar to this when I was in college (I 
> graduated in 1996), although they deleted from /scratch manually.

An easy setup for this is to put /home on a different filesystem than
/tmp, use quota on /home but leave quota off for /tmp. Then most Unix
systems can easily be configured to clean up /tmp periodically, and also
the user is easily aware of the nature of files in /tmp (i.e. they are
"elastic" in some sense).

My university was (and still is) using this setup on many servers.

-- 
Olaf Dabrunz (od/odabrunz), SUSE Linux AG, Nürnberg

