Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267340AbSLKWug>; Wed, 11 Dec 2002 17:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267345AbSLKWug>; Wed, 11 Dec 2002 17:50:36 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:55063 "EHLO
	flossy.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267340AbSLKWuf>; Wed, 11 Dec 2002 17:50:35 -0500
Date: Wed, 11 Dec 2002 17:59:28 -0500
From: Doug Ledford <dledford@redhat.com>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.50 - sound driver issues with i810_audio
Message-ID: <20021211225928.GC6513@redhat.com>
Mail-Followup-To: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
References: <200212092124.gB9LOL3J007516@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212092124.gB9LOL3J007516@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2002 at 04:24:21PM -0500, Valdis.Kletnieks@vt.edu wrote:
> a female voice saying "New mail from I B M I-source List Server".  When I
> play it, "New mail from" is almost always OK, sometimes all of it is OK, and
> usually it loses it about halfway through.  What comes out sounds like:
> 
> New Mail from I B I-sour<M>ce <distorted>list server  st server"
> 
> Yes, it sounds like it's taking about half the frames and delaying them a chunk

This sounds like the problem some chipsets had with wrapping counters in 
the dma pointer read code.  Basically, when the sg segment is advanced to 
the next segment, the offset counter would not be simultaneously cleared 
but instead would be momentarily delayed before the clear occured and a 
read at just the wrong time could result in us thinking that the buffer 
was a full sg segment farther than it was.  There were changes made to the 
oss i810 driver around version 0.18 to solve this problem if I remember 
correctly.  Similar code may be needed in the alsa driver, I'm not sure 
because I have looked at it or tried it (my machine with an i810 doesn't 
run 2.5 kernels).



-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
