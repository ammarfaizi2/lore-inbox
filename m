Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293590AbSCFOEe>; Wed, 6 Mar 2002 09:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293583AbSCFOEY>; Wed, 6 Mar 2002 09:04:24 -0500
Received: from dsl-213-023-039-135.arcor-ip.net ([213.23.39.135]:23978 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S293565AbSCFOEL>;
	Wed, 6 Mar 2002 09:04:11 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3)
Date: Wed, 6 Mar 2002 14:59:52 +0100
X-Mailer: KMail [version 1.3.2]
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
        Chris Mason <mason@suse.com>, "Stephen C. Tweedie" <sct@redhat.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <200203041448.g24EmGr01578@localhost.localdomain>
In-Reply-To: <200203041448.g24EmGr01578@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16ibxR-0002zI-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 4, 2002 03:48 pm, James Bottomley wrote:
> phillips@bonn-fries.net said:
> > I've been following the thread, I hope I haven't missed anything
> > fundamental. A better long term solution is to have ordered tags work
> > as designed.  It's  not broken by design is it, just implementation? 
> 
> There is actually one hole in the design:  A scsi device may accept a command 
> with an ordered tag, disconnect and at a later time reconnect and return a 
> QUEUE FULL status indicating that the tag must be retried.  In the time 
> between the disconnect and reconnect, the standard doesn't require that no 
> other tags be accepted, so if the local flow control conditions abate, the 
> device is allowed to accept and execute a tag sent down in between the 
> disconnect and reconnect.

How can a drive can accept a command while it is disconnected from the bus.
Did you mean that after it reconnects it might refuse the ordered tag and
accept another?  That would be a bug, I'd think.

> I think this would introduce a very minor deviation where one tag could 
> overtake another, but we may still get a useable implementation even with this.

It would mean we would have to wait for completion of the tagged command
before submitting any more commands.  Not nice, but not horribly costly
either.

-- 
Daniel
