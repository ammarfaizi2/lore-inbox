Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751722AbWFLKUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbWFLKUt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 06:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751800AbWFLKUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 06:20:49 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:57500 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751722AbWFLKUs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 06:20:48 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] revert "swsusp: fix breakage with swap on lvm"
Date: Mon, 12 Jun 2006 12:21:13 +0200
User-Agent: KMail/1.9.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
References: <200603231702.k2NH2MUS006739@hera.kernel.org> <20060612000859.GA16992@redhat.com>
In-Reply-To: <20060612000859.GA16992@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606121221.13867.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 June 2006 02:08, Dave Jones wrote:
> On Thu, Mar 23, 2006 at 05:02:22PM +0000, Linux Kernel wrote:
>  > commit 2b322ce210aec74ae0d02938d3a01e29fe079469
>  > tree a9cb9aa9530cadacae62caf009db506db16eb3c1
>  > parent bdaff4a331db46f3bd953f413316c4603c4004b4
>  > author Andrew Morton <akpm@osdl.org> Thu, 23 Mar 2006 18:59:58 -0800
>  > committer Linus Torvalds <torvalds@g5.osdl.org> Thu, 23 Mar 2006 23:38:07 -0800
>  > 
>  > [PATCH] revert "swsusp: fix breakage with swap on lvm"
>  > 
>  > This was a temporary thing for 2.6.16.
>  > 
>  > Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
>  > Cc: Pavel Machek <pavel@ucw.cz>
>  > Signed-off-by: Andrew Morton <akpm@osdl.org>
>  > Signed-off-by: Linus Torvalds <torvalds@osdl.org>
>  > 
>  >  kernel/power/swsusp.c |    4 +++-
>  >  1 files changed, 3 insertions(+), 1 deletion(-)
>  > 
>  > diff --git a/kernel/power/swsusp.c b/kernel/power/swsusp.c
>  > index 2d9d08f..4e90905 100644
>  > --- a/kernel/power/swsusp.c
>  > +++ b/kernel/power/swsusp.c
>  > @@ -153,11 +153,13 @@ static int swsusp_swap_check(void) /* Th
>  >  {
>  >  	int i;
>  >  
>  > +	if (!swsusp_resume_device)
>  > +		return -ENODEV;
>  >  	spin_lock(&swap_lock);
>  >  	for (i = 0; i < MAX_SWAPFILES; i++) {
>  >  		if (!(swap_info[i].flags & SWP_WRITEOK))
>  >  			continue;
>  > -		if (!swsusp_resume_device || is_resume_device(swap_info + i)) {
>  > +		if (is_resume_device(swap_info + i)) {
>  >  			spin_unlock(&swap_lock);
>  >  			root_swap = i;
>  >  			return 0;
> 
> So, now I'm getting bug reports from users about .17rc breaking
> their resume again. (https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=194784)
> 
> If this was a temporary thing, what should we be doing to keep
> old installations working ?

This was temporary, because the handling of it has been moved to
kernel/power/swap.c and mm/swapfile.c now, but the code has not changed much
(surely it doesn't return -ENODEV if swsusp_resume_device is not set).
Moreover, the new code has been in -rc since 2.6.17-rc1.

The report you are referring to is for the kernel called 2.6.16-1.2255_FC6. 
Is this just 2.6.17-rc* renamed or is it related to -rc in another way?

Greetings,
Rafael
