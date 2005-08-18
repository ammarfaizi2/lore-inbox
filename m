Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbVHRSsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbVHRSsJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 14:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbVHRSsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 14:48:08 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:147 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932398AbVHRSsH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 14:48:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XEjh+v2NgU25KFLmQMKqMurcWwRcLrKWRxK/6npulJh5F+lax0t6E8ou4I4fAXERUmmJDd8ceP+BV1jQ9sbTxpC+IeqT9faA0j1evMLihTuNQF8ZOxIE2CYjJcrj0t5+XLQVdHP3Lvc9StSsWS2ZlC0V3dY8si98tp+S/rz05gE=
Message-ID: <4fec73ca05081811488ec518e@mail.gmail.com>
Date: Thu, 18 Aug 2005 20:48:04 +0200
From: =?ISO-8859-1?Q?Guillermo_L=F3pez_Alejos?= <glalejos@gmail.com>
To: Linh Dang <linhd@nortel.com>
Subject: Re: Environment variables inside the kernel?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <wn5slx75cjs.fsf@linhd-2.ca.nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4fec73ca050818084467f04c31@mail.gmail.com>
	 <m2ek8r5hhh.fsf@Douglas-McNaughts-Powerbook.local>
	 <wn5slx75cjs.fsf@linhd-2.ca.nortel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whoa!, I did not expect so many replies. Thank you for your answers.

The thing is that the Computer Architecture area of the University I
am studying at is developing a parallel filesystem. Currently it works
as a stand-alone program (this is why it uses resources like
environment variables), and I have been told to integrate it in the
Linux kernel.

I have to justify changes on this filesystem code (like avoiding the
use of environment variables) to my tutor. In this case I needed to
find why it is not possible to use environment variables in kernel
space.

I was looking for a reference documentation which give a definition of
environment variables that exclude their use inside the kernel, or,
simply, I expected to find a design decision to justify this. But I
think I have enough information with your answers, I will be able to
elaborate a satisfactory conclusion.

Excuse me if the topic was so obvious (it was not to me) and thank you again,

On 8/18/05, Linh Dang <linhd@nortel.com> wrote:
> Douglas McNaught <doug@mcnaught.org> wrote:
> 
> >
> > If someone is insisting you use environment varaiables in kernel
> > code, challenge them to show you where they are implemented in the
> > kernel.  :)
> >
> > -Doug
> 
> They're in current process's vm. You just have to parse it yourself.
> 
> something along the (untested) lines:
> 
>         struct mm_struct *mm = current ? get_task_mm(current) : NULL;
> 
>         if (mm) {
>                 unsigned env_len = mm->env_end - mm->env_start;
>                 char* env = kmalloc(env_len, GFP_KERNEL);
>                 access_process_vm(current, mm->env_start, env,
>                                            env_len, 0);
> 
>                 /* env is now a big buffer containing null-terminated
>                    strings representing evironment variables */
> 
>                 mmput(mm);
>         }

-- 
Guillermo
