Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271337AbTHMCr4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 22:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271352AbTHMCr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 22:47:56 -0400
Received: from codepoet.org ([166.70.99.138]:61830 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S271337AbTHMCry (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 22:47:54 -0400
Date: Tue, 12 Aug 2003 20:47:53 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>, bernd@firmix.at,
       Anthony.Truong@mascorp.com, alan@lxorguk.ukuu.org.uk, schwab@suse.de,
       ysato@users.sourceforge.jp, willy@w.ods.org, Valdis.Kletnieks@vt.edu,
       william.gallafent@virgin.net
Subject: Re: generic strncpy - off-by-one error
Message-ID: <20030813024752.GA20369@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Albert Cahalan <albert@users.sf.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	bernd@firmix.at, Anthony.Truong@mascorp.com,
	alan@lxorguk.ukuu.org.uk, schwab@suse.de, ysato@users.sourceforge.jp,
	willy@w.ods.org, Valdis.Kletnieks@vt.edu,
	william.gallafent@virgin.net
References: <1060741101.948.245.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060741101.948.245.camel@cube>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Aug 12, 2003 at 10:18:21PM -0400, Albert Cahalan wrote:
> You're all wrong. This is some kind of programming
> test for sure!
> 
> Let us imagine that glibc has a correct version.
> By exhaustive testing, I found a version that works.
> Here it is, along with the test code:
> 
> //////////////////////////////////////////////////////
> #define _GNU_SOURCE
> #include <string.h>
> #include <stdlib.h>
> #include <stdio.h>
> 
> // first correct implementation!
> char * strncpy_good(char *dest, const char *src, size_t count){
>   char *tmp = dest;
>   memset(dest,'\0',count);
>   while (count-- && (*tmp++ = *src++))
>     ;
>   return dest;
> }

char *strncpy(char * s1, const char * s2, size_t n)
{
    register char *s = s1;
    while (n) {
	if ((*s = *s2) != 0) s2++;
	++s;
	--n;
    }
    return s1;
}

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
