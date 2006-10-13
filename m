Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751417AbWJMMAB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWJMMAB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 08:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWJMMAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 08:00:01 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:58927 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751417AbWJMMAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 08:00:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VAvBHftaY0Tym8S8Dbcm+uVPs7dTNSXeb07KcukXwxPqG7XJRw4WLpGk8qYSIEOOMphVlRYgr4/wlH9pgZuVnqV2hIMHmsC7ZIySuzKeEoi0xch+2o3tSMhauwDm5Y4gQFmnwnFRhTQELXvatAC9/PMdgKqUiw2QJKB2sEcxU0o=
Message-ID: <b0943d9e0610130459w22e6b9a1g57ee67a2c2b97f81@mail.gmail.com>
Date: Fri, 13 Oct 2006 12:59:59 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: Major slab mem leak with 2.6.17 / GCC 4.1.1
Cc: "nmeyers@vestmark.com" <nmeyers@vestmark.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <84144f020610122256p7f615f93lc6d8dcce7be39284@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061013004918.GA8551@viviport.com>
	 <84144f020610122256p7f615f93lc6d8dcce7be39284@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/06, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> On 10/13/06, nmeyers@vestmark.com <nmeyers@vestmark.com> wrote:
> > If anyone has a version of kmemleak that I can build with 4.1.1, or
> > any other suggestions for instrumentation, I'd be happy to gather more
> > data - the problem is very easy for me to reproduce.
>
> You should cc Catalin for that. Alternatively, you could try
> CONFIG_DEBUG_SLAB_LEAK.

Thanks for cc'ing me (I'm still on holiday and not following the
mailing list). The problem is the __builtin_constant_p gcc function
which doesn't work properly with 4.x versions. It was fixed in latest
gcc versions though. Kmemleak relies on __builtin_constant_p to
determine the pointer aliases and without it you would get plenty of
false positives.

-- 
Catalin
