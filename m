Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbVICQea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbVICQea (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 12:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbVICQea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 12:34:30 -0400
Received: from smtpout.mac.com ([17.250.248.85]:40935 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751087AbVICQea (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 12:34:30 -0400
In-Reply-To: <200509031836.22357.vda@ilport.com.ua>
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com> <20050903042859.GA30101@codepoet.org> <AFDE003F-F14F-42CE-B964-2E04A4402406@mac.com> <200509031836.22357.vda@ilport.com.ua>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <EE55C4EC-424E-45B8-8BFD-B8C719730C13@mac.com>
Cc: andersen@codepoet.org, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC] Splitting out kernel<=>userspace ABI headers
Date: Sat, 3 Sep 2005 12:33:53 -0400
To: Denis Vlasenko <vda@ilport.com.ua>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 3, 2005, at 11:36:22, Denis Vlasenko wrote:
> Is this an exercise in academia? Userspace app which defines
> uint32_t to anything different than 'typedef <appropriate int type>'
> deserves the punishment, and one which does have such typedef
> instead of #include stdint.h will not notice.

That's not the issue.  Say I do this (which is perfectly valid on
most platforms):

typedef unsigned int uint32_t;
#include <linux/loop.h>

What exactly should happen?  If linux/loop.h includes stdint.h to get
uint32_t, then I'll get duplicate definition errors.  If it omits
stdint.h, then uint16_t won't be defined (because the userspace app
doesn't think that it needs it) and I'll get undefined type errors.
Either way, depending on the existence or nonexistence of the POSIX
types in userspace-accessible kernel headers is not viable.

> All these u32, uint32_t, __u32 end up typedef-ing to same
> integer type anyway...

The point is to provide a type that _isn't_ in some standard so that
_we_ can define its inclusion rules.  If the standards had gone and
defined "Userspace must include stdint.h or define _all_ types
appropriately", then we would not have had this issue, but many apps
in userspace would cease to compile on standards compliant platforms.

Cheers,
Kyle Moffett

--
Somone asked me why I work on this free (http://www.fsf.org/philosophy/)
software stuff and not get a real job. Charles Shultz had the best  
answer:

"Why do musicians compose symphonies and poets write poems? They do  
it because
life wouldn't have any meaning for them if they didn't. That's why I  
draw
cartoons. It's my life."
   -- Charles Shultz


