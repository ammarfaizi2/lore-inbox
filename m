Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316273AbSELBHA>; Sat, 11 May 2002 21:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316291AbSELBG7>; Sat, 11 May 2002 21:06:59 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:48395 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S316273AbSELBG7>;
	Sat, 11 May 2002 21:06:59 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Ron Gage <ron@rongage.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question about module.[c,h] - kernel 2.4.18 
In-Reply-To: Your message of "11 May 2002 20:33:09 -0400."
             <1021163601.558.32.camel@portable> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 12 May 2002 11:06:47 +1000
Message-ID: <17380.1021165607@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 May 2002 20:33:09 -0400, 
Ron Gage <ron@rongage.org> wrote:
>I came across a fairly major inconsistancy in module.c and module.h and
>I was hoping someone could tell me just how whacked my view of this
>is...
>In essence, there are 20 elements to the module struct (i386), but
>module.c only initializes 9 of those elements.  This gives 11
>uninitialized elements (and compile warnings).  These warnings are what
>I am trying to kill off.  

struct module has static storage duration, all elements are
automatically set to 0 unless otherwise defined.

Which compiler is giving warnings?  If you are using a compiler that
requires all elements of a static storage variable be initialized then
it appears to be in violation of the C standard.

  6.7.8 Initialization

  19 The initialization shall occur in initializer list order, each
     initializer provided for a particular subobject overriding any
     previously listed initializer for the same subobject; all
     subobjects that are not initialized explicitly shall be
     initialized implicitly the same as objects that have static
     storage duration.

Static storage duration objects are set to 0.

