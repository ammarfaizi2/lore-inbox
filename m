Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162074AbWKOXmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162074AbWKOXmZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 18:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162075AbWKOXmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 18:42:25 -0500
Received: from outbound-ash.frontbridge.com ([206.16.192.249]:61130 "EHLO
	outbound2-ash-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1162074AbWKOXmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 18:42:24 -0500
X-BigFish: VP
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
Date: Wed, 15 Nov 2006 16:44:56 -0700
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: "Andrew Morton" <akpm@osdl.org>
cc: "Tero Roponen" <teanropo@jyu.fi>, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: fb: modedb uses wrong default_mode
Message-ID: <20061115234456.GB3674@cosmic.amd.com>
References: <Pine.LNX.4.64.0611151933070.12799@jalava.cc.jyu.fi>
 <20061115152952.0e92c50d.akpm@osdl.org>
MIME-Version: 1.0
In-Reply-To: <20061115152952.0e92c50d.akpm@osdl.org>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 15 Nov 2006 23:42:20.0442 (UTC)
 FILETIME=[B123C7A0:01C7090F]
X-WSS-ID: 69457A560T0474539-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/06 15:29 -0800, Andrew Morton wrote:
> On Wed, 15 Nov 2006 19:43:16 +0200 (EET)
> Tero Roponen <teanropo@jyu.fi> wrote:
> 
> > 
> > It seems that default_mode is always overwritten in
> > fb_find_mode() if caller gives its own modedb; this
> > patch should fix it.

> Sigh.
> 
> 2.6.19-rc5 has:
> 
>     if (!default_mode)
> 	default_mode = &modedb[DEFAULT_MODEDB_INDEX];
> 
> and Jordan changed it to
> 
>     if (!default_mode && db != modedb)
> 	default_mode = &db[0];
>     else
> 	default_mode = &modedb[DEFAULT_MODEDB_INDEX];


> and you want to change it to
> 
>     if (!default_mode && db != modedb)
> 	default_mode = &db[0];
>     else if (!default_mode)
> 	default_mode = &modedb[DEFAULT_MODEDB_INDEX];
> 
> which is actually a complicated way of doing
> 
>     if (!default_mode)
> 	default_mode = &db[DEFAULT_MODEDB_INDEX];

Unless DEFAULT_MODEDB_INDEX for some reason gets set to non-zero, then
it could be dangerous. If we agree that the default entry should aways be 
at 0, then nuke the define and hard code the zero.  That way, nobody will be 
tempted to change it.

Jordan

-- 
Jordan Crouse
Senior Linux Engineer
Advanced Micro Devices, Inc.
<www.amd.com/embeddedprocessors>


