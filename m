Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbVGSUKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVGSUKm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 16:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbVGSUKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 16:10:41 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:48111 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261603AbVGSUKh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 16:10:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UB/sNRkDICDm942H3181AZxOZlNo185VEQl1k4ul9b/yX0Mp8lzaYy/C7hIkYszXym2l2U/Em8JXiMXKGNTAct1PyTzLMgbgEOpODJA0xJG8n250gFwBSk2nxIAHGcWGkUHhAtHWgsu5p0us90zJsWvisraKS33XhQKN0dKlbzQ=
Message-ID: <3f250c7105071913091c5b2858@mail.gmail.com>
Date: Tue, 19 Jul 2005 16:09:43 -0400
From: Mauricio Lin <mauriciolin@gmail.com>
Reply-To: Mauricio Lin <mauriciolin@gmail.com>
To: "P@draigbrady.com" <P@draigbrady.com>
Subject: Re: How do you accurately determine a process' RAM usage?
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <42D39102.5010503@draigBrady.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42CC2923.2030709@draigBrady.com>
	 <20050706181623.3729d208.akpm@osdl.org>
	 <42CCE737.70802@draigBrady.com>
	 <20050707014005.338ea657.akpm@osdl.org>
	 <42D39102.5010503@draigBrady.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/12/05, P@draigbrady.com <P@draigbrady.com> wrote:
> Andrew Morton wrote:
> > OK, please let us know how it goes.
> 
> It went very well. I could find no problems at all.
> I've updated my script to use the new method, so please merge smaps :)
> http://www.pixelbeat.org/scripts/ps_mem.py
> 
> Usually the shared mem reported by /proc/$$/statm
> is the same as summing all the shared values in in /proc/$$/smaps
> but there can be large discrepancies.

Have you checked how the statm shared is calculated? I guess it does
something like:
shared = mm->rss - mm->anon_rss

But in smaps output you can have anonymous area like:

b6e0e000-b6e13000 rw-p
Size:                20 KB
Rss:                  4 KB
Shared_Clean:         0 KB
Shared_Dirty:         4 KB
Private_Clean:        0 KB
Private_Dirty:        0 KB

Look that it presents 4 KB of shared value in area considered anonymous.

ANDREW: anon_rss is the rss for anonymous area, right?

> In the real world you can see this with a newly started apache.
> On my system statm reported that apache was using 35MB,
> whereas smaps reported the correct amount of 11MB.

How dou you know that 11MB is the correct shared value  and the 35MB
is the wrong value?

BR,

Mauricio Lin.
