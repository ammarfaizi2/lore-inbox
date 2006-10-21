Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992761AbWJUBQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992761AbWJUBQm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 21:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992768AbWJUBQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 21:16:42 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:30381 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S2992761AbWJUBQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 21:16:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=zZPrrfxoUV7XC+H3QO1TasA+xw7FoGpFqxmuUvK3rL3QTUk6MZG7Z0UqiljepJv2STZzXhb9zvn3oHz5c/dmSKdkpyT2wKMwIaG1icvbpv26vGq7SqN6tvT6Lu7SZ4m3Kmh+h/pmYStvr1SqRouWH9zJi5LVYQto02tJ0S8N9VM=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 04/10] uml: make execvp safe for our usage
Date: Sat, 21 Oct 2006 03:16:38 +0200
User-Agent: KMail/1.9.5
Cc: Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20061017211943.26445.75719.stgit@americanbeauty.home.lan> <20061017212711.26445.79770.stgit@americanbeauty.home.lan> <20061018183707.GB6566@ccure.user-mode-linux.org>
In-Reply-To: <20061018183707.GB6566@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610210316.38732.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 October 2006 20:37, Jeff Dike wrote:
> On Tue, Oct 17, 2006 at 11:27:11PM +0200, Paolo 'Blaisorblade' Giarrusso 
wrote:
> > Reimplement execvp for our purposes - after we call fork() it is
> > fundamentally unsafe to use the kernel allocator - current is not valid
> > there.
>
> This is horriby ugly.  Can we instead do something different like
> check out the paths of helpers at early boot, before the kernel is
> running, save them, and simply execve them later?
>
> At that point, something like running "which foo" would be fine by me.

I'd add that this can IMHO cause hard-to-diagnose crashes (I've seen strange 
behaviours in debug mode, and even schedule-while-atomic warnings, maybe 
because the creator thread had gone in atomic mode), and since this is a 
working fix, either this or a replacement should go in.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
