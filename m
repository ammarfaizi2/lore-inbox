Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbUKBUMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbUKBUMJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 15:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbUKBUGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 15:06:19 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:54668 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261524AbUKBUCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 15:02:31 -0500
Date: Tue, 2 Nov 2004 14:02:22 -0600
From: Jack Steiner <steiner@sgi.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: wli@holomorphy.org, linux-kernel@vger.kernel.org, edwardsg@sgi.com
Subject: Re: contention on profile_lock
Message-ID: <20041102200222.GA5135@sgi.com>
References: <200411021152.16038.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411021152.16038.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2004 at 11:52:15AM -0800, Jesse Barnes wrote:
> Hmm, the last patch you sent me worked ok, so I'm not sure why we're seeing 
> problems with profiling now.  There seems to be very heavy contention on 
> profile_lock since profile_hook is called unconditionally every timer tick.  
> Should it only be called if profiling is enabled?  Is there a way we can 
> check the notifier list to see if it's empty before calling it or something?  
> The only user appears to be oprofile timer based profiling, so in the general 
> case we're taking the profile_lock and not doing anything.
> 
> Thanks,
> Jesse

Calling profile_hook() only if the notifier list is non-empty seems like a good
step but I don't think that is the complete fix. We need to be able to
enable profiling without killing performance.



-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.


