Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314083AbSEMQQJ>; Mon, 13 May 2002 12:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314093AbSEMQQI>; Mon, 13 May 2002 12:16:08 -0400
Received: from www.cdhutmusic.co.sz ([196.28.7.66]:51928 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S314083AbSEMQQH>; Mon, 13 May 2002 12:16:07 -0400
Date: Mon, 13 May 2002 17:52:26 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Steve Kieu <haiquy@yahoo.com>, kernel <linux-kernel@vger.kernel.org>
Subject: Re: OOPS 2.4.19-pre7-ac4 (Was: strange things in kernel 2.4.19-pre7-ac4
 + preempt patch)
In-Reply-To: <200205131412.g4DECHY06608@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.44.0205131736240.353-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 May 2002, Denis Vlasenko wrote:

> > I did use memtest86 and all test is passed, no errors.
> > And problem still persists with 2.4.19-pre8-ac2 ; oops
> > after exiting X
> >
> > Now I have to use 2.4.16 ; any way all kernel before
> > 2.4.19-pre2 is normal, I did not test 2.4.19-preX>2
> > but 2.4.19-pre7-ac4 and 2.4.19-pre8-ac2
> 
> When no one answers on lkml to your oops report, you
> have basically the only choice: start looking at stack trace
> yourself, insert printks here and there, recompile and give it a try.

This looks fishy...

static void i810_free_page(drm_device_t *dev, unsigned long page)
{
        struct page * p = virt_to_page(page);
        if(page == 0UL)
                return;

        put_page(p);
        unlock_page(p);
[...]

You get to unlock_page with p = %eax

void unlock_page(struct page *page)
{
        wait_queue_head_t *waitqueue = page_waitqueue(page);

[...]

The question now is... what is going on here???

static void i810_free_page(drm_device_t *dev, unsigned long page <-- )
{
        struct page * p = virt_to_page(page); <--

What exactly is unsigned long page supposed to be? I sure as hell hope its 
an address... if it is, thats a really strange variable naming...

Cheers,
	Zwane Mwaikambo

-- 
http://function.linuxpower.ca
		

