Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316322AbSEQQVS>; Fri, 17 May 2002 12:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316326AbSEQQVR>; Fri, 17 May 2002 12:21:17 -0400
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:22956 "EHLO
	stout.engsoc.carleton.ca") by vger.kernel.org with ESMTP
	id <S316322AbSEQQVQ>; Fri, 17 May 2002 12:21:16 -0400
Date: Fri, 17 May 2002 12:21:00 -0400 (EDT)
From: Paul Faure <paul@engsoc.org>
X-X-Sender: <paul@lager.engsoc.carleton.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andrew Morton <akpm@zip.com.au>, Andrea Arcangeli <andrea@suse.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Process priority in 2.4.18 (RedHat 7.3)
In-Reply-To: <E178hAf-0006PS-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0205171215560.31871-100000@lager.engsoc.carleton.ca>
X-Home-Page: http://www.engsoc.org/
X-URL: http://www.engsoc.org/
Organisation: Engsoc Project (www.engsoc.org)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A little more information:

On a dual system:
Running as root -> Single process app (50% total CPU)-> locks out network
Running as root -> Multi process app (100% total CPU) -> locks out network
Running unprivileged -> Single process(50%) -> Network works fine
Running unprivileged -> Multi process(100%) -> locks out network

Going to try a few other network cards if I find one.

On Fri, 17 May 2002, Alan Cox wrote:

> > So the problem would appear to be that your networking *requires*
> > ksoftirqd services to function.  Either:
> > 
> > 1) The driver is bust - its hard_start_xmit() function is failing
> >    frequently, and relying on ksoftirqd to get things done (I think;
> >    it's been a while).  Or
> 
> The ne2k card has little buffering. 
> 
> > 2) Something is wrong with the ksoftirqd design.  Or
> 
> I think its mostly #2. We invoke ksoftirq far far too easily.
> 

-- 
Paul N. Faure					613.266.3286
EngSoc Administrator            		paul-at-engsoc-dot-org
Chief Technical Officer, CertainKey Inc.	paul-at-certainkey-dot-com
Carleton University Systems Eng. 4th Year	paul-at-faure-dot-ca

