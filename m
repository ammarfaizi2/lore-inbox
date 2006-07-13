Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030242AbWGMPpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030242AbWGMPpp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 11:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030241AbWGMPpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 11:45:45 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:31682 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030242AbWGMPpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 11:45:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=MD9QfX9Y7i29XNrUG7Wi4coEHWGAzjCXUw0S0EsXNIR8UFajxdEaPzm2U2c5nppEAWUTDRicToLLtRtvtZ9ctcJIkwFURQUkDEuUdyNe7UUXjE4LxYBQfAtm1V6SMBEUbYidCUzruGmx6duoC3fdFTM7rC0hieHegCofNrhTbPw=
Message-ID: <84144f020607130845h223432f2y6f4117828dadb69c@mail.gmail.com>
Date: Thu, 13 Jul 2006 18:45:43 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: [patch] lockdep: annotate mm/slab.c
Cc: "Andrew Morton" <akpm@osdl.org>, sekharan@us.ibm.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, nagar@watson.ibm.com, balbir@in.ibm.com,
       arjan@infradead.org
In-Reply-To: <20060713124603.GB18936@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1152763195.11343.16.camel@linuxchandra>
	 <20060713071221.GA31349@elte.hu>
	 <20060713002803.cd206d91.akpm@osdl.org> <20060713072635.GA907@elte.hu>
	 <20060713004445.cf7d1d96.akpm@osdl.org>
	 <20060713124603.GB18936@elte.hu>
X-Google-Sender-Auth: 8dd7ec4bb7a1cede
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/13/06, Ingo Molnar <mingo@elte.hu> wrote:
> mm/slab.c uses nested locking when dealing with 'off-slab'
> caches, in that case it allocates the slab header from the
> (on-slab) kmalloc caches. Teach the lock validator about
> this by putting all on-slab caches into a separate class.

Which lock is that? This affects only caches that cache_grow() use, so
we are really only interested in annotating kmalloc() on-slab caches
(like in the patch), not _all_, right?
