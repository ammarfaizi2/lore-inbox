Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272684AbTHPJYz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 05:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272685AbTHPJYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 05:24:55 -0400
Received: from krynn.se.axis.com ([193.13.178.10]:15824 "EHLO
	krynn.se.axis.com") by vger.kernel.org with ESMTP id S272684AbTHPJYx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 05:24:53 -0400
Message-ID: <D069C7355C6E314B85CF36761C40F9A42E20BC@mailse02.se.axis.com>
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "'Daniel Forrest'" <forrest@lmcg.wisc.edu>
Cc: "'Timothy Miller'" <miller@techsource.com>,
       "'Willy Tarreau'" <willy@w.ods.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: RE: generic strncpy - off-by-one error
Date: Sat, 16 Aug 2003 11:19:30 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Daniel Forrest [mailto:forrest@lmcg.wisc.edu] 
> Sent: Saturday, August 16, 2003 10:41
> To: Peter Kjellerstedt
> Cc: 'Timothy Miller'; 'Willy Tarreau'; linux-kernel mailing list
> Subject: Re: generic strncpy - off-by-one error
> 
> On Sat, Aug 16, 2003 at 10:15:14AM +0200, Peter Kjellerstedt wrote:
> > 
> > Here is the code that I used:
> > 
> > char *strncpy(char *dest, const char *src, size_t count)
> > {
> > 	char *tmp = dest;
> > 
> > 	while (count && *src) {
> > 		*tmp++ = *src++;
> > 		count--;
> > 	}
> > 
> > 	if (count) {
> > 		size_t count2;
> > 
> > 		while (count & (sizeof(long) - 1)) {
> 
> Shouldn't this be:
> 
> 		while (tmp & (sizeof(long) - 1)) {

Actually, it should be:

	while (count && ((long)tmp & (sizeof(long) - 1)))

> > 			*tmp++ = '\0';
> > 			count--;
> > 		}
> > 
> > 		count2 = count / sizeof(long);
> > 		while (count2) {
> > 			*((long *)tmp)++ = '\0';
> > 			count2--;
> > 		}
> > 
> > 		count &= (sizeof(long) - 1);
> > 		while (count) {
> > 			*tmp++ = '\0';
> > 			count--;
> > 		}
> > 	}
> > 
> > 	return dest;
> > }
> 
> -- 
> Dan

//Peter
