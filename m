Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932940AbWFZTVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932940AbWFZTVe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 15:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932938AbWFZTVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 15:21:33 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:4236 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932937AbWFZTVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 15:21:32 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
Cc: <vgoyal@in.ibm.com>, "Maneesh Soni" <maneesh@in.ibm.com>,
       "Andrew Morton" <akpm@osdl.org>, <Neela.Kolli@engenio.com>,
       <linux-scsi@vger.kernel.org>, <fastboot@lists.osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] [RFC] [PATCH 2/2] kdump: cciss driver initialization issue fix
References: <E717642AF17E744CA95C070CA815AE550E163F@cceexc23.americas.cpqcorp.net>
Date: Mon, 26 Jun 2006 13:21:04 -0600
In-Reply-To: <E717642AF17E744CA95C070CA815AE550E163F@cceexc23.americas.cpqcorp.net>
	(Mike Miller's message of "Mon, 26 Jun 2006 13:51:43 -0500")
Message-ID: <m1veqnrae7.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Miller, Mike (OS Dev)" <Mike.Miller@hp.com> writes:

>> -----Original Message-----
>> From: Eric W. Biederman [mailto:ebiederm@xmission.com] 
>> Sent: Monday, June 26, 2006 12:52 PM
>> To: Miller, Mike (OS Dev)
>> Cc: vgoyal@in.ibm.com; Maneesh Soni; Andrew Morton; 
>> Neela.Kolli@engenio.com; linux-scsi@vger.kernel.org; 
>> fastboot@lists.osdl.org; linux-kernel@vger.kernel.org
>> Subject: Re: [Fastboot] [RFC] [PATCH 2/2] kdump: cciss driver 
>> initialization issue fix
>> 
>> "Miller, Mike (OS Dev)" <Mike.Miller@hp.com> writes:
>> 
>> > Thanks Eric, that helps me understand. Section 8.2.2 of the 
>> open cciss 
>> > spec supports a reset message. Target 0x00 is the 
>> controller. We could 
>> > add this to the init routine to ensure the board is made sane again 
>> > but this would drastically increase init time under normal 
>> circumstances.
>> 
>> Where does the init time penalty come from? How large is the 
>> init penalty?  I suspect it is from waiting for the scsi 
>> disks to spin up.
>> But I am just guessing in the dark.
>
> The penalty is in the firmware and self-test operations.

Ok.  Reasonable. Roughly long does that take? 1 millisecond? 1 second?
1 minute? 1 hour? 

>> > And I suspect this is a hard reset, also. Not sure if that would 
>> > negatively impact kdump. If there were some condition we could test 
>> > against and perform the reset when that condition is met it 
>> would not 
>> > impact 99.9% of users.
>> 
>> I am wondering if it is possible to look at the controller 
>> and see if it is in a bad state, (i.e. in some state besides 
>> just coming out of reset) and if so issue a reset.  If this 
>> really is a long operation that would be the ideal way to handle it.
>
> It's not really in a bad state at this time, is it? Maybe some commands
> hanging around.

Not bad as in broken.  But bad as in unexpected.  If it is just a matter
of outstanding commands we might even be able to just ask the adapter
to cancel all of the at initialization time.

>> If the amount of time is really user noticeable and testing 
>> for it is impossible then it is probably time to talk kernel 
>> command line options.
>
> I was informed of the crashboot command line parameter. I can implement
> that as a test.

Sounds like a start.

>> Although it might simply be appropriate to handle commands 
>> completing you didn't start.  I am not at all familiar with 
>> that particular piece of hardware so I can't make a good 
>> guess on what needs to happen there.
>
> Not sure about doing this.

Well I would certainly print a warning.

Eric

