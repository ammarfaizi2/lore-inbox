Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262848AbSJAWOS>; Tue, 1 Oct 2002 18:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262850AbSJAWOS>; Tue, 1 Oct 2002 18:14:18 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:21256 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262848AbSJAWOR>;
	Tue, 1 Oct 2002 18:14:17 -0400
Date: Tue, 1 Oct 2002 15:17:15 -0700
From: Greg KH <greg@kroah.com>
To: Kevin Corry <corryk@us.ibm.com>
Cc: evms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] EVMS Release 1.2.0
Message-ID: <20021001221714.GF9928@kroah.com>
References: <0209301701470A.15956@boiler> <02100108181900.20800@boiler> <20021001201343.GB9551@kroah.com> <02100116191001.20800@boiler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02100116191001.20800@boiler>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 04:19:10PM -0500, Kevin Corry wrote:
> 
> Looking at the 2.5 code, I found one left-over typedef in ldev_mgr.c, which I 
> have just fixed. There are some in the cluster plugin (evms_ecr.c and 
> evms_ecr.h), but at the moment that is just a proposed clustering interface, 
> since there is no actual cluster support yet. It is likely those files will 
> change as the clustering support is added, so they will get cleaned up along 
> the way.

Ah, as I did not know this about the clustering support, I didn't know
that this code was not cleaned up yet, sorry.

> The rest of the typedef's I'm seeing are all in the OS/2 and S/390 
> plugins, which as I mentioned in the first announcement haven't been ported 
> to 2.5 yet, and thus haven't gone through any cleanup. When those get ported 
> to 2.5, I'll make sure they are cleaned up.

Any reason not to also clean them up for 2.4?  :)

> As for improper variable names, can you give me a better idea of where you 
> are seeing them? Any specific examples?

Outside of the clustering and OS/2 and S/390 code, nothing jumps out at
me, sorry.  I do see some strange formatting in a few files
(AIXlvm_vge.c is an example) where you are mixing tabs and spaces.

Also, for the code sections like:
+#ifdef EVMS_DEBUG
+       LOG_DEBUG(" read_aix Mirror_Copies:%d\n",volume->mirror_copies);
+#endif
	
You might just want to create another LOG_* type macro to get rid of all
of these instances of #ifdef in the code.

> > Also, is there any documentation on why the md code was reimplemented
> > within evms, instead of using the existing kernel code?
> 
> It had to be reimplemented in order to fit into the plugin model in EVMS. We 
> had many requests from our users about a year ago to support the MD metadata, 
> so we added it by porting the existing MD kernel code to an EVMS plugin. Mike 
> Tran has been keeping up with Neil Brown's latest MD code for 2.5, in an 
> attempt to not greatly diverge the code. I believe Mike intends to talk with 
> Neil at some point about seeing if there is a way to provide a common set of 
> code/services that could be used by both MD and EVMS.

As this is one of the larger complaints about this code that I've heard
from others, I would hope that you put a higher priority on it.

Based on these issues (cluster code, stuff not converted for 2.5, md
duplication) are you all still trying to get this code included in the
main kernel before Oct 20?

Good luck,

greg k-h
