Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbUJYRkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbUJYRkA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 13:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbUJYRjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 13:39:44 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:44811 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261219AbUJYRi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 13:38:59 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: Temporary NFS problem when rpciod is SIGKILLed
Date: Mon, 25 Oct 2004 20:38:44 +0300
User-Agent: KMail/1.5.4
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
References: <200410251702.58622.vda@port.imtp.ilyichevsk.odessa.ua> <200410251831.10849.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.53.0410251746220.776@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.53.0410251746220.776@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410252038.44953.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 October 2004 18:46, Jan Engelhardt wrote:
> >It is not killable, neither 2.4 nor 2.6 one. It is by design I think,
> >because I *must not* kill it, or else NFS rootfs will fall off
> >and box will hang.
> 
> If it's not killable (per kill(2)), why can killall5 (which will probably use
> kill(2)!) do it?

I believe by design it is a kernel thread, unkillable even by -KILL
signal (precisely because of NFS root setups). You are right,
it does not matter how do you send -KILL from shell: via kill,
killall, killall5, etc... It simply should be ignored by rpciod.

And it is ignored in 2.4. In 2.6, rpciod becomes non-functional
(NFS reads return -EIO) for a second or two, then it returns
back to normal.

Hope this clears up the confusion.

(BTW, I planned to temporarily work around this by inserting
"sleep 3" right after killall5, but, hehe, reading /bin/sleep
via NFS, of course, did not work also :)
--
vda

