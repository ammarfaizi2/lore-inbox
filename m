Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269156AbTCDFZg>; Tue, 4 Mar 2003 00:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269159AbTCDFZg>; Tue, 4 Mar 2003 00:25:36 -0500
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:33206 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id <S269156AbTCDFZf>;
	Tue, 4 Mar 2003 00:25:35 -0500
From: Con Kolivas <kernel@kolivas.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: xmms (audio) skipping in 2.5 (not 2.4)
Date: Tue, 4 Mar 2003 16:36:00 +1100
User-Agent: KMail/1.5
References: <103200000.1046755559@[10.10.2.4]>
In-Reply-To: <103200000.1046755559@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303041636.00745.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Mar 2003 04:25 pm, Martin J. Bligh wrote:
> OK, so I finally took the plunge, and put 2.5 on my main desktop as well as
> just the lab machines ;-)
>
> Generally seems to work very well, and VM performance is much more stable
> than 2.4 ... but xmms seems to skip if I just waggle the scrollbar in some
> windows. This happens most in my email client (which is Mulberry), but
> other things show it to a more limited extent.
>
> The audio pauses happen on a simple window scroll down, without intensive
> CPU background activity ... they're very short in duration, which makes it
> *feel* more like the audio buffer is too small than a scheduler problem,
> but I'm just guessing really.
>
> So ... is there any easy way I can diagnose this? Does anyone else have a
> similar problem?

Most of us who have worked with an O(1) scheduler based kernel have found this 
at various times. See the previous discussion with akpm about the 
interactivity estimator. Akpm found that decreasing the maximum timeslice 
duration would blunt the effect of the interactivity estimator giving 
preference to the "wrong" task. In 2.4.20-ck4 I avoid this problem with the 
"desktop tuning" of making the max timeslice==min timeslice. Try an -mm 
kernel with the scheduler tunables patch and try playing with the max 
timeslice. Most have found that <=25 will usually stop these skips. The 
default max timeslice of 300ms is just too long for the desktop and 
interactivity estimator.
 
Con
