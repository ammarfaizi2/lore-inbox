Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751433AbWD1Sit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbWD1Sit (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 14:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751632AbWD1Sis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 14:38:48 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:39901 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751433AbWD1Sis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 14:38:48 -0400
Date: Sat, 29 Apr 2006 00:05:59 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Jay Lan <jlan@engr.sgi.com>
Cc: Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: [Patch 5/8] taskstats interface
Message-ID: <20060428183559.GB8349@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <444991EF.3080708@watson.ibm.com> <444996FB.8000103@watson.ibm.com> <44501A97.2060104@engr.sgi.com> <445041EB.7080205@watson.ibm.com> <20060427064237.GA14496@in.ibm.com> <445104DC.90401@engr.sgi.com> <20060427182719.GC14496@in.ibm.com> <44511CCF.1080504@engr.sgi.com> <20060428025927.GD14496@in.ibm.com> <44525CE5.3060800@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44525CE5.3060800@engr.sgi.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >Is this what you had in mind?
> >  
> No exactly. The payload information must be always available for
> application.
> 
> On a second thought, the idea of one big taskstats struct with many
> #ifconfig is not really a good idea. My goal is to cut down unnecessary
> data being transfered throught the socket.

Yes, so we agree that #ifdef CONFIG_* is not good.

> 
> Here is my Take 2. We can have a  taskstats header containing taskstats
> version and other general fields useful to more than one taskstats
> application including a payload information. Then, we define
> accounting subsystem specific structs for delayacct, csa, etc.
> The kernel/{delayacct.c,csa.c,etc.c} set the payload information and
> fill the buffer with desired subsystem structs. The header thus contain
> enough information to tell  applications how to map the data following
> the header.

I agree with this suggestion.

Each netlink attribute contains the following fields (also referred to as TLV)

+----+--------+------+
|Type| length | value|
+----+--------+------+

The type is meant to serve the purpose of the header you describe. The
type value can be used by the application to map the data. 
getdelays.c is a sample application posted in the previous patches,
it interprets data based on type.


> 
> Would IBM propose more accounting subsystems besides delayacct?
> If we only see delayacct and csa on the horizon, this scheme is really
> not necessary since delayacct does not have as much data (as csa :))
> and csa can use part of the delayacct data. You gain more than
> csa can benefit from this. ;-) I guess i just speak from design point
> of view. :)
> 
> But, if one day somebody who does not need a paycheck decides
> to convert BSD accounting to use taskstats interface, this can
> be helpful.
> 

Yes, I think in the long term it would be more useful to use the scheme
of adding subsystem structs. taskstats.txt explains the process of 
extending taskstats. Point #2 is the same as what we have just discussed.
Could you please see if the text needs any changes based on our discussions
so far (taskstats.txt was posted in the delayacct-doc.patch).

> Thanks,
>  - jay
> 
> 

-- 
					<---	Balbir
