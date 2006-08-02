Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbWHBRiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWHBRiO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 13:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWHBRiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 13:38:14 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:23435 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751296AbWHBRiN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 13:38:13 -0400
Message-ID: <44D0E2EA.6030301@watson.ibm.com>
Date: Wed, 02 Aug 2006 13:37:46 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: balbir@in.ibm.com
CC: Jay Lan <jlan@sgi.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Chris Sturtivant <csturtiv@sgi.com>, Tony Ernst <tee@sgi.com>
Subject: Re: [patch 1/3] add basic accounting fields to taskstats
References: <44CE57EF.2090409@sgi.com> <44CF6433.50108@in.ibm.com> <44CFCCE4.7060702@sgi.com> <44D0C56C.3030505@watson.ibm.com> <44D0DE13.7090205@in.ibm.com>
In-Reply-To: <44D0DE13.7090205@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:

> 
> I am not sure if there is a version of BUG_ON() for compile time
> asserts. Basically, if we have an infrastructure of the form
> 
> /*
>  * From C/C++ users journal November 2004
>  */
> #define STATIC_BUG_ON(e)     \
>     switch (0) {        \
>     case  0:        \
>     case (e):        \
>         ;        \
>     }
> 
> Then the STATIC_BUG_ON() can catch as shown below.
> 
> #define TASK_COMM_LEN     16
> #define T_COMM_LEN    20
> 
> int
> main(void)
> {
>     STATIC_BUG_ON(TASK_COMM_LEN == T_COMM_LEN);
> }
> 
> STATIC_BUG_ON gives the following warning
> 
> bug_on_c.c: In function `main':
> bug_on_c.c:19: duplicate case value
> bug_on_c.c:19: previously used here
> 
> but with T_COMM_LEN set to 16
> 
> It compiles without any errors, the code generated also
> looks like it has no overhead
> 
> int
> main(void)
> {
>  8048310:       55                      push   %ebp
>  8048311:       89 e5                   mov    %esp,%ebp
>  8048313:       83 ec 08                sub    $0x8,%esp
>  8048316:       83 e4 f0                and    $0xfffffff0,%esp
>         STATIC_BUG_ON(TASK_COMM_LEN == T_COMM_LEN);
> }
>  8048319:       c9                      leave
>  804831a:       c3                      ret
>  804831b:       90                      nop
> 
> 
> Assuming such infrastructure is available, you could then
> do
> 
> #ifdef __KERNEL__
> #include <linux/sched.h>
> #define TS_COMM_LEN    16
> STATIC_BUG_ON (TS_COMM_LEN == TASK_COMM_LEN);
> #endif
> 
> Comments?
> 

Neat trick !
Perhaps STATIC_WARNING is a more appropriate name but
something like this for general use may be good.


--Shailabh
