Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269438AbRHCQLU>; Fri, 3 Aug 2001 12:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269437AbRHCQLK>; Fri, 3 Aug 2001 12:11:10 -0400
Received: from smtp.kolej.mff.cuni.cz ([195.113.25.225]:27141 "EHLO
	smtp.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S269438AbRHCQLD> convert rfc822-to-8bit; Fri, 3 Aug 2001 12:11:03 -0400
Date: Fri, 3 Aug 2001 18:11:12 +0200
From: =?iso-8859-2?Q?Martin_Ma=E8ok?= <martin.macok@underground.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: fake loop
Message-ID: <20010803181112.F25738@sarah.kolej.mff.cuni.cz>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010803155735.18620.qmail@nwcst31f.netaddress.usa.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010803155735.18620.qmail@nwcst31f.netaddress.usa.net>; from ailinykh@usa.net on Fri, Aug 03, 2001 at 09:57:34AM -0600
X-Echelon: GRU NSA GCHQ KGB CIA nuclear conspiration war weapon spy agent
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 03, 2001 at 09:57:34AM -0600, Andrey Ilinykh wrote:
> #define prepare_to_switch()     do { } while(0)
> 
> Who can explain me a reason for these fake loops?

http://kernelnewbies.org/faq/index.php3#dowhile.xml

There are a couple of reasons:

    * (from Dave Miller) Empty statements give a warning from the compiler so
        this is why you see #define FOO do { } while(0). 
    * (from Dave Miller) It gives
        you a basic block in which to declare local variables.
    * (from Ben Collins) It allows you to use more complex macros in
        conditional code. Imagine a macro of several lines of code like:

#define FOO(x) \
        printf("arg is %s\n", x); \
        do_something_useful(x);

      Now imagine using it like:

if (blah == 2)
                FOO(blah);

      This interprets to:

if (blah == 2)
                printf("arg is %s\n", blah);
                do_something_useful(blah);;

      As you can see, the if then only encompasses the printf(), and the
do_something_useful() call is unconditional (not within the scope of the if),
like you wanted it. So, by using a block like do{...}while(0), you would get
this:

if (blah == 2)
                do {
                        printf("arg is %s\n", blah);
                        do_something_useful(blah);
                } while (0);

      Which is exactly what you want.

Have a nice day

-- 
   Martin Maèok
  underground.cz
    openbsd.cz
