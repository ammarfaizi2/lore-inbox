Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284776AbRLRTG4>; Tue, 18 Dec 2001 14:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284604AbRLRTFS>; Tue, 18 Dec 2001 14:05:18 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:61173 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S284793AbRLRTD2>; Tue, 18 Dec 2001 14:03:28 -0500
Message-ID: <3C1F92FF.3030701@redhat.com>
Date: Tue, 18 Dec 2001 14:03:27 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011211
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolabs.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler ( was: Just a second ) ...
In-Reply-To: <Pine.LNX.4.33.0112181216341.1237-100000@admin> <Pine.LNX.4.33.0112180922500.2867-100000@penguin.transmeta.com> <20011218105459.X855@lynx.no> <3C1F8A9E.3050409@redhat.com> <20011218115243.Y855@lynx.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:


> Hmm, I _do_ notice a pop when the sound hardware is first initialized at
> boot time, but not when mpg123 starts/stops (without esd running) so I
> personally don't get any benefit from "the sound of silence".  That said,
> asside from the 190 interrupts/sec from esd, it doesn't appear to use any
> measurable CPU time by itself.
> 
> 
>>Context switches per second not playing any sound: 8300 - 8800
>>Context switches per second playing an MP3: 9200 - 9900
>>
> 
> Hmm, something seems very strange there.  On an idle system, I get about
> 100 context switches/sec, and about 150/sec when playing sound (up to 400/sec
> when moving the mouse between windows).  9000 cswitches/sec is _very_ high.
> This is with a text-only player which has screen output (other than the
> ID3 info from the currently played song).


I haven't taken the time to track down what's causing all the context 
switches, but on my system they are indeed "normal".  I suspect large 
numbers of them are a result of interactions between gnome, nautilus, X, 
xmms, esd, and gnome-xmms.  However, I did just track down one reason for 
it.  It's not 8300 - 8800, its 830 - 880.  There appears to be a bug in the 
procinfo -n1 mode that results in an extra digit getting tacked onto the end 
of the context switch line.  So, take my original numbers and lop off the 
last digit from the context switch numbers and that's more like what the 
machine is actually doing.





-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

