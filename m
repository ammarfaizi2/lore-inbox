Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262382AbSI2Dlw>; Sat, 28 Sep 2002 23:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262383AbSI2Dlw>; Sat, 28 Sep 2002 23:41:52 -0400
Received: from packet.digeo.com ([12.110.80.53]:27040 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262382AbSI2Dlw>;
	Sat, 28 Sep 2002 23:41:52 -0400
Message-ID: <3D9677BA.110E5AB3@digeo.com>
Date: Sat, 28 Sep 2002 20:47:06 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.38 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: John Levon <levon@movementarian.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] oprofile for 2.5.39
References: <20020929014440.GA66796@compsoc.man.ac.uk.suse.lists.linux.kernel> <p737kh5sf45.fsf@oldwotan.suse.de> <20020929025224.GA68153@compsoc.man.ac.uk> <20020929050807.A17869@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Sep 2002 03:47:07.0374 (UTC) FILETIME=[E1E300E0:01C2676A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> smp_processor_id

Using smp_processor_id() is usually a bug.

Please default to using get_cpu()/put_cpu().

- It pins the caller onto that CPU if the kernel is preemptive.

- You may not sleep inside get_cpu/put_cpu.  

- If you do something which might sleep inside get_cpu/put_cpu,
  you get might_sleep() warnings.

Probably, smp_processor_id() needs to be renamed to something
which is hard to type.
