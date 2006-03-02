Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752006AbWCBRSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006AbWCBRSd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 12:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751589AbWCBRSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 12:18:33 -0500
Received: from nproxy.gmail.com ([64.233.182.198]:3383 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751078AbWCBRSc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 12:18:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G9VMW17TZVRTl2DRtDqevZpDVeEo8YE06tCdu+ymQlCvGeWqtRB84W6yXfENOSSPS7uWTZHHeYoNEYKQhSiYzSDq6EpjIzh8up3dQY9WNb4mwBEvXbyrT3pFi/3CqcqeU+wfTXoRnum5evRvHA4lWkzzNymZ8TXDGocRRVNtRAo=
Message-ID: <cb899a660603020918j47941907xc23e94b4855d8088@mail.gmail.com>
Date: Thu, 2 Mar 2006 18:18:30 +0100
From: "=?ISO-8859-1?Q?Carlos_Mart=EDnez?=" <carlosm.upm@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: RTC example in Documentation/rtc.txt not working correctly
In-Reply-To: <cb899a660603020718q5743e2e3u1b921f449ef66a3b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <cb899a660603020718q5743e2e3u1b921f449ef66a3b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all, (first post here =)

I'm working with RTC these days and got to read the example provided by
    Paul Gortmaker in 1996 included in Documentation/rtc.txt

I prepared the binary with the supplied code and everything goes
 smoothly but something strange seems to happen when running: i will
 restrict the code to the scope of the problem to keep things readable
 and simple,

        // open the rtc device
        fd = open ("/dev/rtc", O_RDONLY);

        if ( fd == -1 ) {
                    perror("/dev/rtc");   // error printing
                    exit(errno);            // errno holds last error code
         }

         // to start with, some periodic interrupt with 1 sec delay,
mode RTC_UIE_ON

        // enable interrupts (unmasking i guess)
        retval = ioctl(fd, RTC_UIE_ON, 0);
        if (retval == -1){
                perror("ioctl");
                exit(errno);
         }

         fprintf(stderr,"Receiving interrupts each second .. \n");
         fflush(stderr);

        for (i=1;i<6;i++){
                    retval = read(fd, &data, sizeof(unsigned long));
                    if (retval == -1){
                            perror("read");
                            exit(errno);
                 }

                 fprintf(stderr, "%d ",i);
                 fflush(stderr);

                irqs++;
          }


The problem appears because as soon as i press enter and run the binary
my program gets an interruption, and that happens before the end of the
current second comes, so i'm supposing i'm getting the former second
interrupt which was not catched or something, could it be?

I'm also thinking that because two more things happen: if i disable
the interrupt
before enabling then i do not get that first interruption and nor do i if i
run the program again without a second expiring in the meantime. So, i
would propose to update the example so that works as it was intended
(count 5 seconds).

Adding a line like this one,

-[  ioctl(fd, RTC_UIE_OFF, 0);  ]-
    ioctl(fd, RTC_UIE_ON, 0);

solves the problem.

I'm thinking that this fearture may be architecture dependant .. well
i'm not an expert in this matter.

---------------------------------------------------------------------------------------------------
PD: i'm waiting for being included in the list, please CC any reply to
me, thank you  =)

--
Carlos Martinez Belinchon
UPM
