Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132567AbRDXQr7>; Tue, 24 Apr 2001 12:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132808AbRDXQrk>; Tue, 24 Apr 2001 12:47:40 -0400
Received: from theseus.mathematik.uni-ulm.de ([134.60.166.2]:45800 "HELO
	theseus.mathematik.uni-ulm.de") by vger.kernel.org with SMTP
	id <S132416AbRDXQrY>; Tue, 24 Apr 2001 12:47:24 -0400
Message-ID: <20010424164721.3598.qmail@theseus.mathematik.uni-ulm.de>
From: "Christian Ehrhardt" <ehrhardt@mathematik.uni-ulm.de>
Date: Tue, 24 Apr 2001 18:47:21 +0200
To: Victor Zandy <zandy@cs.wisc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: Global FPU corruption in 2.2
In-Reply-To: <cpxu23etpmc.fsf@goat.cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <cpxu23etpmc.fsf@goat.cs.wisc.edu>; from zandy@cs.wisc.edu on Tue, Apr 24, 2001 at 08:05:15AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2001 at 08:05:15AM -0500, Victor Zandy wrote:
> 
> He found that PF_USEDFPU was always set before the machine was broken.
> After he found that it was set about 70% of the time.

If I'm not mistaken this actully can cause GLOBAL FPU corruption.
Here's why:

Assyme for a moment that we lose either the PF_USEDFPU flag of one
process. This not only means that the current process won't have its
state saved, it also means that the next process won't have the TS bit
set. This in turn means that this new process won't get PF_USEDFPU set
and suddenly we have a second process with a corrupted FPU state.

Victor: Could you try to reproduce the system wide corruption if you
add an explicit call to stts(); at the very end of __switch_to?
This should prevent the FPU corruption from spreading.

NOTE: This is just to prove my theory, it is not and isn't meant
to be a fix for the actual problem.

   regards   Christian Ehrhardt

-- 

THAT'S ALL FOLKS!
