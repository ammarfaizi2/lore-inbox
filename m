Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbVICQvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbVICQvj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 12:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbVICQvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 12:51:39 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:54705 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1751084AbVICQvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 12:51:38 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC] Splitting out kernel<=>userspace ABI headers
Date: Sat, 3 Sep 2005 19:51:02 +0300
User-Agent: KMail/1.8.2
Cc: andersen@codepoet.org, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com> <200509031836.22357.vda@ilport.com.ua> <EE55C4EC-424E-45B8-8BFD-B8C719730C13@mac.com>
In-Reply-To: <EE55C4EC-424E-45B8-8BFD-B8C719730C13@mac.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509031951.02490.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 September 2005 19:33, Kyle Moffett wrote:
> On Sep 3, 2005, at 11:36:22, Denis Vlasenko wrote:
> > Is this an exercise in academia? Userspace app which defines
> > uint32_t to anything different than 'typedef <appropriate int type>'
> > deserves the punishment, and one which does have such typedef
> > instead of #include stdint.h will not notice.
> 
> That's not the issue.  Say I do this (which is perfectly valid on
> most platforms):
> 
> typedef unsigned int uint32_t;
> #include <linux/loop.h>
> 
> What exactly should happen?  If linux/loop.h includes stdint.h to get
> uint32_t, then I'll get duplicate definition errors.  If it omits
> stdint.h, then uint16_t won't be defined (because the userspace app
> doesn't think that it needs it) and I'll get undefined type errors.

I vote for a second choice. Do not #include stdint.h from the loop.h
(i.e. loop.h assumes that it is included (or unit32_t typedef'ed),
but doesn't do it itself).
--
vda
