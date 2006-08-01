Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932539AbWHAJii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539AbWHAJii (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 05:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932593AbWHAJii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 05:38:38 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:19206 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S932539AbWHAJih
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 05:38:37 -0400
Message-ID: <44CF2112.8040202@argo.co.il>
Date: Tue, 01 Aug 2006 12:38:26 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Matthias Andree <matthias.andree@gmx.de>
CC: Theodore Tso <tytso@mit.edu>, David Lang <dlang@digitalinsight.com>,
       David Masover <ninja@slaphack.com>, tdwebste2@yahoo.com,
       Nate Diller <nate.diller@gmail.com>,
       Adrian Ulrich <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, ipso@snappymail.ca,
       reiser@namesys.com, lkml@lpbproductions.com, jeff@garzik.org,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: Solaris ZFS on Linux [Was: Re: the " 'official' point of view"expressed
 by kernelnewbies.org regarding reiser4 inclusion]
References: <20060801092514.GB2974@merlin.emma.line.org>
In-Reply-To: <20060801092514.GB2974@merlin.emma.line.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Aug 2006 09:38:34.0752 (UTC) FILETIME=[42170800:01C6B54E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree wrote:
>
> On Tue, 01 Aug 2006, Avi Kivity wrote:
>
> > There's no reason to repack *all* of the data.  Many workloads write 
> and
> > delete whole files, so file data should be contiguous.  The repacker
> > would only need to move metadata and small files.
>
> Move small files? What for?
>

WAFL-style filesystems like contiguous space,  so if small files are 
scattered in otherwise free space, the repacker should free them.

> Even if it is "only" moving metadata, it is not different from what ext3
> or xfs are doing today (rewriting metadata from the intent log or block
> journal to the final location).
>

There is no need to repack all metadata; only that which helps in 
creating free space.

For example: if you untar a source tree you'd get mixed metadata and 
small file data packed together, but there's no need to repack that data.


-- 
error compiling committee.c: too many arguments to function

