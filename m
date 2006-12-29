Return-Path: <linux-kernel-owner+w=401wt.eu-S965171AbWL2Vuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965171AbWL2Vuz (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 16:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965168AbWL2Vuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 16:50:55 -0500
Received: from pne-smtpout4-sn2.hy.skanova.net ([81.228.8.154]:47271 "EHLO
	pne-smtpout4-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965171AbWL2Vuy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 16:50:54 -0500
X-Greylist: delayed 4144 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Dec 2006 16:50:54 EST
Date: Fri, 29 Dec 2006 22:41:47 +0200
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel@vger.kernel.org
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: PROBLEM: 2.6.19 + highmem = BUG at do_wp_page
Message-ID: <20061229204147.GA3844@m.safari.iki.fi>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Chuck Ebbert <76306.1226@compuserve.com>,
	Andrew Morton <akpm@osdl.org>
References: <200612121513_MC3-1-D4D1-4A51@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200612121513_MC3-1-D4D1-4A51@compuserve.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2006 at 15:10:56 -0500, Chuck Ebbert wrote:
> In-Reply-To: <20061205172512.GA5518@m.safari.iki.fi>
> 
> On Tue, 5 Dec 2006 19:25:13 +0200, Sami Farin wrote:
> 
> > BUG: unable to handle kernel paging request at virtual address fffb9dc0
> 
> > eax: fffb8000   ebx: fffb9000   ecx: 00000090   edx: 00000000
> > esi: fffb9dc0   edi: fffb8dc0   ebp: f6f89f24   esp: f6f89ef0
> 
>   1f:   89 de                     mov    %ebx,%esi
>   21:   b9 00 04 00 00            mov    $0x400,%ecx
>   26:   89 45 cc                  mov    %eax,0xffffffcc(%ebp)
>   29:   89 c7                     mov    %eax,%edi
> 
>    0:   f3 a5                     repz movsl %ds:(%esi),%es:(%edi)   <=====
> 
> Processor started to copy a page, then with 576 bytes left to copy
> the source page got unmapped.  Nice.
> 
> This possibly happened during a device interrupt. What does
> /proc/interrupts say?

My system now works with HIGHMEM (got 103 MB extra mem for use).

I Fixed™ this by nuking crypto API out of the fortuna patch
and including my own functions...

$ cat /proc/sys/kernel/random/cipher_algo 
Snuffle 2005

hehe..

-- 
