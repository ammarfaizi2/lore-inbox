Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261554AbVCRKIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbVCRKIH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 05:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVCRKIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 05:08:07 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:36357 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261554AbVCRKID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 05:08:03 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] reduce inlined x86 memcpy by 2 bytes
Date: Fri, 18 Mar 2005 12:07:32 +0200
User-Agent: KMail/1.5.4
Cc: Matt Mackall <mpm@selenic.com>
References: <200503181121.42809.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200503181121.42809.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503181207.32659.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 March 2005 11:21, Denis Vlasenko wrote:
> This memcpy() is 2 bytes shorter than one currently in mainline
> and it have one branch less. It is also 3-4% faster in microbenchmarks
> on small blocks if block size is multiple of 4. Mainline is slower
> because it has to branch twice per memcpy, both mispredicted
> (but branch prediction hides that in microbenchmark).
> 
> Last remaining branch can be dropped too, but then we execute second
> 'rep movsb' always, even if blocksize%4==0. This is slower than mainline
> because 'rep movsb' is microcoded. I wonder, tho, whether 'branchlessness'
> wins over this in real world use (not in bench).
> 
> I think blocksize%4==0 happens more than 25% of the time.

s/%4/&3 of course.
--
vda

