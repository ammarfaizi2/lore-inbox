Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266362AbUGAX0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266362AbUGAX0v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 19:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266364AbUGAX0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 19:26:51 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:35776 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S266362AbUGAX0r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 19:26:47 -0400
Date: Fri, 2 Jul 2004 01:26:46 +0200
From: bert hubert <ahu@ds9a.nl>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: Mikael.Pettersson@csd.uu.se, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: perfctr questions
Message-ID: <20040701232646.GA21868@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Bryan O'Sullivan <bos@serpentine.com>, Mikael.Pettersson@csd.uu.se,
	linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20040701220448.GA16515@outpost.ds9a.nl> <1088720394.32000.26.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1088720394.32000.26.camel@serpentine.internal.keyresearch.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2004 at 03:19:54PM -0700, Bryan O'Sullivan wrote:

> > I'm trying to test your performance counters stuff, but I can't get it to do
> > anything remotely useful! Probably just me.

Ok, it is working. This is a plot of the number of L2 Address Strobes
counted while scanning a buffer of x bytes: http://ds9a.nl/tmp/strobes.png 

>From dmesg:
CPU: L1 I cache: 32K, L1 D cache: 32K

Note the sharp rise at 32768 bytes!

int main(int argc, char **argv)
{
        char *memory;
        int len=atoi(argv[1]);
        memory=malloc(len);
        int n, count;
        for(count=0;count<10000;++count) 
                for(n=1;n<len;++n) {    
                        memory[n]++;
                }
}

Script:

for a in $(seq 30000 10 35000) ; do perfex -o log -e 0x00410021 ./null $a ;
echo -n "$a " ; tail -1 log | awk '{print $3}'; done > line

The '21' stands for P6_L2_ADS.

Cool stuff!

Regards,

bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
