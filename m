Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265543AbUFDCRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265543AbUFDCRI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 22:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265548AbUFDCRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 22:17:07 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:51779 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265543AbUFDCRC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 22:17:02 -0400
Date: Thu, 3 Jun 2004 19:25:18 -0700
From: Paul Jackson <pj@sgi.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de, greg@kroah.com
Subject: Re: [PATCH] fix sys cpumap for > 352 NR_CPUS
Message-Id: <20040603192518.2e21e6e4.pj@sgi.com>
In-Reply-To: <1086311544.7991.868.camel@bach>
References: <20040602161115.1340f698.pj@sgi.com>
	<1086222156.29391.337.camel@bach>
	<20040602212547.448c7cc7.pj@sgi.com>
	<1086243997.29390.527.camel@bach>
	<20040603012728.42713a30.pj@sgi.com>
	<1086311544.7991.868.camel@bach>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Honestly, I dislike the static check altogether ...

  The build time check was your idea in the first place, as I recall.
  I hadn't added it to my variants.  Apparently we agree not to add it.
  Ok.

> Because now you have silently truncated, which is much worse than

  I absolutely agree with your dislike of hidden intermittent failures.

  For a constant failure such as this, even if everyone misses the
  botch for the first few times that SGI boots a bazillion CPU system
  in the lab, it will get noticed soon enough.  This is in fact
  exactly what happened with the 99 char limit that was there now.

> 	len = cpumask_scnprintf(buf, PAGE_SIZE, mask);
> 	if (len == PAGE_SIZE)
> 		return -ENOMEM;

  That looks nice.

  If you want me to add the "if (len ..."  check, let me know.
  Or if you want to send Andrew a patch that adds it, I'll
  gladly support that.

  ==> Do note that I had to change the -1UL to PAGE_SIZE, in a
      patch to Andrew about 12 hours ago.  The *scnprintf()
      family of fine formatting functions suppresses all requested
      output if handed a length with the high bit set.

> That would be extremely unusual; we tend not to panic ...

  Yup - I think it was Greg who said the same thing.  Clearly this is
  not a panic.

  I was wrong to suggest panic'ing here.

> I'll do it; seems like we need negotiation with Greg-KH, too.

  Ok - have fun.

> I question anyone's ability to produce a perfectly balanced solution
> without any external input.

  Whatever ... my view of who was saying and doing what here doesn't
  entirely match yours.

  So be it.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
