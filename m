Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262576AbTHZE45 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 00:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262579AbTHZE45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 00:56:57 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:31945
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S262576AbTHZE4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 00:56:55 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Kester Maddock <Christopher.Maddock.1@uni.massey.ac.nz>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Re: Blender profiling-1 O16.2int
Date: Tue, 26 Aug 2003 15:03:48 +1000
User-Agent: KMail/1.5.3
Cc: bf-committers@blender.org
References: <200308261454.03069.Christopher.Maddock.1@uni.massey.ac.nz>
In-Reply-To: <200308261454.03069.Christopher.Maddock.1@uni.massey.ac.nz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308261503.48844.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Aug 2003 12:54, Kester Maddock wrote:
> On Sun, Aug 17, 2003 at 11:36:42PM +1000, Con Kolivas wrote:
> > Now normally, blender should just sleep and wait till X comes
> > alive again before it does anything. However here it shows clearly that
> > it is spinning madly looking for something from X, and poor X can't do
> > anything. This is the busy on wait I've described.
> >
> > Second, any applications that exhibit this should be fixed since it is a
> > bug.
>
> Say if blender is polling the mouse in the view rotate loop?  (If so, you
> should be able to just hold down the middle mouse to starve, without moving
> the mouse.)
>
> Is this really a bug in the application?  Blender is interactive while
> rotating the view.  More CPU means more frames per second which gives the
> user a better experience.  The CPU usage will drop down when the user
> releases the middle mouse button.
>
> (OK, in this specific case blender could update the screen on mouse move
> events, but what about the general case eg a 3d game, where the screen
> is updated by eg monster ai?)
>
> And how do you fix it?  Would sleep(0) in these loops do, or do you need to
> select(...) on X?
>
> CC me please on replys.
>
> Thanks,
>
> Kester Maddock.
> ^ sends occaisional patches to blender.

Thanks for you attention. Yes this is a scheduler issue that makes it prone to 
the effect of priority inversion (heck even the mars rover module suffered 
it), brought out by the quirk in the coding. I wouldn't even know where to 
begin looking at the source of blender but the culprits we've tracked down so 
far that cause this use select with a very short timeout (15ms in one case). 
Basically it repeatedly times out, and X never gets adequate scheduling time 
to respond because the applications themselves are the ones preempting X.

Con

