Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271362AbTHMDtK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 23:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271369AbTHMDtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 23:49:10 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:11709 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S271362AbTHMDtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 23:49:07 -0400
Subject: Re: generic strncpy - off-by-one error
From: Albert Cahalan <albert@users.sf.net>
To: andersen@codepoet.org
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       bernd@firmix.at, Anthony.Truong@mascorp.com, alan@lxorguk.ukuu.org.uk,
       schwab@suse.de, ysato@users.sourceforge.jp, willy@w.ods.org,
       Valdis.Kletnieks@vt.edu, william.gallafent@virgin.net
In-Reply-To: <20030813024752.GA20369@codepoet.org>
References: <1060741101.948.245.camel@cube>
	 <20030813024752.GA20369@codepoet.org>
Content-Type: text/plain
Organization: 
Message-Id: <1060745910.948.268.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 12 Aug 2003 23:38:31 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-12 at 22:47, Erik Andersen wrote:
> On Tue Aug 12, 2003 at 10:18:21PM -0400, Albert Cahalan wrote:
> > You're all wrong. This is some kind of programming
> > test for sure!
> > 
> > Let us imagine that glibc has a correct version.
> > By exhaustive testing, I found a version that works.
> > Here it is, along with the test code:
> > 
> > //////////////////////////////////////////////////////
> > #define _GNU_SOURCE
> > #include <string.h>
> > #include <stdlib.h>
> > #include <stdio.h>
> > 
> > // first correct implementation!
> > char * strncpy_good(char *dest, const char *src, size_t count){
> >   char *tmp = dest;
> >   memset(dest,'\0',count);
> >   while (count-- && (*tmp++ = *src++))
> >     ;
> >   return dest;
> > }
> 
> char *strncpy(char * s1, const char * s2, size_t n)
> {
>     register char *s = s1;
>     while (n) {
> 	if ((*s = *s2) != 0) s2++;
> 	++s;
> 	--n;
>     }
>     return s1;
> }

That's excellent. On ppc I count 12 instructions,
4 of which would go away for typical usage if inlined.
Annoyingly, gcc doesn't get the same assembly from my
attempt at that general idea:

char * strncpy_5(char *dest, const char *src, size_t count){
  char *tmp = dest;
  while (count--){
    if(( *tmp++ = *src )) src++;
  }
  return dest;
}

I suppose that gcc could use a bug report.


