Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261795AbVAMWlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbVAMWlf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 17:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbVAMWhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 17:37:34 -0500
Received: from pastinakel.tue.nl ([131.155.2.7]:32521 "EHLO pastinakel.tue.nl")
	by vger.kernel.org with ESMTP id S261795AbVAMWem (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 17:34:42 -0500
Date: Thu, 13 Jan 2005 23:34:37 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, "Theodore Y. Ts'o" <tytso@MIT.EDU>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] random periodicity detection fix
Message-ID: <20050113223437.GH2760@pclin040.win.tue.nl>
References: <20050113064629.GZ2940@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050113064629.GZ2940@waste.org>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: SINECTIS: pastinakel.tue.nl 1114; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 10:46:29PM -0800, Matt Mackall wrote:

> The input layer is now sending us a bunch of events in a row for each
> actual event. This shows up weaknesses in the periodicity detector and
> using the high clock rate from get_clock: each keystroke is getting
> accounted as 10 different tmaximal-entropy events.
> 
> A brief touch on a trackpad will generate as much as 2000 maximal
> entropy events which is more than 2k of /dev/random output. IOW, we're
> WAY overestimating input entropy.

Yes, indeed. I muttered about this long ago - let me see, yes,
http://marc.theaimsgroup.com/?l=linux-kernel&m=106271659930542&w=3

My patch did the opposite of your patch: I removed the
add entropy call in input.c.

I don't recall the details, but I think my reason was that some events
are synthetic, and I wanted all entropy calls to be derived from
actual outside sources.

Also, when there are several sources, all constant or almost constant,
then merging the streams might cause one to see variation where
there isn't really any.
Also that is a reason not to do the adding so far away from the source.

Andries
