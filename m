Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261599AbTBKPLI>; Tue, 11 Feb 2003 10:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261463AbTBKPLI>; Tue, 11 Feb 2003 10:11:08 -0500
Received: from 12-237-214-24.client.attbi.com ([12.237.214.24]:45332 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S261996AbTBKPLA>;
	Tue, 11 Feb 2003 10:11:00 -0500
Message-ID: <3E4914CA.6070408@mvista.com>
Date: Tue, 11 Feb 2003 09:20:42 -0600
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021204
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: suparna@in.ibm.com
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
       Kenneth Sumrall <ken@mvista.com>, linux-kernel@vger.kernel.org,
       lkcd-devel@lists.sourceforge.net
Subject: Re: Kexec, DMA, and SMP
References: <3E448745.9040707@mvista.com> <m1isvuzjj2.fsf@frodo.biederman.org> <3E45661A.90401@mvista.com> <m1d6m1z4bk.fsf@frodo.biederman.org> <20030210174243.B11250@in.ibm.com> <m18ywoyq78.fsf@frodo.biederman.org> <20030211182508.A2936@in.ibm.com> <20030211191027.A2999@in.ibm.com> <3E490374.1060608@mvista.com> <20030211201029.A3148@in.ibm.com>
In-Reply-To: <20030211201029.A3148@in.ibm.com>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Suparna Bhattacharya wrote:

|On Tue, Feb 11, 2003 at 08:06:44AM -0600, Corey Minyard wrote:
|
|>|
|>|We could just reserve a memory area of reasonable size (how
|>|much ?) which would be used by the new kernel for all its
|>|allocations. We already have the infrastructure to tell the
|>|new kernel which memory areas not to use, so its simple
|>|enough to ask it exclude all but the reserved area.
|>|By issuing the i/o as early as possible during bootup
|>|(for lkcd all we need is the block device to be setup for
|>|i/o requests), we can minimize the amount of memory to
|>|reserve in this manner.
|>
|>DMA can occur almost anywhere.  If you restrict the area of DMA, that
|>means you have to copy the contents to the final destination.  I don't 
think
|>we want to do that in many cases.
|
|
|The scope here was just the case that Eric seemed to be
|trying to address, the way I understood it, and hence a much
|simpler subset of the problem at hand, since it is not really
|tackling the rouge/buggy cases. There is no restriction on
|where DMA can happen, just a block of memory area set aside
|for the dormant kernel to use when it is instantiated.
|So this is an area that the current kernel will not use or
|touch and not specify as a DMA target during "regular"
|operation.

You don't understand.  You don't *want* to set aside a block of memory 
that's
reserved for DMA.  You want to be able to DMA directly into any user 
address.
Consider demand paging.  The performance would suck if you DMA into some
fixed region then copied to the user address.  Plus you then have another
resource you have to manage in the kernel.  And you still have to change all
the drivers, buffer management, etc. to add a flag that says "I'm going 
to use
this for DMA" to allocations.  You might as well add the quiesce 
function, it's
probably easier to do.  And it doesn't help if you DMA to static memory
addresses.

I, too, would like a simpler solution.  I just don't think this is it.

- -Corey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+SRTJmUvlb4BhfF4RAg2ZAJ9R52BdasmLGTMI6GmX+2j0CeLXPwCfQzfE
wQYjBHmyCThURH2hjZ83wfE=
=kZiP
-----END PGP SIGNATURE-----


