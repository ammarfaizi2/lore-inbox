Return-Path: <linux-kernel-owner+w=401wt.eu-S1762338AbWLKDhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762338AbWLKDhZ (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 22:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762392AbWLKDhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 22:37:24 -0500
Received: from web55613.mail.re4.yahoo.com ([206.190.58.237]:32937 "HELO
	web55613.mail.re4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1762338AbWLKDhY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 22:37:24 -0500
Message-ID: <20061211033723.94646.qmail@web55613.mail.re4.yahoo.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=WX9bvT9pjx/XNUgeLmykAzbkghMruF6Lw8F7HgS5aL9Q30YTOw3MRmmejD/zXzN9aIJaLqGArditaLd90GLlBRHsOdYx1z5wNpttTrZxeIFPEkabUOEoqGl7595yVvPq4YrA8BkMR7caDkN9B03hhajOX9YUo6NDuPgg6x02tQE=;
X-YMail-OSG: VbQKpJQVM1ksd9OIqI_nWLuWrwDi_iyWVgd1ZlUr9KDNds8vK1hjxtn.bcSLHlysQQ5fLHXSsgiT_DsXweYBtRnddDqm9bzMBOCpOOyhZhP86ihlGimQLOdl8Z2Y3gg4X4VgfY0VyVDHpA--
Date: Sun, 10 Dec 2006 19:37:23 -0800 (PST)
From: Amit Choudhary <amit2030@yahoo.com>
Subject: Re: 2.6.19: slight performance optimization for lib/string.c's strstrip()
To: Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> How about this:
> 
> char *strstrip(char *s)
> {
>         size_t less = 0;
>         char c = 0;
>         char *e = NULL;
> 
>         while ((c=*s) && isspace(c))
>                 s++;
>         if (!c)
>                 return s;
> 
>         e = s;
> 
>         while (c=*e) {
>                  less = isspace(c) ? (less + 1) : 0;
>                  e++;
>         }
> 
>         *(e-less) = 0;
> 
>         return s;
> }
> 

Well, this is not very efficient because it ends up calling isspace() function for all characters.
So, Ulrich's algo is the fastest.

-Amit


 
____________________________________________________________________________________
Yahoo! Music Unlimited
Access over 1 million songs.
http://music.yahoo.com/unlimited
