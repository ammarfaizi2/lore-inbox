Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbWDYS04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbWDYS04 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 14:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbWDYS04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 14:26:56 -0400
Received: from fw5.argo.co.il ([194.90.79.130]:50183 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S932273AbWDYS0z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 14:26:55 -0400
Message-ID: <444E69E7.7020808@argo.co.il>
Date: Tue, 25 Apr 2006 21:26:47 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: dtor_core@ameritech.net, Kyle Moffett <mrmacman_g4@mac.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ modules
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com> <1145911546.1635.54.camel@localhost.localdomain> <444D3D32.1010104@argo.co.il> <A6E165E4-8D43-4CF8-B48C-D4B0B28498FB@mac.com> <444DCAD2.4050906@argo.co.il> <9E05E1FA-BEC8-4FA8-811E-93CBAE4D47D5@mac.com> <444E524A.10906@argo.co.il> <d120d5000604251010kd56580fl37a0d244da1eaf45@mail.gmail.com> <444E5A3E.1020302@argo.co.il> <d120d5000604251028h67e552ccq7084986db6f1cdeb@mail.gmail.com> <444E61FD.7070408@argo.co.il> <200604251808.k3PI8Y06004736@turing-police.cc.vt.edu>
In-Reply-To: <200604251808.k3PI8Y06004736@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Apr 2006 18:26:53.0436 (UTC) FILETIME=[D37EDBC0:01C66895]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
>
> On Tue, 25 Apr 2006 20:53:01 +0300, Avi Kivity said:
>
> > Additionally, C++ guarantees that if an exception is thrown after
> > spin_lock() is called, then the spin_unlock() will also be called.
> > That's an interesting mechanism by itself.
>
> Gaak.  So let me get this straight - We lock something, then we hit
> an exception because something corrupted the lock.  Then we *unlock* it
> so more code can trip over it.
>
> Sometimes the correct semantic is to *leave it locked*.
>
C++ doesn't force *any* semantic on you. It gives you tools to implement 
the semantic you want. If you want the lock to remain unlocked, that is 
of course doable.

Most often (almost always), the cause of the exception is not random 
corruption, but an error (I/O error, out of memory, etc.) and you want 
to unlock the lock. C++ helps you get it right without writing tons of 
boilerplate code:

[avi@cleopatra linux]$ grep -r out.*: . | wc -l
10446

How many times you want it unlocked but it's left locked because of an 
obscure error path? When does 2.6.16.14 come out?

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

