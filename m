Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288235AbSACHmp>; Thu, 3 Jan 2002 02:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288244AbSACHmf>; Thu, 3 Jan 2002 02:42:35 -0500
Received: from 12-234-19-19.client.attbi.com ([12.234.19.19]:51982 "HELO
	ocean.lucon.org") by vger.kernel.org with SMTP id <S288241AbSACHm3>;
	Thu, 3 Jan 2002 02:42:29 -0500
Date: Wed, 2 Jan 2002 23:42:26 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Andrew Morton <akpm@zip.com.au>
Cc: Momchil Velikov <velco@fadata.bg>, Oliver Xymoron <oxymoron@waste.org>,
        vda <vda@port.imtp.ilyichevsk.odessa.ua>, linux-kernel@vger.kernel.org
Subject: Re: Extern variables in *.c files
Message-ID: <20020102234226.A23580@lucon.org>
In-Reply-To: <02010216180403.01928@manta> <Pine.LNX.4.43.0201021322120.30079-100000@waste.org> <3C337EF1.4C7C72AB@zip.com.au>, <3C337EF1.4C7C72AB@zip.com.au> <87ell8wgo9.fsf@fadata.bg> <3C340601.E9A3507F@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C340601.E9A3507F@zip.com.au>; from akpm@zip.com.au on Wed, Jan 02, 2002 at 11:19:29PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 11:19:29PM -0800, Andrew Morton wrote:
> 
> Alas, it doesn't quite work as we'd like:
> 
> akpm-1:/home/akpm> cat a.c
> int a;
> 
> main()
> {}
> akpm-1:/home/akpm> cat b.c
> extern char a;
> 
> int b()
> {return a;}
> akpm-1:/home/akpm> gcc -fno-common -Wl,--warn-common a.c b.c
> akpm-1:/home/akpm> 
> 
> No warnings emitted.  If b.c doesn't use `extern' it will fail
> to link because of -fno-common.
> 
> What we'd *like* to happen is for the linker to determine that
> the `extern char' and the `int' declarations are a mismatch.
> Maybe the object file doesn't have the size info for `extern'
> variables.   The compiler emits it though.
> 

Compile doesn't emit the size info for

extern char a;

One way to fix it is to remove

extern char a;

and put

extern int a;

in a header file which is included by everyone.


H.J.
