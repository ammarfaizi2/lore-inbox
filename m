Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135273AbRDWPDL>; Mon, 23 Apr 2001 11:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135283AbRDWPDC>; Mon, 23 Apr 2001 11:03:02 -0400
Received: from mail-oak-2.pilot.net ([198.232.147.17]:64209 "EHLO
	mail02-oak.pilot.net") by vger.kernel.org with ESMTP
	id <S135277AbRDWPCt>; Mon, 23 Apr 2001 11:02:49 -0400
Message-ID: <973C11FE0E3ED41183B200508BC7774C0124F187@csexchange.crystal.cirrus.com>
From: "Woller, Thomas" <twoller@crystal.cirrus.com>
To: "'David'" <david@blue-labs.org>, linux-kernel@vger.kernel.org
Subject: RE: 2.4.3+ sound distortion
Date: Mon, 23 Apr 2001 10:01:45 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,
your report sounds like a problem that we have seen in the test lab, but no
one has reported in the field... yet. :)
if the problem is the same as we have seen... unloading the driver and
reloading the driver should also clear up the problem.  but typically the
problem only occurs after playing for several hours without a break in the
audio stream.  

we think that we understand the problem (theoretically), in that we believe
that we need to manipulate a static DSP image location periodically that
gets too far out of value.  the issue is that internal variables for the
static DSP image are not reinitialized on a task restart (e.g. restarting up
an audio stream).  reloading the static image (i.e. suspend/resume or
reloading the driver) clears up the tinny sound here.  it hadn't been
reported, so I haven't taken the time to plough through the static image map
to try to figure out where all the locations are for all the task images
that need manipulation.  might take a while, but since we now have a problem
report, i'll try to find some time to start negotiating the DSP map.  i'll
send the fix to you for testing when/if... i can get the problem resolved.
thanks

tom
twoller@crystal.cirrus.com 

> -----Original Message-----
> From:	David [SMTP:david@blue-labs.org]
> Sent:	Sunday, April 22, 2001 10:08 PM
> To:	linux-kernel@vger.kernel.org
> Subject:	Re: 2.4.3+ sound distortion
> 
>   I have noticed a problem with sound lately.  I have a cs46xx card and 
> it randomly gets distorted.  Normally I just reboot but on this last 
> occurence I simply left it as it was.  The distortion sounds someone 
> punched the speaker core, it's tinny and mangled.  Today it fixed itself 
> out of the blue in the middle of playing a sound. All sound programs are 
> equally affected.
> 
> It's only done this in the 2.4 series, I haven't had the desire to look 
> into it.
> 
> David
> 
> Mike Castle wrote:
> 
> >On Sat, Apr 21, 2001 at 06:04:47PM +0200, Victor Julien wrote:
> >
> >>I have a problem with kernels higher than 2.4.2, the sound distorts when
> 
> >>playing a song with xmms while the seti@home client runs. 2.4.2 did not
> have 
> >>
> >
> >Would this be the same issue as describe in these threads:
> >
> >http://www.uwsg.indiana.edu/hypermail/linux/kernel/0104.0/0233.html
> >http://www.uwsg.indiana.edu/hypermail/linux/kernel/0104.1/0231.html
> >
> >That is, the change in how nice is recalculated.
> >
> >mrc
> >
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
