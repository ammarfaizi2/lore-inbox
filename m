Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289089AbSAIXpf>; Wed, 9 Jan 2002 18:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289091AbSAIXp0>; Wed, 9 Jan 2002 18:45:26 -0500
Received: from jalon.able.es ([212.97.163.2]:5353 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S289089AbSAIXpP>;
	Wed, 9 Jan 2002 18:45:15 -0500
Date: Thu, 10 Jan 2002 00:49:52 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: =?iso-8859-1?Q?G=E9rard?= Roudier <groudier@free.fr>
Cc: jtv <jtv@xs4all.nl>, Tim Hollebeek <tim@hollebeek.com>,
        Bernard Dautrevaux <Dautrevaux@microprocess.com>,
        "'dewar@gnat.com'" <dewar@gnat.com>, paulus@samba.org, gcc@gcc.gnu.org,
        linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
        velco@fadata.bg
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020110004952.A11641@werewolf.able.es>
In-Reply-To: <20020108012734.E23665@werewolf.able.es> <20020109204043.T1027-100000@gerard>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020109204043.T1027-100000@gerard>; from groudier@free.fr on Wed, Jan 09, 2002 at 20:47:15 +0100
X-Mailer: Balsa 1.3.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20020109 Gérard Roudier wrote:
>
>
>On Tue, 8 Jan 2002, J.A. Magallon wrote:
>
>>
>> On 20020107 jtv wrote:
>> >
>> >Let's say we have this simplified version of the problem:
>> >
>> >	int a = 3;
>> >	{
>> >		volatile int b = 10;
>>
>>     >>>>>>>>> here b changes
>
>Hmmm...
>Then your hardware is probably broken or may-be you are dreaming. :-)
>
>There is nothing in this code that requires the compiler to allocate
>memory for 'b'. You just invent the volatile constant concept. :)
>
>> >		a += b;
>> >	}
>> >
>> >Is there really language in the Standard preventing the compiler from
>> >constant-folding this code to "int a = 13;"?
>

Grrr. I really do not know why people is making so noise about volatile.
Don't look for esoteric meanings, it is just 'don't suppose ANYTHING
about this memory location, it CAN CNAHGE apart from anything you can
see or guess'.

Even

int	b;
volatile const int a = 5;
b = a - a;

can not be optimized to 

b = 0;

Why ? Write it in someking of ideal assembler:

dec stack-ptr to make room for b
dec stack-ptr to make room for a
put 5 in a
push a
push a (again)
sub
pop b

And a CAN change between the two pushes. It is not resposibility of the
compiler to try to be clever than the programmer, if the volatile is there
is for a reason (it can be a hardware mapped register like a DAC,
or who knows).
In the (in)famous example above the compiler should not convert to a += 13.
If it is expected to do it, then the (in)famous is the programmer who
put a volatile in a local variable. Usually a mapped register would
be a 'volatile extern int my_reg'.


-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.18-pre2-beo #2 SMP Wed Jan 9 02:23:27 CET 2002 i686
