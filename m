Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272329AbSISSxE>; Thu, 19 Sep 2002 14:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272334AbSISSxE>; Thu, 19 Sep 2002 14:53:04 -0400
Received: from are.twiddle.net ([64.81.246.98]:9623 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S272329AbSISSxD>;
	Thu, 19 Sep 2002 14:53:03 -0400
Date: Thu, 19 Sep 2002 11:57:47 -0700
From: Richard Henderson <rth@twiddle.net>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       dvorak <dvorak@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: Syscall changes registers beyond %eax, on linux-i386
Message-ID: <20020919115747.A22594@twiddle.net>
Mail-Followup-To: Brian Gerst <bgerst@didntduck.org>,
	Petr Vandrovec <VANDROVE@vc.cvut.cz>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	dvorak <dvorak@xs4all.nl>, linux-kernel@vger.kernel.org
References: <24181C771D3@vcnet.vc.cvut.cz> <3D8A11BB.4090100@didntduck.org> <20020919113048.A22520@twiddle.net> <3D8A1CC0.8070407@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D8A1CC0.8070407@didntduck.org>; from bgerst@didntduck.org on Thu, Sep 19, 2002 at 02:51:44PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2002 at 02:51:44PM -0400, Brian Gerst wrote:
> > The parameter area belongs to the callee, and it may *always* be modified.
> 
> The parameters can not be modified if they are declared const though, 
> that's my point.

Yes they can.

	extern void bar(int x, int y, int z);
	void foo(const int a, const int b, const int c)
	{
	  bar(a+1, b+1, c+1);
	}

        subl    $12, %esp
        movl    20(%esp), %eax
        incl    %eax
        movl    %eax, 20(%esp)
        movl    16(%esp), %eax
        incl    %eax
        incl    24(%esp)
        movl    %eax, 16(%esp)
        addl    $12, %esp
        jmp     bar

(Not sure why gcc doesn't use incl on all three memories, nor
should it allocate that stack frame...)


r~
