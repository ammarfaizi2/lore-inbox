Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261956AbUJYPuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbUJYPuE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 11:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbUJYPcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:32:31 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:42251 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261976AbUJYPbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 11:31:22 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: Temporary NFS problem when rpciod is SIGKILLed
Date: Mon, 25 Oct 2004 18:31:10 +0300
User-Agent: KMail/1.5.4
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
References: <200410251702.58622.vda@port.imtp.ilyichevsk.odessa.ua> <200410251812.28663.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.53.0410251717320.19116@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.53.0410251717320.19116@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410251831.10849.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 October 2004 18:20, Jan Engelhardt wrote:
> >That's the point. It works in 2.4
> 
> Maybe because there is no rpciod in 2.4?

It is there.

> >Well, let's see. 2.4 works. rpciod in 2.6 shows this erratic behaviour
> >even if I do "kill -9 <pid_of_rpciod>", thus no other process, kernel
> >or userspace, know about this KILL.
> 
> Is rpciod (a kthread as I read from your 'ps' output) killable in 2.4 after
> all?

It is not killable, neither 2.4 nor 2.6 one. It is by design I think,
because I *must not* kill it, or else NFS rootfs will fall off
and box will hang.

However, rpciod gets signalled by -KILL as a side effect of killall5 -9
when I shut my system down.

I do not send -KILL to all processes EXCEPT rpciod because:
(a) there is no suitable command to do that from shell and
(b) I don't like special cases

> Maybe the rpciod-26 is missing a sigblock()?
--
vda

