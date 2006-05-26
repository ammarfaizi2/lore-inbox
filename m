Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbWEZQhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWEZQhd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 12:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbWEZQhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 12:37:33 -0400
Received: from nz-out-0102.google.com ([64.233.162.195]:40427 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751065AbWEZQhc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 12:37:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qBClldd118wwriIAiKmhoZKlH/+AiUSlx2GxIra8H5XIvvDpBwzrkqWSwJlAVBPOAuywlBBtP6rs8gAe5qpKbvOeGvqQ6SbUMVUIvo0Yj75cb70YIs5XxlGRzYRO7AfF+f1Xr8Acsn5nnVPK/KfWu74NmIZr5g+vQXC4dUACRIQ=
Message-ID: <b0943d9e0605260937j5a86d4dr4adcae6fc35c73fa@mail.gmail.com>
Date: Fri, 26 May 2006 17:37:31 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: [PATCH 2.6.17-rc4 1/6] Base support for kmemleak
Cc: "Andi Kleen" <ak@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20060526085916.GA14388@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060513155757.8848.11980.stgit@localhost.localdomain>
	 <20060513160541.8848.2113.stgit@localhost.localdomain>
	 <p73u07t5x6f.fsf@bragg.suse.de> <20060526085916.GA14388@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/06, Ingo Molnar <mingo@elte.hu> wrote:
> All in one, i'm very much in favor of adding kmemleak to the upstream
> kernel, once it gets clean enough and has seen some exposure on -mm.

I cleaned it and also tested it on SMP. I need to run a few more tests
on x86 (as I mainly work on ARM) and release a new version this
weekend.

A problem I'm facing (also because I'm not familiar with the other
architectures) is detecting the effective stack boundaries of the
threads running or waiting in kernel mode. Scanning the whole stack
(8K) hides some possible leaks (because of no longer used local
variables) and not scanning the list at all can lead to false
positives. I would need to investigate this a bit more.

-- 
Catalin
