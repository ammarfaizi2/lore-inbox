Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161005AbWHAJqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161005AbWHAJqO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 05:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161025AbWHAJqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 05:46:13 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:6492 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161005AbWHAJqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 05:46:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Ymv0/ZTzKd5FLtM6QjBVtCLqapIwIACMdZHC7HzCK1LMChsknUohcyI5W7mI1CyRum/fGmAxmW4l71HJIP4Oo7Y3WnjuT6OhVFzkW14t6/g72BI/q9RlG0OQtMgDeiBr/mU5O2OqWNKx/fPn0GThfHroR35SHJhSXoLwIKRwV8U=
Message-ID: <44CF22E8.9020307@gmail.com>
Date: Tue, 01 Aug 2006 11:45:53 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: Hua Zhong <hzhong@gmail.com>,
       "'Heiko Carstens'" <heiko.carstens@de.ibm.com>,
       "'Andrew Morton'" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "'Martin Schwidefsky'" <schwidefsky@de.ibm.com>
Subject: Re: do { } while (0) question
References: <008e01c6b549$59e52f70$493d010a@nuitysystems.com> <1154425171.32739.2.camel@taijtu>
In-Reply-To: <1154425171.32739.2.camel@taijtu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:
> On Tue, 2006-08-01 at 02:03 -0700, Hua Zhong wrote:
>>> #if KILLER == 1
>>> #define MACRO
>>> #else
>>> #define MACRO do { } while (0)
>>> #endif
>>>
>>> {
>>> 	if (some_condition)
>>> 		MACRO
>>>
>>> 	if_this_is_not_called_you_loose_your_data();
>>> }
>>>
>>> How do you want to define KILLER, 0 or 1? I personally choose 0.
>> Really? Does it compile?
> 
> No, and that is the whole point.
> 
> The empty 'do {} while (0)' makes the missing semicolon a syntax error.

Bulls^WNope, it was a bad example (we don't want to break the compilation, just 
not want to emit a warn or an err).

I can't emit an error with the thing like that, only a warning, but we are not 
using -Werror to get err from a warn. Thing such this would emit empty-statement 
warn if define KILLER as 1:
#if KILLER == 1
#define MACRO
#else
#define MACRO do { } while (0)
#endif

{
  	if (some_condition)
  		MACRO;
	else
		do_something();
}

regards,
-- 
<a href="http://www.fi.muni.cz/~xslaby/">Jiri Slaby</a>
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
