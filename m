Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263124AbSJBNd1>; Wed, 2 Oct 2002 09:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263128AbSJBNd1>; Wed, 2 Oct 2002 09:33:27 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:49796 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S263124AbSJBNdZ>; Wed, 2 Oct 2002 09:33:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: Greg KH <greg@kroah.com>
Subject: Re: [ANNOUNCE] EVMS Release 1.2.0
Date: Wed, 2 Oct 2002 08:06:20 -0500
X-Mailer: KMail [version 1.2]
Cc: evms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <0209301701470A.15956@boiler> <02100116191001.20800@boiler> <20021001221714.GF9928@kroah.com>
In-Reply-To: <20021001221714.GF9928@kroah.com>
MIME-Version: 1.0
Message-Id: <02100208062001.18102@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 October 2002 17:17, Greg KH wrote:
> On Tue, Oct 01, 2002 at 04:19:10PM -0500, Kevin Corry wrote:
> > Looking at the 2.5 code, I found one left-over typedef in ldev_mgr.c,
> > which I have just fixed. There are some in the cluster plugin (evms_ecr.c
> > and evms_ecr.h), but at the moment that is just a proposed clustering
> > interface, since there is no actual cluster support yet. It is likely
> > those files will change as the clustering support is added, so they will
> > get cleaned up along the way.
>
> Ah, as I did not know this about the clustering support, I didn't know
> that this code was not cleaned up yet, sorry.

Unfortunately, the clustering support will not be added before the end of 
Oct. I may just remove those two files from the tree for the time being to 
keep things clean, since I've already disabled the option to build them.

> > The rest of the typedef's I'm seeing are all in the OS/2 and S/390
> > plugins, which as I mentioned in the first announcement haven't been
> > ported to 2.5 yet, and thus haven't gone through any cleanup. When those
> > get ported to 2.5, I'll make sure they are cleaned up.
>
> Any reason not to also clean them up for 2.4?  :)

We've tried to clean up both the 2.4 and 2.5 trees. However, since we are 
only intending on submitting the code for 2.5, that has been our priority.

The S/390 plugin should be easy to clean up and port to 2.5, and I've already 
made an initial attempt at it. However, I've been told that 2.5 may not be 
able to compile and/or run on S/390, so testing that plugin may prove to be 
difficult. If anyone has an tips (or just a URL) on running 2.5 on S/390, 
please let us know.

> > As for improper variable names, can you give me a better idea of where
> > you are seeing them? Any specific examples?
>
> Outside of the clustering and OS/2 and S/390 code, nothing jumps out at
> me, sorry.  I do see some strange formatting in a few files
> (AIXlvm_vge.c is an example) where you are mixing tabs and spaces.
>
> Also, for the code sections like:
> +#ifdef EVMS_DEBUG
> +       LOG_DEBUG(" read_aix Mirror_Copies:%d\n",volume->mirror_copies);
> +#endif
>
> You might just want to create another LOG_* type macro to get rid of all
> of these instances of #ifdef in the code.

Yeah, the AIX plugin apparently still needs some work. Those #ifdef 
EVMS_DEBUG statments can probably just be thrown out. We'll get AIX taken 
care of this week.

> > > Also, is there any documentation on why the md code was reimplemented
> > > within evms, instead of using the existing kernel code?
> >
> > It had to be reimplemented in order to fit into the plugin model in EVMS.
> > We had many requests from our users about a year ago to support the MD
> > metadata, so we added it by porting the existing MD kernel code to an
> > EVMS plugin. Mike Tran has been keeping up with Neil Brown's latest MD
> > code for 2.5, in an attempt to not greatly diverge the code. I believe
> > Mike intends to talk with Neil at some point about seeing if there is a
> > way to provide a common set of code/services that could be used by both
> > MD and EVMS.
>
> As this is one of the larger complaints about this code that I've heard
> from others, I would hope that you put a higher priority on it.

We will.

> Based on these issues (cluster code, stuff not converted for 2.5, md
> duplication) are you all still trying to get this code included in the
> main kernel before Oct 20?

That's the plan. As I said, the cluster code won't be ready, and may be 
removed from the tree.  I'm going to try to get the last two plugins 
converted over this week. The MD issues will be addressed.

Thank you for your feedback. If you see any other immediate issues, please 
let us know. 

-- 
Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/
