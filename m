Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281557AbRKZKML>; Mon, 26 Nov 2001 05:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281556AbRKZKLx>; Mon, 26 Nov 2001 05:11:53 -0500
Received: from dmb001.rug.ac.be ([157.193.78.1]:45200 "HELO dmb.rug.ac.be")
	by vger.kernel.org with SMTP id <S281555AbRKZKLg>;
	Mon, 26 Nov 2001 05:11:36 -0500
Message-ID: <3C021570.4000603@dmb.rug.ac.be>
Date: Mon, 26 Nov 2001 11:12:00 +0100
From: Didier Moens <Didier.Moens@dmb001.rug.ac.be>
Organization: RUG/VIB - Dept. Molecular Biology
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Fwd: Re: OOPS in agpgart (2.4.13, 2.4.15pre7)]
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Stephan von Krawczynski wrote:

 >On Sun, 25 Nov 2001 15:09:13 +0100
 >Didier Moens <moensd@xs4all.be> wrote:
 >
 >>Dear,
 >>
 >>Stephan von Krawczynski wrote:
 >>
 >>>
 >>>Hello Marcelo,
 >>>
 >>>I tried to find the current maintainer of agpgart module, but couldn't
 >>>find any in the MAINTAINERS list. Who is it?
 >>>I obviously could fix the oops, but I would need some input on how
 >>>I830M chipset looks like on a working config to further investigate
 >>>Didiers problem.
 >>>Any hints?
 >>>
 >>>Regards,
 >>>Stephan
 >>>
 >>>
 >>Anything I can do to help out ?
 >>
 >
 >Hm, well if you can get your hands on another box with i830, another lspci
 >output would be of interest.
 >

Examining the code :

                         if (i810_dev == NULL) {
                                 printk(KERN_ERR PFX "agpgart: Detected an "
                                        "Intel i815, but could not find the"
                                        " secondary device. Assuming a "
                                        "non-integrated video card.\n");
                                 break;


This leads me to believe the "secondary device"  could be the integrated
graphics component on the i810/815.

As the i830M doesn't have one (the i830MG does), I suppose this could
lead to the aforementioned error message, and hence failure of the
agpgart modprobe ?

Could it be that one has to differentiate between i830MG (secondary
device, and hence analoguous to i810/i815) and i830M (no secondary
device, and possibly analoguous to i830/i840/i845/... : no check for 2nd
device needed ) ?


Offcourse, I could be utterly wrong.


Regards,
Didier




