Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263158AbTCLLy4>; Wed, 12 Mar 2003 06:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263160AbTCLLy4>; Wed, 12 Mar 2003 06:54:56 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:29614 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S263158AbTCLLyz>;
	Wed, 12 Mar 2003 06:54:55 -0500
Date: Wed, 12 Mar 2003 13:05:39 +0100
From: bert hubert <ahu@ds9a.nl>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hanna Linder <hannal@us.ibm.com>, Janet Morgan <janetmor@us.ibm.com>,
       Marius Aamodt Eriksen <marius@citi.umich.edu>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       Niels Provos <provos@citi.umich.edu>
Subject: Re: [patch, rfc] lt-epoll ( level triggered epoll ) ...
Message-ID: <20030312120539.GA25626@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Davide Libenzi <davidel@xmailserver.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Hanna Linder <hannal@us.ibm.com>, Janet Morgan <janetmor@us.ibm.com>,
	Marius Aamodt Eriksen <marius@citi.umich.edu>,
	Shailabh Nagar <nagar@watson.ibm.com>,
	Niels Provos <provos@citi.umich.edu>
References: <Pine.LNX.4.50.0303101139520.1922-100000@blue1.dev.mcafeelabs.com> <20030311093427.GA19658@outpost.ds9a.nl> <Pine.LNX.4.50.0303111015370.1855-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0303111015370.1855-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 11, 2003 at 10:20:38AM -0800, Davide Libenzi wrote:

> > Most programs will not abandon 'legacy' interfaces like poll and select and
> > will only want to offer epoll in addition. Right now that is hard to do.
> 
> I agree here. It took 15 minutes to port thttpd to LT epoll.

Having level ability will massively speed up epoll adoption. By the way, was
there a reason to go to edge in the first place? 

> I received a bunch of private emails ( ppl that are using ET epoll )
> asking me to have both behaviours. The code require no more than 10 lines
> of code to give both possibilities. We have two options in doing that :

Impressive. 

> We add a parameter to epoll_create() that will set the interface behaviour
> at creation time :
...
> We can go at fd granularity by leaving the API the same, and we define :
> 	#define EPOLLET (1 << 31)

This last option would retain the current ABI *and* semantics for unchanged
programs. I do wonder if there is a case where you'd want to run in mixed
mode, however. But if the code to support mixed operation is truly trivial,
I think we should not set policy from the kernel ('only do epoll in one
mode') and leave it up to userspace to discover if there is a use for this.

Anyhow, as a member of the kCowSay [1] association of userspace people
meddling in the affairs of kernel coders, I vote strongly for having level
triggered epoll on the kernel, with the ability to do mixed mode.

Regards,

bert

[1] Founded by John Levon on the assumption that kernel coders assume all
    userspace code to be trivial, so we should have a massively trivial
    name. kCowSay tries to educate kernel deities about the needs of us
    userspace dwellers.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
http://netherlabs.nl                         Consulting
