Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262204AbVD1U7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262204AbVD1U7t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 16:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbVD1U7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 16:59:49 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:29353 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262204AbVD1U7W convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 16:59:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FHl/W4X0UL04HSiFo60f0Ico/jh5UXshmncQq/XnA0wJJAcxhDqJXYothhuz6/8P/g9aik+hEm8NP9c2OHhNqw8xkmRYC4O8U2u9huUhViImaiHigDXPeiQyu/1v92UcFtueemRCLUVghICoOFKUBDP2d8dJuUZxVDWJK93eQ4Y=
Message-ID: <4ae3c1405042813591f0b5962@mail.gmail.com>
Date: Thu, 28 Apr 2005 16:59:21 -0400
From: Xin Zhao <uszhaoxin@gmail.com>
Reply-To: Xin Zhao <uszhaoxin@gmail.com>
To: linux-os@analogic.com
Subject: Re: dumb question: How to create your own log files in a kernel module?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0504281557510.29750@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4ae3c14050428111073283bd3@mail.gmail.com>
	 <Pine.LNX.4.61.0504281557510.29750@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for kind help. 

I know printk can do this job. But what I really want is to print logs
to a file specified by me instead of /var/log/messages. And, the
messages irrelevant to my module should not be written into that file.
 Now my log mixed with other logs in /var/log/message, which bother me
much. :(

I guess the KERN_PRIVATE might work for this. Can you give me more details?

Thanks again!

Xin

On 4/28/05, Richard B. Johnson <linux-os@analogic.com> wrote:
> On Thu, 28 Apr 2005, Xin Zhao wrote:
> 
> > Can anyone give me a hand? or point me to somewhere I can find related
> > information?
> >
> > Thanks in advance!
> >
> > Xin
> 
> printk(KERN_XXX"whatever") was designed for this.
> 
> #define KERN_EMERG      "<0>"   /* system is unusable                   */
> #define KERN_ALERT      "<1>"   /* action must be taken immediately     */
> #define KERN_CRIT       "<2>"   /* critical conditions                  */
> #define KERN_ERR        "<3>"   /* error conditions                     */
> #define KERN_WARNING    "<4>"   /* warning conditions                   */
> #define KERN_NOTICE     "<5>"   /* normal but significant condition     */
> #define KERN_INFO       "<6>"   /* informational                        */
> #define KERN_DEBUG      "<7>"   /* debug-level messages                 */
>         printk(KERN_DEBUG fmt,##arg)
>         printk(KERN_INFO fmt,##arg)
> 
> You could define your own, KERN_PRIVATE "<8>" and have the syslog
> facility filter on that.
> 
> Other ways are to write stuff to a buffer or linked-list and
> read it out using an ioctl() or read() in your module. If you
> do this, make sure that your module code doesn't wait forever
> if the buffer gets full.
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
>   Notice : All mail here is now cached for review by Dictator Bush.
>                   98.36% of all statistics are fiction.
>
