Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbTGGKaU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 06:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264786AbTGGKaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 06:30:20 -0400
Received: from 65-124-64-15.rdsl.ktc.com ([65.124.64.15]:5866 "EHLO
	csi.csimillwork.com") by vger.kernel.org with ESMTP id S262165AbTGGKaQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 06:30:16 -0400
Content-Type: text/plain; charset=US-ASCII
From: joe briggs <jbriggs@briggsmedia.com>
Organization: BMS
To: Andrew Morton <akpm@osdl.org>, vincent.touquet@pandora.be
Subject: Re: [Bug report] System lockups on Tyan S2469 and lots of io [smp boot time problems too :(]
Date: Mon, 7 Jul 2003 07:43:27 -0400
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <20030706210243.GA25645@lea.ulyssis.org> <20030707005449.GF4675@ns.mine.dnsalias.org> <20030706191941.33f9e37a.akpm@osdl.org>
In-Reply-To: <20030706191941.33f9e37a.akpm@osdl.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200307070743.27084.jbriggs@briggsmedia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was pulling my hair out (whats left of it) last week trying to get a Tyan 
2466 dual AMD 2800 MP (512 MB REGISTERED DDR, 3ware 7000-2 w/2 WD2000 drives 
and a WD800 IDE system drive, 2.4.21 Debian, ReiserFS) to run reliably under 
heavy disk and i/o (16 frame grabbers running a surveillance application).  
Eventually I would get "hda: missed interrupt .." and soon after ReiserFS 
file corruption.  I suspected memory and tried unbuffered DDR, and 4 
manufacturers of buffered DDR, all with the same results.  So I took pulled 
out the system drive, 3ware controllers and data drives, and frame grabbers 
and put them on a Intel P4/Intel motherboard, and everything booted and 
worked like a charm (though with more CPU load).  So I am wondering now if 
this file system corruption under heavy i/o load has something to do with SMP 
code?

On Sunday 06 July 2003 10:19 pm, Andrew Morton wrote:
> Vincent Touquet <vincent.touquet@pandora.be> wrote:
> > On Mon, Jul 07, 2003 at 02:30:07AM +0200, Vincent Touquet wrote:
> > >PS: will test if the system still locks up soon, I hope not...
> >
> > So it does lock up again :(((
> >
> > But now I was able to quickly switch to console and grab the contents of
> > /var/log/messages before it totally hanged. I can usually tell when the
> > hang is going to happen: activity on the array stops, then I have a few
> > more seconds till it hangs completely ....
> >
> > The message was:
> >
> > Jul 7 02:45:36 kalimero kernel: 3w-xxxx: scsi0: Unit #0:
> > command (f7618800) timed out, resetting card.
> >
> > Then of course, the system totally hangs.
>
> The next step would be to try some older versions.  There was a big 3ware
> update between 2.5.64 and 2.5.65.  Can you try both of those?
>
> hmm, I see a "fixme" and an interruptible_sleep_on_timeout() around that
> error message.  Do the hangs happen on uniprocessor, non-preemptible
> kernels?
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Joe Briggs
Briggs Media Systems
105 Burnsen Ave.
Manchester NH 01304 USA
TEL 603-232-3115 FAX 603-625-5809 MOBILE 603-493-2386
www.briggsmedia.com
