Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262487AbVCaBMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262487AbVCaBMt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 20:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbVCaBMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 20:12:49 -0500
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:41379 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262487AbVCaBM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 20:12:29 -0500
Message-ID: <424B4E75.4010107@yahoo.com.au>
Date: Thu, 31 Mar 2005 11:12:21 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: Jakub Jelinek <jakub@redhat.com>, Paulo Marques <pmarques@grupopie.com>,
       akpm@osdl.org, Shankar Unni <shankarunni@netscape.net>,
       linux-kernel@vger.kernel.org, bunk@stusta.de, khali@linux-fr.org
Subject: Re: Not a GCC bug (was Re: Big GCC bug!!! [Was: Re: Do not misuse
 Coverity please])
References: <200503300125.j2U1PFQ9005082@laptop11.inf.utfsm.cl> <OofSaT76.1112169183.7124470.khali@localhost> <d2er4p$qp$1@sea.gmane.org> <424AFA98.9080402@grupopie.com> <aae129062f1e3992c8ec025d5f239be9@mac.com> <20050330233825.GS17420@devserv.devel.redhat.com> <e8fc51864bab0a24b04af9867d748f5f@mac.com>
In-Reply-To: <e8fc51864bab0a24b04af9867d748f5f@mac.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
> On Mar 30, 2005, at 18:38, Jakub Jelinek wrote:
> 
>> This testcase violates ISO C99 6.3.2.3:
>> If a null pointer constant is converted to a pointer type, the resulting
>> pointer, called a null pointer, is guaranteed to compare unequal to a
>> pointer to any object or function.
> 
> 
> Except that the result of dereferencing a null pointer is implementation
> defined according to the C99 standard.  My implementation allows me to mmap
> stuff at NULL, and therefore its compiler should be able to handle that
> case.  I would have no problem with either the standard or implementation
> if it either properly handled the case or didn't allow it in the first
> place.
> 
> On another note, I've discovered the flag 
> "-fno-delete-null-pointer-checks",
> which should probably be included in the kernel makefiles to disable that
> optimization for the kernel.  (Ok, yes, I apologize, this isn't really a 
> GCC
> bug, the behavior is documented, although it can be quite confusing.  I
> suspect it may bite some platform-specific code someday.  It also muddies
> the waters somewhat with respect to the original note (and the effects on
> the generated code):
> 
>> int x = my_struct->the_x;
>> if (!my_struct) return;
> 

Why should this be in the kernel makefiles? If my_struct is NULL,
then the kernel will never reach the if statement.

A warning might be nice though.

