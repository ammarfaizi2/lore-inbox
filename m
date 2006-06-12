Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750911AbWFLAJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbWFLAJY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 20:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbWFLAJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 20:09:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20169 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750738AbWFLAJX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 20:09:23 -0400
Date: Sun, 11 Jun 2006 20:08:59 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] revert "swsusp: fix breakage with swap on lvm"
Message-ID: <20060612000859.GA16992@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <200603231702.k2NH2MUS006739@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603231702.k2NH2MUS006739@hera.kernel.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 05:02:22PM +0000, Linux Kernel wrote:
 > commit 2b322ce210aec74ae0d02938d3a01e29fe079469
 > tree a9cb9aa9530cadacae62caf009db506db16eb3c1
 > parent bdaff4a331db46f3bd953f413316c4603c4004b4
 > author Andrew Morton <akpm@osdl.org> Thu, 23 Mar 2006 18:59:58 -0800
 > committer Linus Torvalds <torvalds@g5.osdl.org> Thu, 23 Mar 2006 23:38:07 -0800
 > 
 > [PATCH] revert "swsusp: fix breakage with swap on lvm"
 > 
 > This was a temporary thing for 2.6.16.
 > 
 > Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
 > Cc: Pavel Machek <pavel@ucw.cz>
 > Signed-off-by: Andrew Morton <akpm@osdl.org>
 > Signed-off-by: Linus Torvalds <torvalds@osdl.org>
 > 
 >  kernel/power/swsusp.c |    4 +++-
 >  1 files changed, 3 insertions(+), 1 deletion(-)
 > 
 > diff --git a/kernel/power/swsusp.c b/kernel/power/swsusp.c
 > index 2d9d08f..4e90905 100644
 > --- a/kernel/power/swsusp.c
 > +++ b/kernel/power/swsusp.c
 > @@ -153,11 +153,13 @@ static int swsusp_swap_check(void) /* Th
 >  {
 >  	int i;
 >  
 > +	if (!swsusp_resume_device)
 > +		return -ENODEV;
 >  	spin_lock(&swap_lock);
 >  	for (i = 0; i < MAX_SWAPFILES; i++) {
 >  		if (!(swap_info[i].flags & SWP_WRITEOK))
 >  			continue;
 > -		if (!swsusp_resume_device || is_resume_device(swap_info + i)) {
 > +		if (is_resume_device(swap_info + i)) {
 >  			spin_unlock(&swap_lock);
 >  			root_swap = i;
 >  			return 0;

So, now I'm getting bug reports from users about .17rc breaking
their resume again. (https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=194784)

If this was a temporary thing, what should we be doing to keep
old installations working ?

		Dave

-- 
http://www.codemonkey.org.uk
