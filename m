Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286171AbRLTGyD>; Thu, 20 Dec 2001 01:54:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285024AbRLTGx5>; Thu, 20 Dec 2001 01:53:57 -0500
Received: from ns01.netrox.net ([64.118.231.130]:55223 "EHLO smtp01.netrox.net")
	by vger.kernel.org with ESMTP id <S286171AbRLTGxr>;
	Thu, 20 Dec 2001 01:53:47 -0500
Subject: Re: Scheduler, Can we save some juice ...
From: Robert Love <rml@tech9.net>
To: timothy.covell@ashavan.org
Cc: Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        Benjamin LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Davide Libenzi <davidel@xmailserver.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200112200637.fBK6b2Sr014173@svr3.applink.net>
In-Reply-To: <Pine.LNX.4.33L.0112200149330.15741-100000@imladris.surriel.com> 
	<200112200637.fBK6b2Sr014173@svr3.applink.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 20 Dec 2001 01:52:47 -0500
Message-Id: <1008831171.806.14.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-12-20 at 01:33, Timothy Covell wrote:

> OK, here's another 0.1% for you.  Considering how Linux SMP
> doesn't have high CPU affinity, would it be possible to make a
> patch such that the additional CPUs remain in deep sleep/HALT
> mode until the first CPU hits a high-water mark of say 90% 
> utilization?  I've started doing this by hand with the (x)pulse
> application.   My goal is to save electricity and cut down on 
> excess heat when I'm just browsing the web and not compiling
> or seti@home'ing.

You'd probably be better off working against load and not CPU usage,
since a single app can hit you at 100% CPU.  Load average is the sort of
metric you want, since if there is more than 1 task waiting to run on
average, you will benefit from multiple CPUs.

That said, this would be easy to do in user space using the hotplug CPU
patch.  Monitor load average (just like any X applet does) and when it
crosses over the threshold: "echo 1 > /proc/sys/cpu/2/online"

Another solution would be to use CPU affinity to lock init (and thus all
tasks) to 0x00000001 or whatever and then start allowing 0x00000002 or
whatever when load gets too high.

My point: it is awful easy in user space.

	Robert Love

