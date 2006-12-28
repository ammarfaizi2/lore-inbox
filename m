Return-Path: <linux-kernel-owner+w=401wt.eu-S964897AbWL1Cta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbWL1Cta (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 21:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbWL1Cta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 21:49:30 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:14141 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964897AbWL1Ct3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 21:49:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=JzfrsoL31rJkYY9NOmIIPpyHLXst4m96k3roz3Kvj0bqlyYkXVGMy5zS0vX7sp9HYiiTy5foecgPO3iMiEfegiyvxcA0hY+XTtA03e8LyF78MJkAJKfVqVNJ4nRdGKgStwIHP8rEwWLITiGNLUFreESfVyBapYQ0p7fuk8UzVIU=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: Rob Landley <rob@landley.net>
Subject: Re: Feature request: exec self for NOMMU.
Date: Thu, 28 Dec 2006 03:48:16 +0100
User-Agent: KMail/1.8.2
Cc: ray-gmail@madrabbit.org, linux-kernel@vger.kernel.org,
       "David McCullough" <david_mccullough@au.securecomputing.com>
References: <200612261823.07927.rob@landley.net> <200612271935.07835.vda.linux@googlemail.com> <200612271603.39454.rob@landley.net>
In-Reply-To: <200612271603.39454.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612280348.16670.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 December 2006 22:03, Rob Landley wrote:
> On Wednesday 27 December 2006 1:35 pm, Denis Vlasenko wrote:
> > This solves chroot problem. How to find path-to-yourself reliably
> > (for one, without using /proc/self/exe) is not obvious to me.
> 
> Been there, done that.  Both my toybox and Firmware Linux projects do this.  
> In FWL it's line 115 of this file:
> http://landley.net/hg/firmware?f=937346748ff4;file=sources/toys/gcc-uClibc.c
> 
> It's essentially the logic of the command line "which" utility applied to 
> argv[0].  If argv[0] has a relative or absolute path, then it's vs cwd (this 
> has to happen when you first run the program, before you cd).  If argv[0] has 
> no path then look at $PATH.

Yes Rob, I know it can be done like this. But we don't want this.
In the tar example, we want :

'Run my own binary again, with parameters: "zcat" "a.tar.gz",
even if there is no [/usr][/local]/bin/zcat -> busybox link anywhere'

We do not want to _search for_ zcat. We want to reexec our own binary.
--
vda
