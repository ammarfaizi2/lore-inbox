Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262657AbVENAzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262657AbVENAzY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 20:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262658AbVENAzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 20:55:23 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:29972 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262657AbVENAxL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 20:53:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dBCkwDt0ZZ9e4ijdhBTYAmleZMJzjRv1XlcJI6SGBjyufRX5ZiVpUxvYVSQzqMrp0bp+CmswGd0GsTsTqozzKRlxB1/ICsjUmBGgnaTLeCjJlow5KYGR/y6RxdgAgbcdhGXhdbUouMKGJ2SfZ4UeBgqweMrCJ3SMVeI7mDrFtBs=
Message-ID: <fc67f8b70505131753103d2dc7@mail.gmail.com>
Date: Fri, 13 May 2005 20:53:11 -0400
From: Ritesh Kumar <digitalove@gmail.com>
Reply-To: ritesh@cs.unc.edu
To: Jakub Jelinek <jakub@redhat.com>
Subject: Re: NPTL: stack limit limiting number of threads
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <20050514000643.GI17420@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <fc67f8b705051312494a0badf7@mail.gmail.com>
	 <20050513202346.GG17420@devserv.devel.redhat.com>
	 <fc67f8b705051317023859c443@mail.gmail.com>
	 <20050514000643.GI17420@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/05, Jakub Jelinek <jakub@redhat.com> wrote:
> On Fri, May 13, 2005 at 08:02:48PM -0400, Ritesh Kumar wrote:
> >     Thanks for your reply. I actually went ahead after getting your
> > mail and coded up a small program to check the stack limit
> > deliberately. The program is shown inline.
> >
> > #include <stdio.h>
> >
> > #define BUF_SIZE 1024000
> >
> > void recurse(int n){
> >       char ch[BUF_SIZE];
> >       if(n<=0)
> >               return;
> >       else
> >               recurse(n-1);
> > }
> >
> > int main(argc, argv)
> >       int argc;
> >       char **argv;
> > {
> >       if(argc!=2){
> >               printf("Usage: %s <n (megabytes)>\n", argv[0]);
> >               return 1;
> >       }
> >       printf("Checking for %dMB\n", atoi(argv[1]));
> >       recurse(atoi(argv[1]));
> > }
> >
> > Its a fairly crude way to find out the actual stack limit. Basically,
> > the resurse function recurses each time allocating ~1MB of space on
> > the stack. The program segfaults exactly at the ulimit -s value of
> > stack size on both linux and freebsd. So it does seem that the ulimit
> > -s is the value of stack limit used on FreeBSD.
> 
> For the main stack sure.  But now try to call that recurse in
> some other thread.
> 
>         Jakub
> 

Oh great... I see your point now. I called the same recurse in an
alternative thread and found the limit to be 8M on Linux ( and Mac OS
X (Panther)) but around 1MB on FreeBSD. Thanks for the clarification!

Ritesh 

-- 
http://www.cs.unc.edu/~ritesh/
