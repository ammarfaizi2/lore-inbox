Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbUCPTcB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 14:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbUCPTa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 14:30:57 -0500
Received: from mail.cs.tu-berlin.de ([130.149.17.13]:5325 "EHLO
	mail.cs.tu-berlin.de") by vger.kernel.org with ESMTP
	id S261432AbUCPT2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 14:28:12 -0500
Date: Tue, 16 Mar 2004 20:24:38 +0100 (MET)
From: Peter Daum <gator@cs.tu-berlin.de>
Reply-To: Peter Daum <gator@cs.tu-berlin.de>
To: "chas williams (contractor)" <chas@cmf.nrl.navy.mil>
cc: <linux-kernel@vger.kernel.org>, <linux-atm-general@lists.sourceforge.net>
Subject: Re: ATM (LANE) - related Kernel-Crashes 
In-Reply-To: <200403161528.i2GFSLDV009480@ginger.cmf.nrl.navy.mil>
Message-ID: <Pine.LNX.4.30.0403161826200.15441-100000@swamp.bayern.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 16 Mar 2004, chas williams (contractor) wrote:

> well this is pretty useful.  just curious--which gcc are you using to
> build your kernels?  i have slightly different assembly for this bit
> of code but it seems to point to:
>
> Line 657 of "net/atm/lec.c" starts at address 0xe4a <lec_push+26> and ends at 0xe50 <lec_push+32>.

This particular kernel had been built using gcc 3.3. The problem,
however is certainly not related to any particular compiler
version.

> lec_vcc_attach(struct atm_vcc *vcc, void *arg)
> {
> 	...
>         vcc->push = lec_push;
>         vcc->proto_data = dev_lec[ioc_data.dev_num];
> 	...
>
> this is bad.  these two lines should be reversed!  lec_push() is
> not safe until vcc->proto_data is setup.  could you swap the order of
> those two lines and give that a try?

I will. Unfortunately, it will take a while to find out whether
this makes any difference. I currently have ~ 8 machines with the
same Forerunner LE atm adapters and LANE. All of them
sporadically crash without any recognizable pattern, but it also
happens that they run stable for months. In all cases where I
could find out any details, the problem seemed to be
LANE-related. Unfortunately, they did not always occur at the
place in the kernel code. lec_push seems() to be pretty frequent
but I also had 2 "documented" crashs in lec_send_packet() and one
in bind_vcc(). (Some more "historic" crash dumps are in the bug
report at http://sourceforge.net/tracker/index.php?
func=detail&aid=445059&group_id=7812&atid=107812)

(Sadly, all information I could gather about what is going on is
very fragmentary. I tried to capture the crash dumps with "lkcd"
but this also doesn't work when the kernel crashes within an
interrupt handler; all the data is by attaching an old laptop
machine as a serial console, but this method doesn't scale well
;-)

Thanks a lot for your endeavor,

Peter Daum

