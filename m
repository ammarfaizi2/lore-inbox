Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131958AbRDTTcM>; Fri, 20 Apr 2001 15:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131974AbRDTTcF>; Fri, 20 Apr 2001 15:32:05 -0400
Received: from chromium11.wia.com ([207.66.214.139]:2569 "EHLO
	neptune.kirkland.local") by vger.kernel.org with ESMTP
	id <S131958AbRDTTbw>; Fri, 20 Apr 2001 15:31:52 -0400
Message-ID: <3AE08F8E.643FDC63@chromium.com>
Date: Fri, 20 Apr 2001 12:35:42 -0700
From: Fabio Riccardi <fabio@chromium.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: Zach Brown <zab@zabbo.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: numbers?
In-Reply-To: <Pine.LNX.4.30.0104181807480.29999-100000@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current chromium server is based on Apache 1.3, and it inherits its threading
limitations.

Incidentally the same server running on a kernel with a multiqueue scheduler
achieves 1600 connections per second on the same machine, that was the original
reason for my message for a better scheduler.

In any case the chromium server is a substantially faster apache (more than a factor
of two on spec, possibly much more in real life), and given that Apache is the most
widespread server on the planet, having something that makes it faster is quite
handy. You don't need any further training for users, all standard modules work, we
even fixed the performance problems that afflicted Tomcat Jakarta. A convenient
solution.

Our forthcoming server (dubbed X15) is a completely new thing, but it still sits in
user space.

X15 is the server I was referring to and as far as I can measure I get very much the
same performance as TUX.

On a Dell 4400 (933 MHz PIII, 2G of RAM, 5 9G disks) I get 2450 connections/second.

On a Dell PowerEdge 1550/1000 the published TUX 2 result is 2765.

If you take into account the fact that the 1550 has a faster processor (1GHz) and a
more modern bus architecture (Serverworks HE with memory interleaving and a triple
PCI bus), the performance is roughly the same.

I'd love to try TUX and X15 head to head on the same hardware, indeed I've spent the
last two days trying to get TUX to run on my Dell 4400, but I wasn't very lucky.

The static pages work fine, the dynamic module gets executed, but for some reason it
fails to open the postlog file and to spawn the spec utility tasks at reset time.

I tried the latest TUX based on 2.4.2-ac26 from your home site at RedHat, and I've
used the latest TUX dynamic code that is published on the SPEC site
(Compaq-20010122-DL320-API.tar.gz).

Are they compatible with each other?

I'll try again today with the TUX that comes with the new RH 7.1

The PowerEdge 2500 for which the TUX result is 3225 (I think that this is the result
you were quoting) is a much modern machine than the 4400, with a much higher memory
bandwidth, that could explain the performance difference (four NICs sucking data at
the same time require quite a bit of bandwidth).

I'll make an alpha release of X15 available for download by the end of next week, so
people will be able to test it independently.

 - Fabio

Ingo Molnar wrote:

> On Fri, 23 Mar 2001, Fabio Riccardi wrote:
>
> > I'm building an alternative web server that is entirely in _user
> > space_ and that achieves the same level of performance as TUX.
> > Presently I can match TUX performance within 10-20%, and I still have
> > quite a few improvements in my pocket.
>
> very interesting statement, which appears to be contradicted by numbers on
> your website. Your website says you get a 1375 SPECweb99 connections
> result on a dual 1 GHz, 4 GB, PIII system:
>
>         http://www.chromium.com/cr_hp.html
>
> the best TUX 2.0 result published so far, on a very similar system (same
> CPU speed, same amount of RAM, same number and type of network cards) is
> 3222 connections:
>
>         http://www.spec.org/osg/web99/results/res2001q2/web99-20010319-00100.html
>
> the difference between 1375 and 3222 is quite substantial, TUX is 134%
> faster (2.3 times the performance of your server). I'm sure a userspace
> webserver can get quite close to TUX in simple static benchmarks (in fact
> phttpd should be very close), but SPECweb99 is far from simple. When
> saying you are 10-20% close to TUX, did you refer to SPECweb99 results?
>
>         Ingo
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

