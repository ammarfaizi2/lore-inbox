Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268568AbUIQNEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268568AbUIQNEw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 09:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268730AbUIQNEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 09:04:51 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:23310 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S268568AbUIQNEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 09:04:48 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: top hogs CPU in 2.6: kallsyms_lookup is very slow
Date: Fri, 17 Sep 2004 16:04:39 +0300
User-Agent: KMail/1.5.4
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
References: <200409161428.27425.vda@port.imtp.ilyichevsk.odessa.ua> <200409171421.15470.vda@port.imtp.ilyichevsk.odessa.ua> <20040917121040.GN9106@holomorphy.com>
In-Reply-To: <20040917121040.GN9106@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409171604.39622.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 September 2004 15:10, William Lee Irwin III wrote:
> On Thu, Sep 16, 2004 at 02:57:08PM +0300, Denis Vlasenko wrote:
> >> Did the kallsyms patches reduce the cpu overhead from get_wchan()? I take
> >> this to mean reducing HZ to 100 did not alleviate the syscall problems?
> >> How do microbenchmarks fare, e.g. lmbench?
> 
> On Fri, Sep 17, 2004 at 02:21:15PM +0300, Denis Vlasenko wrote:
> > 2x3 lmbench runs. HZ=100, configs attached.
> > Context switching - times in microseconds - smaller is better
> > -------------------------------------------------------------------------
> > Host                 OS  2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
> >                          ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
> > --------- ------------- ------ ------ ------ ------ ------ ------- -------
> > hunter    Linux 2.6.9-r   31.9   64.0  120.8  115.7  322.2   136.0   356.4
> > hunter    Linux 2.6.9-r   29.1   47.2   76.7  102.3  321.5   136.0   354.2
> > hunter    Linux 2.6.9-r   29.3   56.0  144.5  101.9  305.5   145.3   351.0
> > hunter    Linux 2.4.27-   19.8   39.4  190.3   77.8  368.0   104.1   401.5
> > hunter    Linux 2.4.27-   19.7   30.9  105.0   87.2  316.9   107.2   359.9
> > hunter    Linux 2.4.27-   19.5   34.6   95.5   74.3  279.1   109.5   325.0
> 
> Bizarre; context switching latency is actually one of the 2.6
> scheduler's strong points AFAIK. This generally needs NMI's to
> instrument as the critical sections here have interrupts disabled.
> Someone more knowledgable regarding the i8259A PIC may have ideas about
> how to go about arranging for NMI-based profiling on a system such as
> yours. I presume this is a Pentium "Classic", not Pentium Pro.

Yes. Ther is no Pentium 66 MMX on this planet.

> Alan, any ideas?
> 
> 
> On Fri, Sep 17, 2004 at 02:21:15PM +0300, Denis Vlasenko wrote:
> > *Local* Communication latencies in microseconds - smaller is better
> > ---------------------------------------------------------------------
> > Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
> >                         ctxsw       UNIX         UDP         TCP conn
> > --------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
> > hunter    Linux 2.6.9-r  31.9 129.8 230.                             
> > hunter    Linux 2.6.9-r  29.1 130.1 244.                             
> > hunter    Linux 2.6.9-r  29.3 136.9 233.                             
> > hunter    Linux 2.4.27-  19.8  74.0 146.                             
> > hunter    Linux 2.4.27-  19.7  74.4 134.                             
> > hunter    Linux 2.4.27-  19.5  77.8 137.                             
> 
> Degradation #2: pipe and AF_UNIX latencies. This can likely be profiled
> without NMI's.

Is there an easy way to run only this one? I can profile that.
Larry? 

--
vda

