Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760572AbWLFMyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760572AbWLFMyQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 07:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760574AbWLFMyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 07:54:16 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:47184 "EHLO scrub.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760572AbWLFMyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 07:54:15 -0500
Date: Wed, 6 Dec 2006 13:54:07 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Thomas Gleixner <tglx@linutronix.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: -mm merge plans for 2.6.20
In-Reply-To: <1165393929.24604.222.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0612061334230.1867@scrub.home>
References: <20061204204024.2401148d.akpm@osdl.org> 
 <Pine.LNX.4.64.0612060348150.1868@scrub.home>  <20061205203013.7073cb38.akpm@osdl.org>
 <1165393929.24604.222.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 6 Dec 2006, Thomas Gleixner wrote:

> If I understand it correctly, Roman wants clockevents to be usable for
> other things aside hrtimer/dyntick, i.e. let other code request unused
> timer event hardware for special purposes. I thought about that in the
> originally but I stayed away from it, as there are no users at the
> moment and I wanted to avoid the usual "who needs that" comment.

Nonsense, one obvious user would be the scheduler, the current scheduler 
tick emulation is rather ugly and sort of explains why you need the 
special wakeup logic I saw in previous versions.
The scheduler should be completely separate from hrtimer, in the long term 
they might optionally not even use the same clock source (e.g. the 
scheduler would use a low resolution, but fast clock, while posix timer 
whould use the high resolution timer).

bye, Roman
