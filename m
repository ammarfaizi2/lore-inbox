Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbWH3Rcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWH3Rcn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 13:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbWH3Rcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 13:32:42 -0400
Received: from mail.suse.de ([195.135.220.2]:56206 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751194AbWH3Rcm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 13:32:42 -0400
From: Andi Kleen <ak@suse.de>
To: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: Re: [PATCH] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit (ping)
Date: Wed, 30 Aug 2006 19:31:14 +0200
User-Agent: KMail/1.9.3
Cc: "H. Peter Anvin" <hpa@zytor.com>, Matt Domsch <Matt_Domsch@dell.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       johninsd@san.rr.com
References: <44F1F356.5030105@zytor.com> <200608301856.11125.ak@suse.de> <20060830200638.504602e2@localhost>
In-Reply-To: <20060830200638.504602e2@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608301931.14434.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 August 2006 19:06, Alon Bar-Lev wrote:

> > 
> > And the other thing is that this will cost memory. Either make
> > it dependend on !CONFIG_SMALL or fix the boot code to save the 
> > command line into a kmalloc'ed buffer of the right size and __init 
> > the original one
> 
> I don't mind doing either... Any preference for one of them? The
> kmalloc approach seems nicer..

kmalloc is better yes. You just have to do it after kmalloc is up
and running and make sure the users before reference the __init'ed version.
I suspect only /proc/cmdline will need the kmalloc version after booting, 
nobody else should look at the command line.

-Andi
