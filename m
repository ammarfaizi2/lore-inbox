Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbWEMLRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbWEMLRP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 07:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWEMLRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 07:17:15 -0400
Received: from 0x55511dab.adsl.cybercity.dk ([85.81.29.171]:34359 "EHLO
	hunin.borkware.net") by vger.kernel.org with ESMTP id S1751037AbWEMLRO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 07:17:14 -0400
From: Mark Rosenstand <mark@borkware.net>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Executable shell scripts
In-Reply-To: <1147518432.3217.2.camel@laptopd505.fenrus.org>
References: <20060513103841.B6683146AF@hunin.borkware.net>
	<1147517786.3217.0.camel@laptopd505.fenrus.org>
	<20060513110324.10A38146AF@hunin.borkware.net>
	<1147518432.3217.2.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20060513111713.8031C146CA@hunin.borkware.net>
Date: Sat, 13 May 2006 13:17:13 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:
> On Sat, 2006-05-13 at 13:03 +0200, Mark Rosenstand wrote:
> > Arjan van de Ven <arjan@infradead.org> wrote:
> > > On Sat, 2006-05-13 at 12:38 +0200, Mark Rosenstand wrote:
> > > > Hi,
> > > > 
> > > > Is it in any (reasonable) way possible to make Linux support executable
> > > > shell scripts? Perhaps through binfmt_misc?
> > > 
> > > ehhhhhh this is already supposed to work.
> > 
> > It doesn't:
> > 
> > bash-3.00$ cat << EOF > test
> > > #!/bin/sh
> > > echo "yay, I'm executing!"
> > > EOF
> > bash-3.00$ chmod 111 test
> > bash-3.00$ ./test
> > /bin/sh: ./test: Permission denied
> 
> is your script readable as well? 111 is just weird/odd.

No, it's executable. This is what makes executable shell scripts
distinct from feeding the file to an interpreter.

>From http://www.faqs.org/faqs/unix-faq/faq/part4/section-7.html:

      The script is called `executable' because just like a real
      (binary) executable it starts with a so-called `magic number'
      indicating the type of the executable.  In our case this number is
      `#!' and the OS takes the rest of the first line as the
      interpreter for the script, possibly followed by 1 initial option
      like:

        #!/bin/sed -f

      Suppose this script is called `foo' and is found in /bin,
      then if you type:

        foo arg1 arg2 arg3

      the OS will rearrange things as though you had typed:

        /bin/sed -f /bin/foo arg1 arg2 arg3

      There is one difference though: if the setuid permission bit for
      `foo' is set, it will be honored in the first form of the
      command; if you really type the second form, the OS will honor
      the permission bits of /bin/sed, which is not setuid, of course.
