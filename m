Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262246AbUBXMwT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 07:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbUBXMwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 07:52:19 -0500
Received: from chaos.analogic.com ([204.178.40.224]:65408 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262246AbUBXMwP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 07:52:15 -0500
Date: Tue, 24 Feb 2004 07:53:29 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       David Wagner <daw@eecs.berkeley.edu>
Subject: Re: &array considered harmful?
In-Reply-To: <1077574309.16259.4.camel@dooby.cs.berkeley.edu>
Message-ID: <Pine.LNX.4.53.0402240747500.6991@chaos>
References: <1077574309.16259.4.camel@dooby.cs.berkeley.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Feb 2004, Robert T. Johnson wrote:

> The kernel has lots of code that takes the address of a local array.
> This works, but it's fragile.  I'd be happy to submit a patch if
> everyone agrees that this is a bad programming practice.
>
> Here's an example of a program that takes the address of an array:
>
> void func(void)
> {
>         char A[10];
>         ....
>         memset(&A, 0, sizeof(A));
> }
>

[SNIPPED...]
You are preaching to the choir when it comes to code like that.
However, even lint allows it! I first thought it was a GNUism
just like void-pointer math being allowed. But, when Lint says
it's okay, I don't think there is any technical reason for
not allowing it because Lint is the most pedantic of pedantica.

Script started on Tue Feb 24 07:46:23 2004
# cat xxx.c
#include <stdio.h>
int main(void);
int main()
{
    char foo[0x10];
    printf("%p\n", foo);
    printf("%p\n", &foo[0]);
    printf("%p\n", &foo);
    return 0;
}
# gcc -Wall --pedantic -o xxx xxx.c
# lint xxx.c
LCLint 2.2a --- 04 Sep 96
Finished LCLint checking --- no code errors found
# exit
exit
Script done on Tue Feb 24 07:47:03 2004

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.

