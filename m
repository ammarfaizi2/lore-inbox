Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318883AbSICTF2>; Tue, 3 Sep 2002 15:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318886AbSICTF2>; Tue, 3 Sep 2002 15:05:28 -0400
Received: from host194.steeleye.com ([216.33.1.194]:65038 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S318883AbSICTF0>; Tue, 3 Sep 2002 15:05:26 -0400
Message-Id: <200209031909.g83J9iG07312@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: James Bottomley <James.Bottomley@SteelEye.com>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: aic7xxx sets CDR offline, how to reset? 
In-Reply-To: Message from Doug Ledford <dledford@redhat.com> 
   of "Tue, 03 Sep 2002 14:23:53 EDT." <20020903142353.A12157@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 03 Sep 2002 14:09:44 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dledford@redhat.com said:
> Leave abort active.  It does actually work in certain scenarios.  The
> CD  burner scenario that started this thread is an example of
> somewhere that  an abort should actually do the job. 

Unfortunately, it would destroy the REQ_BARRIER approach in the block layer.  
At best, abort probably causes a command to overtake a barrier it shouldn't, 
at worst we abort the ordered tag that is the barrier and transactional 
integrity is lost.

When error correction is needed, we have to return all the commands for that 
device to the block layer so that ordering and barrier issues can be taken 
care of in the reissue.  This makes LUN RESET (for those that support it) the 
minimum level of error correction we can apply.

James


