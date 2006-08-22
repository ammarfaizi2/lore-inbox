Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbWHVUI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWHVUI0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 16:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWHVUI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 16:08:26 -0400
Received: from bayc1-pasmtp03.bayc1.hotmail.com ([65.54.191.163]:38000 "EHLO
	BAYC1-PASMTP03.CEZ.ICE") by vger.kernel.org with ESMTP
	id S1750993AbWHVUIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 16:08:25 -0400
Message-ID: <BAYC1-PASMTP03D3DD61899A6464D26765AE460@CEZ.ICE>
X-Originating-IP: [65.94.249.130]
X-Originating-Email: [seanlkml@sympatico.ca]
Date: Tue, 22 Aug 2006 16:08:22 -0400
From: Sean <seanlkml@sympatico.ca>
To: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
Cc: <git@vger.kernel.org>, "Patro, Sumant" <Sumant.Patro@engenio.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: HELP: GIT Cloning failed
Message-Id: <20060822160822.b112421a.seanlkml@sympatico.ca>
In-Reply-To: <890BF3111FB9484E9526987D912B261932E35B@NAMAIL3.ad.lsil.com>
References: <890BF3111FB9484E9526987D912B261932E35B@NAMAIL3.ad.lsil.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.10.1; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Aug 2006 20:08:24.0640 (UTC) FILETIME=[B94B1400:01C6C626]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2006 13:25:23 -0600
"Ju, Seokmann" <Seokmann.Ju@lsil.com> wrote:

Ju,

> Above script worked without any problem when I started several months
> ago and I'm not sure when did it stop working.
> I'm using _cron_ utility on my Linux box for scheduled execution of the
> script.
> 
> Any comment would be appreciated.

It looks like the jejb scsi-misc archive might not have been
configured properly for http transfers.  There's a script below
which just uses git commands (not cogito) and the native git
protocol which tests out okay here.

A few comments though:

 - Apparently the scsi misc tree you want is actually under "jejb"
   rather than "marcelo" which you had in your script.

 - It's better to use the native git protocol when possible
   (well, the benefits are less on initial clone, but it's still
   a good practice)

 - You're causing a lot of unnecessary traffic for kernel.org by
   cloning a fresh copy of all these trees, it would be much better
   to clone just _once_ and then simply "git pull" in any updates.

 - Two of the trees you're cloning are very close in content to
   each other (linux-2.6 & scsi-misc-2.6) so you can use the git
   "--reference" option to share local objects saving disk space
   (and reducing bandwidth needs even further)

Cheers,
Sean

#!/bin/sh
cd /home/git/kernels/2.4 || exit
BASE="git://www.kernel.org/pub/scm/linux/kernel/git"
rm -rf linux-2.4 linux-2.6 scsi-misc-2.6
git clone $BASE/marcelo/linux-2.4
git clone $BASE/torvalds/linux-2.6
git clone --reference linux-2.6 $BASE/jejb/scsi-misc-2.6



