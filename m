Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbUJZPno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbUJZPno (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 11:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbUJZPno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 11:43:44 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:65255 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261196AbUJZPnl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 11:43:41 -0400
Date: Tue, 26 Oct 2004 17:43:36 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Arne Henrichsen <ahenric@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with close() system call
In-Reply-To: <605a56ed04102605433b9f368@mail.gmail.com>
Message-ID: <Pine.LNX.4.53.0410261739470.641@yvahk01.tjqt.qr>
References: <605a56ed04102504401e0f469f@mail.gmail.com> 
 <Pine.LNX.4.53.0410261329410.26803@yvahk01.tjqt.qr> <605a56ed04102605433b9f368@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Best is to put a printk("i'm in ioctl()") in the ioctl() function and a
>> printk("i'm in close()") in the close() one, to be really sure whether the
>> close() function of your module is called.
>
>Yes, that is exactly what I am doing. I basically implement the
>flush() call (for close) as the release() call was never called on
>close. So my release call does nothing. What I see is that the flush

Uh, then something's wrong. Your device fops should look like this:
{
  .release = my_close, // which is called upon close(2)
}

Anything else is of course, never working.

>function gets called, even though I have never called the close()
>system call from my user app.
>
>I also print out the module counter, and it doesn't make sense who
>increments it:

>From that output, I would not either get any idea.
Try opening only one device at a time.
Then, put a dump_stack() where you see fit.

>My user app looks something like this:

>    fd[i] = open(dev, O_RDWR | O_SYNC);

I don't think O_SYNC has any effect on unregular files.

>    if(status != 0)
>    {
>      printf("%s - %s\n", dev, strerror(errno));
>    }
>  } /* for(port_id = 0; port_id < nr_ports; port_id++) */

Well, WHERE do you close() the fd?


Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
