Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752510AbWJ0VgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752510AbWJ0VgX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 17:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752509AbWJ0VgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 17:36:23 -0400
Received: from web54511.mail.yahoo.com ([206.190.49.161]:61075 "HELO
	web54511.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1752510AbWJ0VgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 17:36:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=4qF120CxuBVHZ+RQmcuYiE2PUtseGjE6+eykQqSMZWOJfhJZrWVxYHPWZMyyTNBnprTHglilSuHjmpDTsRVT4WYMu9FS4Tvnaonoyjass0ziQpXJwR5p0zb88dCSOkpK1VIzvMnY4IP73IBiBDg/SzrTcx1P+V1m7cOGtmvLXIE=  ;
Message-ID: <20061027213622.89417.qmail@web54511.mail.yahoo.com>
Date: Fri, 27 Oct 2006 14:36:21 -0700 (PDT)
From: Indian Mogul <indian_mogul@yahoo.com>
Subject: Re: CPU Loading
To: Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org
In-Reply-To: <1161933988.6102.28.camel@Homer.simpson.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the code snippet.. One more question. I
want to  load the cpu with x% load & take
measurements. For eg, cpu_burn <x> should load the CPU
 with x% occupancy.. Is there a way this could be
done? Any program / pointers greatly appreciated..

Thanks,
IM 

--- Mike Galbraith <efault@gmx.de> wrote:

> On Thu, 2006-10-26 at 22:37 -0700, Indian Mogul
> wrote:
> 
> > How can I load the CPU such that the scheduling
> time
> > slice is insuffucent for mplayer to playout the
> video?
> > To the mplayer the system thus appears "slow" ?
> 
> :) unusual request.
> 
> The proglet below, which someone posted a while
> back, should meet your
> needs nicely.  Fire up a few copies in the
> background with args like
> 5000 6000 7000 8000 9000.., and mplayer should
> become decidedly unhappy.
> 
> The scheduler round robin schedules tasks which it
> has classified as
> interactive (tasks which sleep somewhat regularly
> basically) at a higher
> rate than their timeslice to reduce latency, but the
> more tasks
> circulating at the same priority (or above) as
> mplayer, the bigger the
> latency hit mplayer will take.
> 
> 	-Mike
> 
> #include <stdlib.h>
> #include <unistd.h>
> 
> static void burn_cpu(unsigned int x)
> {
> 	static char buf[1024];
> 	int i;
> 	
> 	for (i=0; i < x; ++i)
> 		buf[i%sizeof(buf)] = (x-i)*3;
> }
> 
> int main(int argc, char **argv)
> {
> 	unsigned long burn;
> 	if (argc != 2)
> 		return 1;
> 	burn = (unsigned long)atoi(argv[1]);
> 	while(1) {
> 		burn_cpu(burn*1000);
> 		usleep(1);
> 	}
> 	return 0;
> }
>


> 
> 




 
____________________________________________________________________________________
Low, Low, Low Rates! Check out Yahoo! Messenger's cheap PC-to-Phone call rates 
(http://voice.yahoo.com)

