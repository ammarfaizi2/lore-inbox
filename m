Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292652AbSCDS2p>; Mon, 4 Mar 2002 13:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292663AbSCDS2g>; Mon, 4 Mar 2002 13:28:36 -0500
Received: from host194.steeleye.com ([216.33.1.194]:50189 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S292654AbSCDS2Z>; Mon, 4 Mar 2002 13:28:25 -0500
Message-Id: <200203041828.g24ISJo09358@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Chris Mason <mason@suse.com>,
        James Bottomley <James.Bottomley@SteelEye.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3) 
In-Reply-To: Message from "Stephen C. Tweedie" <sct@redhat.com> 
   of "Mon, 04 Mar 2002 18:05:37 GMT." <20020304180537.F1444@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 04 Mar 2002 12:28:19 -0600
From: James Bottomley <James.Bottomley@SteelEye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sct@redhat.com said:
> Also, as soon as we have journals on external devices, this whole
> thing changes entirely.  We still have to enforce the commit ordering
> in the journal, but we also still need the ordering between that
> commit and any subsequent writeback, and that obviousy can no longer
> be achieved via ordered tags if the two writes are happening on
> different devices. 

Yes, that's a killer: ordered tags aren't going to be able to enforce cross 
device write barriers.

There is one remaining curiosity I have, at least about the benchmarks: Since 
the linux elevator and tag queueing perform essentially similar function 
(except that the disk itself has a better notion of ordering because it knows 
its own geometry).  Might we get better performance by reducing the number of 
tags we allow the device to use, thus forcing the writes to remain longer in 
the linux elevator?

James


