Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292557AbSCDRhy>; Mon, 4 Mar 2002 12:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292589AbSCDRgf>; Mon, 4 Mar 2002 12:36:35 -0500
Received: from host194.steeleye.com ([216.33.1.194]:62988 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S292599AbSCDRfc>; Mon, 4 Mar 2002 12:35:32 -0500
Message-Id: <200203041735.g24HZOu09098@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3) 
In-Reply-To: Message from "Stephen C. Tweedie" <sct@redhat.com> 
   of "Mon, 04 Mar 2002 17:04:34 GMT." <20020304170434.B1444@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 04 Mar 2002 11:35:24 -0600
From: James Bottomley <James.Bottomley@SteelEye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sct@redhat.com said:
> Generally, that may be true but it's irrelevant.  Internally, the fs
> may keep transactions as independent, but as soon as IO is scheduled,
> those transactions become serialised.  Given that pure sequential IO
> is so much more efficient than random IO, we usually expect
> performance to be improved, not degraded, by such serialisation. 

This is the part I'm struggling with.  Even without error handling and certain 
other changes that would have to be made to give guaranteed integrity to the 
tag ordering, Chris' patch is a very reasonable experimental model of how an 
optimal system for implementing write barriers via ordered tags would work; 
yet when he benchmarks, he sees a performance decrease.

I can dismiss his results as being due to firmware problems with his drives 
making them behave non-optimally for ordered tags, but I really would like to 
see evidence that someone somewhere acutally sees a performance boost with 
Chris' patch.

Have there been any published comparisons of a write barrier implementation 
verses something like the McKusick soft update idea, or even just 
multi-threaded back end completion of the transactions?

James


