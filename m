Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbVDCMaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbVDCMaU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 08:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbVDCMaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 08:30:19 -0400
Received: from mail.hosted.servetheworld.net ([62.70.14.38]:62856 "HELO
	mail.hosted.servetheworld.net") by vger.kernel.org with SMTP
	id S261714AbVDCMaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 08:30:14 -0400
Message-ID: <424FE1D3.9010805@osvik.no>
Date: Sun, 03 Apr 2005 14:30:11 +0200
From: Dag Arne Osvik <da@osvik.no>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: Use of C99 int types
References: <424FD9BB.7040100@osvik.no> <20050403220508.712e14ec.sfr@canb.auug.org.au>
In-Reply-To: <20050403220508.712e14ec.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell wrote:

>On Sun, 03 Apr 2005 13:55:39 +0200 Dag Arne Osvik <da@osvik.no> wrote:
>  
>
>>I've been working on a new DES implementation for Linux, and ran into
>>the problem of how to get access to C99 types like uint_fast32_t for
>>internal (not interface) use.  In my tests, key setup on Athlon 64 slows
>>down by 40% when using u32 instead of uint_fast32_t.
>>    
>>
>
>If you look in stdint.h you may find that uint_fast32_t is actually
>64 bits on Athlon 64 ... so does it help if you use u64?
>
>  
>

Yes, but wouldn't it be much better to avoid code like the following, 
which may also be wrong (in terms of speed)?

#ifdef CONFIG_64BIT  // or maybe CONFIG_X86_64?
  #define fast_u32 u64
#else
  #define fast_u32 u32
#endif

