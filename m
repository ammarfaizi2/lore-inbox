Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280758AbRKGDgS>; Tue, 6 Nov 2001 22:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280756AbRKGDgJ>; Tue, 6 Nov 2001 22:36:09 -0500
Received: from node1500a.a2000.nl ([24.132.80.10]:45232 "HELO mail.alinoe.com")
	by vger.kernel.org with SMTP id <S280754AbRKGDfz>;
	Tue, 6 Nov 2001 22:35:55 -0500
Date: Wed, 7 Nov 2001 04:35:54 +0100
From: Carlo Wood <carlo@alinoe.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [ircu-development] Slow on high-MTU (local host) connections?
Message-ID: <20011107043554.B15045@alinoe.com>
In-Reply-To: <87snbstzfz.fsf@sanosuke.troilus.org> <20011107041140.A12198@alinoe.com> <20011107042153.A13705@alinoe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011107042153.A13705@alinoe.com>; from carlo@alinoe.com on Wed, Nov 07, 2001 at 04:21:53AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The examples in the previous mail are from the case with MTU is 8000
(and were to only two occurances of a EAGAIN for read() actually).

Allow me show the statistics for both MTU's:

MTU 16436:

~>grep -B1 '\[srvx2\] select.*<0\.[1-9]' mtu16436 | grep '\[srvx2\] read' | wc --lines
    323
~>grep -B1 '\[srvx2\] select.*<0\.[1-9]' mtu16436 | grep '\[srvx2\] read.*EAGAIN' | wc --lines
    323

Conclusion: ALL calls to select() that took longer than 0.1 second
were following a call to read() that failed with EAGAIN.  In total 323 times.


MTU 8000:

~>grep -B1 '\[srvx2\] select.*<0\.[1-9]' mtu8000 | grep '\[srvx2\] read' | wc --lines
      2
~>grep -B1 '\[srvx2\] select.*<0\.[1-9]' mtu8000 | grep '\[srvx2\] read.*EAGAIN' | wc --lines
      2

Idem, but only two occurences.


The total number of calls to select in both are respectively:

~>grep '\[srvx2\] select.*' mtu16436 | wc --lines
   1221
~>grep '\[srvx2\] select.*' mtu8000 | wc --lines
   658

-- 
Carlo Wood <carlo@alinoe.com>

(Also forwarded because first I used a wrong address)
