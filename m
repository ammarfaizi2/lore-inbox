Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbTDPXXZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 19:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbTDPXXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 19:23:25 -0400
Received: from wireless-216-222-127-29.reno.velocitus.net ([216.222.127.29]:63893
	"EHLO masterhub1.sncorp.intranet.com") by vger.kernel.org with ESMTP
	id S261942AbTDPXXX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 19:23:23 -0400
Subject: Re: 2.5.67-mm3: Bad: scheduling while atomic with IEEE1394 then
	hard freeze ( lockup on CPU0)
From: Steve Kinneberg <kinnebergsteve@acmsystems.com>
To: Philippe =?ISO-8859-1?Q?Gramoull=E9?= 
	<philippe.gramoulle@mmania.com>
Cc: Ben Collins <bcollins@debian.org>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Linux1394dev <linux1394-devel@lists.sourceforge.net>
In-Reply-To: <20030417003031.2b603167.philippe.gramoulle@mmania.com>
References: <20030416000501.342c216f.philippe.gramoulle@mmania.com>
	<20030415160530.2520c61c.akpm@digeo.com>
	<20030416004933.GI16706@phunnypharm.org>
	<20030416184528.19c20372.philippe.gramoulle@mmania.com>
	<1050514375.589.1843.camel@stevek> 
	<20030417003031.2b603167.philippe.gramoulle@mmania.com>
X-Mailer: Ximian Evolution 1.0.8 
Date: 16 Apr 2003 16:35:10 -0700
Message-Id: <1050536111.1899.2246.camel@stevek>
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SacMail1/ACMS/SNCorp(Release 5.0.11  |July 24, 2002) at
 04/16/2003 04:35:11 PM,
	Serialize by Router on masterhub1/SNCorp(Release 5.0.11  |July 24, 2002) at
 04/16/2003 04:39:22 PM,
	Serialize complete at 04/16/2003 04:39:22 PM
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-16 at 15:30, Philippe Gramoullé wrote:
> 
> Hello,
> 
> On 16 Apr 2003 10:32:54 -0700
> Steve Kinneberg <kinnebergsteve@acmsystems.com> wrote:
> 
>   | On Wed, 2003-04-16 at 09:45, Philippe Gramoullé wrote:
>   | > 
>   | > # dmesg
>   | > oot is not IRM capable, resetting...
>   | > ieee1394: Remote root is not IRM capable, resetting...
>   | > ieee1394: Remote root is not IRM capable, resetting...
>   | > ieee1394: Remote root is not IRM capable, resetting...
>   | > [message repeated 178 times and as long as the DV Camcorder in turned on]
>   | 
>   | I realize this isn't the problem you're really concerned about, but the
>   | above may happen if you are using a version of the 1394 code off the
>   | linux-2.4 branch prior to the patch I sent to the list Monday that Ben
>   | recently applied.  (You should be able to get around this without
>   | downloading the latest code and recompiling by setting attempt_root=1
>   | when insmodding ohci1394.
> 
> Thanks for the tip. Anyway, for me 2.4 is no problem. Looking through the archives i saw that checking not the latest
> code worked for me(tm) but this was some time ago and things may have changed ( i.e latest 2.4
> code works as expected)

My bad for not reading the subject line more closely.

> 
> For 2.5, the thing is i remember being able to successfully use my DV Camcorder 
> Canon Optura 200MC ( MVX2i in Europe) with IEEE1394 , around 2.5.59 IIRC.
> 
> Since then, i only got these "reset storms" versions over versions. Not that i complain about
> but it's just that i hope that reporting bugs will be helpful to IEEE1394 developers, because
> if it worked once,  then i don't see why i wouldn't work either with newer versions 8)

The code that prints "ieee1394: Remote root is not IRM capable,
resetting..." was added almost 2 months ago to the 1394 SVN trunk, so
its still fairly recent and probably after 2.5.59.  If this message
repeats rapidly under recent 2.5.*, then there is a problem with
initiating a bus reset and forcing the local node to be root.  My
recollection of the 1394 spec is that PHY packet needs to be sent out to
all nodes to clear the their root hold-off bit and the local node sets
its own root hold-off bit.  The OHCI 1394 code doesn't appear to do
anything special to send a PHY packet (it does set the root hold-off bit
in the local PHY chip) and I wonder if that might not be the source of
this problem.  Does anyone, who understands the PHY chip, know if it
automatically sends the appropriate PHY packet when this bit is set?  If
not, we may need to add code to send it.

If anyone can answer the one question I posed above, I'd greatly
appreciate it.

Thanks,
-- 
Steve Kinneberg
ACM Systems
3034 Gold Canal Drive
Rancho Cordova, CA  95670
Phone: (916) 463-7987
Email: kinnebergsteve@acmsystems.com

