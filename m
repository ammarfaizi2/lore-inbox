Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311246AbSCQBpd>; Sat, 16 Mar 2002 20:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311251AbSCQBp0>; Sat, 16 Mar 2002 20:45:26 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:13572 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S311246AbSCQBpP>;
	Sat, 16 Mar 2002 20:45:15 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Anton Blanchard <anton@samba.org>, lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] 7.52 second kernel compile 
In-Reply-To: Your message of "Sat, 16 Mar 2002 09:37:00 -0800."
             <730219199.1016271418@[10.10.2.3]> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 17 Mar 2002 12:45:03 +1100
Message-ID: <25310.1016329503@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Mar 2002 09:37:00 -0800, 
"Martin J. Bligh" <Martin.Bligh@us.ibm.com> wrote:
>Are you still doing something like this?
># MAKE="make -j14" /usr/bin/time make -j14 bzImage
>
>I tried setting the MAKE variable as well as doing the -j,
>but it actually made kernel compile time slower - what difference
>does it make on your machine? Can somebody clarify what this
>actually does, as opposed to the -j on the command line?

It depends on which version of make you are using.  make 3.78 onwards
has a built in job scheduler which shares the value of -j across its
children, yea unto the nth generation.  Earlier versions of make did a
simplistic 'run -j copies of make at the top level' and did not
propagate -j to the lower levels.

With the recursive makefiles and make < 3.78 you need MAKE="make -j" to
get a decent speedup because of the lack of choices at the top level
Makefile.  With make >= 3.79 you do not need MAKE="make -j14", it can
interfere with make's own scheduler.  See also make -l LOAD.

