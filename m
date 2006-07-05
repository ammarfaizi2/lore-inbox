Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbWGEMKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbWGEMKN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 08:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbWGEMKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 08:10:13 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:61188 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S964812AbWGEMKL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 08:10:11 -0400
Message-ID: <44ABAC20.5090902@argo.co.il>
Date: Wed, 05 Jul 2006 15:10:08 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Helge Hafting <helgehaf@aitel.hist.no>, Neil Brown <neilb@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, Tomasz Torcz <zdzichu@irc.pl>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       "Theodore Ts'o" <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features (checksums)
References: <44ABAA0E.4000907@tmr.com>
In-Reply-To: <44ABAA0E.4000907@tmr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Jul 2006 12:10:09.0397 (UTC) FILETIME=[F5C47A50:01C6A02B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
>
>
> > Not syncing unused area is possible, if there was a way for raid resync
> > to ask the fs what blocks are not in use.  I.e. get the
> > free block list in disk block order.  Then raid resync could skip 
> those.
> >
> Current RAID code supports having a bitmap of dirty stripes, and can
> just sync those during recovery. I'm sure Neil could explain it better,
> but this is available without worrying about fs type. Now. Today.
>

This is only when the you reconstruct a disk that was once part of the 
RAID.  If you are adding a brand new disk, all stripes are dirty.

This happens in two scenarios: an unclean RAID shutdown, and when you 
have a remote mirror which can be disconnected by network problems.

If the RAID is integrated in the filesystem (or into an object storage 
system), you can handle the new disk case too.

-- 
error compiling committee.c: too many arguments to function

