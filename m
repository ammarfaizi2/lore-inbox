Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbUKBVrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbUKBVrv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 16:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbUKBVru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 16:47:50 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:37285 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261807AbUKBVmz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 16:42:55 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Jack Steiner <steiner@sgi.com>
Subject: Re: contention on profile_lock
Date: Tue, 2 Nov 2004 13:42:36 -0800
User-Agent: KMail/1.7
Cc: wli@holomorphy.com, linux-kernel@vger.kernel.org, edwardsg@sgi.com
References: <200411021152.16038.jbarnes@engr.sgi.com> <20041102200222.GA5135@sgi.com>
In-Reply-To: <20041102200222.GA5135@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411021342.36918.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, November 2, 2004 12:02 pm, Jack Steiner wrote:
> On Tue, Nov 02, 2004 at 11:52:15AM -0800, Jesse Barnes wrote:
> > Hmm, the last patch you sent me worked ok, so I'm not sure why we're
> > seeing problems with profiling now.  There seems to be very heavy
> > contention on profile_lock since profile_hook is called unconditionally
> > every timer tick. Should it only be called if profiling is enabled?  Is
> > there a way we can check the notifier list to see if it's empty before
> > calling it or something? The only user appears to be oprofile timer based
> > profiling, so in the general case we're taking the profile_lock and not
> > doing anything.
> >
> > Thanks,
> > Jesse
>
> Calling profile_hook() only if the notifier list is non-empty seems like a
> good step but I don't think that is the complete fix. We need to be able to
> enable profiling without killing performance.

Agreed.  Dipankar already suggested RCUifying the notifier list, but another 
option would be to simply check to see if oprofile timer based profiling is 
enabled since it seems to be the only user.  That would turn a lock into a 
read-mostly variable at least.

Jesse
