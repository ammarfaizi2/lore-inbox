Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136047AbRAGUwE>; Sun, 7 Jan 2001 15:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135762AbRAGUvy>; Sun, 7 Jan 2001 15:51:54 -0500
Received: from iq.sch.bme.hu ([152.66.226.168]:19116 "EHLO iq.rulez.org")
	by vger.kernel.org with ESMTP id <S136096AbRAGUvl>;
	Sun, 7 Jan 2001 15:51:41 -0500
Date: Sun, 7 Jan 2001 21:55:58 +0100 (CET)
From: Sasi Peter <sape@iq.rulez.org>
To: Chris Wedgwood <cw@f00f.org>
cc: <sourav@cs.cmu.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: Speed of the network card
In-Reply-To: <20010108015421.B2575@metastasis.f00f.org>
Message-ID: <Pine.LNX.4.30.0101072152090.4602-100000@iq.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2001, Chris Wedgwood wrote:

>     I would like to determine the banwidth the card is getting from
>     the network.
> /proc/net/dev exports counters; you can monitor those -- I'm sure
> there are perfomance program that do exactly this.

I have this little script for monitoring interfaces' speed on 132
wide textmode console w/ niche histogram. It is not perfect but 'it
works for me' (tm).

--------------------------> cut here
if [ "$1" = "" ]
then
  echo "Please specify the sampling rate."
  exit
fi

while true
do
  cat /proc/net/ip_fwnames &
  sleep $1
done |
  awk '
    BEGIN {
     s=0
     d='$1'*1024*1024
     wd=d/15
    }

    /^input /	{o=s
		 s=$7}
    /^output /	{s+=$7
                 w=(s-o)/wd
		 if(w>130)w=0
                 printf "%fMB/s %0*c\n",(s-o)/d,w,">"}
  '
--------------------------> cut here

-- 
SaPE - Peter, Sasi - mailto:sape@sch.hu - http://sape.iq.rulez.org/


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
