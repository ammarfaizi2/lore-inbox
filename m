Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263807AbTEMXZE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 19:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263808AbTEMXZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 19:25:04 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:23300 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263807AbTEMXZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 19:25:03 -0400
Date: Tue, 13 May 2003 16:33:23 -0700
From: Andrew Morton <akpm@digeo.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: root@chaos.analogic.com, felipe_alfaro@linuxmail.org, rmk@arm.linux.org.uk,
       paulkf@microgate.com, dahinds@users.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: PCMCIA 2.5.X sleeping from illegal context
Message-Id: <20030513163323.516ad04b.akpm@digeo.com>
In-Reply-To: <1052833031.432.11.camel@dhcp22.swansea.linux.org.uk>
References: <1052775331.1995.49.camel@diemos>
	<1052773631.31825.18.camel@dhcp22.swansea.linux.org.uk>
	<20030512233151.B17227@flint.arm.linux.org.uk>
	<1052781365.1185.5.camel@teapot.felipe-alfaro.com>
	<Pine.LNX.4.53.0305121929300.6225@chaos>
	<1052833031.432.11.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 May 2003 23:37:44.0839 (UTC) FILETIME=[A74A9970:01C319A8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> On Maw, 2003-05-13 at 00:36, Richard B. Johnson wrote:
> > Could somebody please change the error message? Although everybody
> > seems to want to be a lawyer, even lawyers don't make law. Certainly
> > Software Engineers don't. The correct word is 'invalid', not 'illegal'.
> > Yes, I know there is a 30-year history of the use of that word in
> > Unix, but it's wrong. Only governments make law.
> 
> Much to my suprise you are right on this. The reference dictionary is 
> quite explicit that "illegal" means prohibited by law. Since users will
> eventually see this message it perhaps does make sense to fix it
> 


diff -puN kernel/sched.c~might-sleep-fix kernel/sched.c
--- 25/kernel/sched.c~might-sleep-fix	Tue May 13 16:32:18 2003
+++ 25-akpm/kernel/sched.c	Tue May 13 16:32:46 2003
@@ -2842,8 +2842,8 @@ void __might_sleep(char *file, int line)
 		if (time_before(jiffies, prev_jiffy + HZ))
 			return;
 		prev_jiffy = jiffies;
-		printk(KERN_ERR "Debug: sleeping function called from illegal"
-				" context at %s:%d\n", file, line);
+		printk(KERN_ERR "Debug: sleeping in immoral context "
+					"at %s:%d\n", file, line);
 		dump_stack();
 	}
 #endif

_

