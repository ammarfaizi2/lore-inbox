Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314492AbSDRXRb>; Thu, 18 Apr 2002 19:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314493AbSDRXRa>; Thu, 18 Apr 2002 19:17:30 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:5643 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S314492AbSDRXR1>;
	Thu, 18 Apr 2002 19:17:27 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] 2.5.8 sort kernel tables 
In-Reply-To: Your message of "18 Apr 2002 19:51:43 +0200."
             <p738z7kao9c.fsf@oldwotan.suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 19 Apr 2002 09:17:16 +1000
Message-ID: <6277.1019171836@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Apr 2002 19:51:43 +0200, 
Andi Kleen <ak@suse.de> wrote:
>Paul Mackerras <paulus@samba.org> writes:
>> 
>> BTW, do you have any valid examples of use of copy_to/from_user or
>> get/put_user in an init section?
>
>i386 uses the exception tables to check at startup for the old i386 bug of 
>pages not being  write protected when writing from supervisor mode. That 
>function is __init.

It used to be, somebody realised that it did not work and took it out
of __init.  With sorted tables it can be moved back.

/*
 * This function cannot be __init, since exceptions don't work in that
 * section.
 */
static int do_test_wp_bit(unsigned long vaddr);

That fixes the symptom, not the cause.  It is better to sort the tables
at boot time than to find each bit of code that might break the tables
and change the code.

