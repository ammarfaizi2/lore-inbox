Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277260AbRJDWxl>; Thu, 4 Oct 2001 18:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277261AbRJDWxb>; Thu, 4 Oct 2001 18:53:31 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:33446 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S277260AbRJDWxM>; Thu, 4 Oct 2001 18:53:12 -0400
Date: Thu, 4 Oct 2001 18:53:41 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Context switch times
Message-ID: <20011004185340.D18528@redhat.com>
In-Reply-To: <E15pFor-0004sC-00@fenrus.demon.nl> <200110042139.f94Ld5r09675@vindaloo.ras.ucalgary.ca> <20011004.145239.62666846.davem@redhat.com> <20011004175526.C18528@redhat.com> <9piokt$8v9$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9piokt$8v9$1@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Oct 04, 2001 at 10:42:37PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2001 at 10:42:37PM +0000, Linus Torvalds wrote:
> Could we try to hit just two? Probably, but it doesn't really matter,
> though: to make the lmbench scheduler benchmark go at full speed, you
> want to limit it to _one_ CPU, which is not sensible in real-life
> situations.  The amount of concurrency in the context switching
> benchmark is pretty small, and does not make up for bouncing the locks
> etc between CPU's. 

I don't quite agree with you that it doesn't matter.  A lot of tests 
(volanomark, other silly things) show that the current scheduler jumps 
processes from CPU to CPU on SMP boxes far too easily, in addition to the 
lengthy duration of run queue processing when loaded down.  Yes, these 
applications are leaving too many runnable processes around, but that's 
the way some large app server loads behave.  And right now it makes linux 
look bad compared to other OSes.

Yes, low latency is good, but jumping around cpus adds more latency in 
cache misses across slow busses than is needed when the working set is 
already present in the 2MB L2 of your high end server.

		-ben
