Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262716AbRE3Ke0>; Wed, 30 May 2001 06:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262719AbRE3KeQ>; Wed, 30 May 2001 06:34:16 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:13318 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S262716AbRE3KeC>;
	Wed, 30 May 2001 06:34:02 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Andi Kleen <ak@suse.de>
cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 4 security holes in 2.4.4-ac8 
In-Reply-To: Your message of "30 May 2001 11:38:13 +0200."
             <oupn17vp46y.fsf@pigdrop.muc.suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 30 May 2001 20:33:57 +1000
Message-ID: <18513.991218837@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 May 2001 11:38:13 +0200, 
Andi Kleen <ak@suse.de> wrote:
>"David S. Miller" <davem@redhat.com> writes:
>
>> Dawson Engler writes:
>>  > Is there any way to automatically find these?  E.g., is any routine
>>  > with "asmlinkage" callable from user space?
>> 
>> This is only universally done in generic and x86 specific code,
>> other ports tend to forget asmlinkage simply because most ports
>> don't need it.
>
>Even i386 doesn't need it because the stack frame happens to have the
>right order of the arguments at the right position. Just you can get into 
>weird bugs when any function modifies their argument because it'll be still 
>modified after syscall restart but only depending if the compiler used a 
>temporary register or not.

For IA64 you *must* use asmlinkage because the first 8 parameters are
passed in registers.  gcc will happily modify the register values which
will mess up syscall restart, unless you use asmlinkage to force gcc to
take copies of parameters and modify the copies.

