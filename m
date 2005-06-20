Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbVFTPkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVFTPkt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 11:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVFTPkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 11:40:49 -0400
Received: from alog0018.analogic.com ([208.224.220.33]:17113 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261355AbVFTPkb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 11:40:31 -0400
Date: Mon, 20 Jun 2005 11:40:24 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: "Srinivas G." <srinivasg@esntechnologies.co.in>
cc: linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: how to insert an asm instruction in C code and how to compile
 it
In-Reply-To: <4EE0CBA31942E547B99B3D4BFAB348115AB385@mail.esn.co.in>
Message-ID: <Pine.LNX.4.61.0506201134480.7242@chaos.analogic.com>
References: <4EE0CBA31942E547B99B3D4BFAB348115AB385@mail.esn.co.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jun 2005, Srinivas G. wrote:

> Dear All,
>
> I am very sorry for asking such a silly question here.
>
> I have small doubt about ASM code in a C program. Actually I want to
> insert some asm instructions in a C program and after that I want to
> compile the C program.
>
> I want to include the following code in a simple C program and compile
> it.
>

Well, even if you could make the correct assembly, you would
not be able to run the BIOS-based program that you show. As
soon as you execute the interrupt 0x10, your program will seg-fault
because it is an invalid instruction in user-mode code and
would even cause an invalid oprand fault in kernel mode.

The second problem with your code is that __all__ of the assembly
for the entire procedure must be written in one block, not
with seperate "asm" instructions. This is because 'C' isn't
going to preserve the values in the registers between "asm"
blocks.


> #define printf DbgPrint
>
> int main()
> {
> 	printf("Hello world program!\n");
> 	return 0;
> }
> void DbgPrint(char* str,...)
> {
> 	volatile USHORT i = 0;
>    	volatile UCHAR sch;
> 	while(str[i])
> 	{
> 		sch = str[i];
> 		i ++;
> 		asm mov ah,0x0E;
> 		asm mov al,sch;
>
> 		asm cmp	al,0ah
> 		asm jne	test
> 		asm mov	al,0dh     //; new line
> 		asm mov	bx,07h
> 		asm int	10h
> 		asm mov	al,0ah
> test:
> 		asm mov bx,0x07
> 		asm int 0x10
> 	}
> }
>
> Please let me know how to do it?
>
> Any links or Howtos are welcome.
> Thanks in advance.
>
> Regards,
> Srinivas G
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
