Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbUBFS5K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 13:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265791AbUBFS5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 13:57:10 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:43302 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263185AbUBFS4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 13:56:49 -0500
Message-ID: <4023E490.7060608@veritas.com>
Date: Fri, 06 Feb 2004 11:01:36 -0800
From: somenath <somenath@veritas.com>
Reply-To: somenath@veritas.com
Organization: Veritas Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Dreier <roland@topspin.com>
CC: root@chaos.analogic.com, "Hefty, Sean" <sean.hefty@intel.com>,
       Troy Benjegerdes <hozer@hozed.org>,
       infiniband-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in  
  theLinux kernel
References: <C1B7430B33A4B14F80D29B5126C5E9470326258C@orsmsx401.jf.intel.com>     <Pine.LNX.4.53.0402061150100.3862@chaos> <52smhounpn.fsf@topspin.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That's one of the many reasons of using do-while macros..
Other than compilation error, it may generate wrong code too!
this is a FAQ in kernel newbies , look at:
http://www.kernelnewbies.org/faq/index.php3#dowhile

thanks, som.

Roland Dreier wrote:

>    Richard> If some major changes are being considered, I think it's
>    Richard> time to get rid of the:
>
>    Richard> do { } while(0) stuff that permiates a lot of MACROS and
>    Richard> just use the { } as they were designed.
>
>    Richard> Before everybody screams, think. It's perfectly correct
>    Richard> to start a new "program unit" without a conditional
>    Richard> expression.  You just add a curley-brace, then close the
>    Richard> brace when you are though.
>
>This is totally, totally wrong.  If you get rid of do { } while (0),
>then you can't use the macro in an if statement.  Read any C FAQ for
>details, or try the following:
>
>    #define MAC(x) { x = x + 1; }
>
>    int main() {
>      int x = 0;
>
>      if (1)
>        MAC(x);
>      else
>        x = x - 1;
>    }
>
>I get the following (correct) error:
>
>    $ gcc a.c
>    a.c: In function `main':
>    a.c:8: syntax error before "else"
>    $ gcc --version
>    gcc (GCC) 3.2.3 20030502 (Red Hat Linux 3.2.3-20)
>
>because
>
>    if (1)
>        { x = x + 1 } ; /* <-- note semicolon
>    else
>        x = x - 1;
>
>is not correct C.
>
>By the way, it is possible to use parentheses and commas for some
>simple macros, so for example the following is OK:
>
>    #define MAC(x) ( x = x + 1, x = x * 2 )
>
>    int main() {
>      int x = 0;
>
>      if (1)
>        MAC(x);
>      else
>        x = x - 1;
>    }
>
>However I don't see anything wrong with the perfectly standard "do { }
>while (0)" idiom.  Certainly if some compiler generates worse code for
>that construct that just a plain { }, _that_ is a compiler bug that we
>shouldn't have to work around.
>
> - Roland
>
>
>-------------------------------------------------------
>The SF.Net email is sponsored by EclipseCon 2004
>Premiere Conference on Open Tools Development and Integration
>See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
>http://www.eclipsecon.org/osdn
>_______________________________________________
>Infiniband-general mailing list
>Infiniband-general@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/infiniband-general
>  
>



