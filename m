Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274885AbRIVBkY>; Fri, 21 Sep 2001 21:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274887AbRIVBkP>; Fri, 21 Sep 2001 21:40:15 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:58383 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S274885AbRIVBkA>;
	Fri, 21 Sep 2001 21:40:00 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Stephen Torri <storri@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Announce: ksymoops 2.4.3 is available 
In-Reply-To: Your message of "Fri, 21 Sep 2001 12:43:21 -0400."
             <Pine.LNX.4.33.0109211238010.1454-100000@base.torri.linux> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 22 Sep 2001 11:39:12 +1000
Message-ID: <15764.1001122752@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2001 12:43:21 -0400 (EDT), 
Stephen Torri <storri@ameritech.net> wrote:
>ksymoops.c:114:1: directives may not be used inside a macro argument

Some versions of glibc define prinf as a macro instead of a function.
That is quite legal but it stops you using #ifdef inside printf calls.
I will change ksymoops to work around that.

>symbol.c:220:58: warning: trigraph ??> ignored
>symbol.c:221:44: warning: trigraph ??> ignored
>symbol.c:225:49: warning: trigraph ??> ignored
>symbol.c:226:35: warning: trigraph ??> ignored

I believe that is a gcc bug.  The text is
            snprintf(map, size,
                     options->hex ? "<END_OF_CODE+%llx/????>"
                    : "<END_OF_CODE+%lld/????>",
                offset);
gcc is complaining about trigraphs but they are inside a string
constant, not in code.  IMHO gcc should not flag trigraphs in string
constants, report it as a gcc bug.

