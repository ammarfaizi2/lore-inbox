Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272647AbTHPIlh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 04:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272653AbTHPIlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 04:41:37 -0400
Received: from mail.lmcg.wisc.edu ([144.92.101.145]:56518 "EHLO
	mail.lmcg.wisc.edu") by vger.kernel.org with ESMTP id S272647AbTHPIlf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 04:41:35 -0400
Date: Sat, 16 Aug 2003 03:41:29 -0500
From: Daniel Forrest <forrest@lmcg.wisc.edu>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Cc: "'Timothy Miller'" <miller@techsource.com>,
       "'Willy Tarreau'" <willy@w.ods.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: generic strncpy - off-by-one error
Message-ID: <20030816034129.A6301@rda07.lmcg.wisc.edu>
Reply-To: Daniel Forrest <forrest@lmcg.wisc.edu>
References: <D069C7355C6E314B85CF36761C40F9A42E20BB@mailse02.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <D069C7355C6E314B85CF36761C40F9A42E20BB@mailse02.se.axis.com>; from peter.kjellerstedt@axis.com on Sat, Aug 16, 2003 at 10:15:14AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 16, 2003 at 10:15:14AM +0200, Peter Kjellerstedt wrote:
> 
> Here is the code that I used:
> 
> char *strncpy(char *dest, const char *src, size_t count)
> {
> 	char *tmp = dest;
> 
> 	while (count && *src) {
> 		*tmp++ = *src++;
> 		count--;
> 	}
> 
> 	if (count) {
> 		size_t count2;
> 
> 		while (count & (sizeof(long) - 1)) {

Shouldn't this be:

		while (tmp & (sizeof(long) - 1)) {

> 			*tmp++ = '\0';
> 			count--;
> 		}
> 
> 		count2 = count / sizeof(long);
> 		while (count2) {
> 			*((long *)tmp)++ = '\0';
> 			count2--;
> 		}
> 
> 		count &= (sizeof(long) - 1);
> 		while (count) {
> 			*tmp++ = '\0';
> 			count--;
> 		}
> 	}
> 
> 	return dest;
> }

-- 
Dan
