Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262436AbSJAVqU>; Tue, 1 Oct 2002 17:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262514AbSJAVqT>; Tue, 1 Oct 2002 17:46:19 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:1498 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S262436AbSJAVqN>; Tue, 1 Oct 2002 17:46:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: Greg KH <greg@kroah.com>
Subject: Re: [ANNOUNCE] EVMS Release 1.2.0
Date: Tue, 1 Oct 2002 16:19:10 -0500
X-Mailer: KMail [version 1.2]
Cc: evms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <0209301701470A.15956@boiler> <02100108181900.20800@boiler> <20021001201343.GB9551@kroah.com>
In-Reply-To: <20021001201343.GB9551@kroah.com>
MIME-Version: 1.0
Message-Id: <02100116191001.20800@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 October 2002 15:13, Greg KH wrote:
> On Tue, Oct 01, 2002 at 08:18:19AM -0500, Kevin Corry wrote:
> > If you have any additional comments, please let us know.
>
> There are still a large number of improper variable names, and quite a
> few typedefs throughout the kernel patch.  I thought these were going to
> be fixed?

I had thought most of them were fixed as well.

Looking at the 2.5 code, I found one left-over typedef in ldev_mgr.c, which I 
have just fixed. There are some in the cluster plugin (evms_ecr.c and 
evms_ecr.h), but at the moment that is just a proposed clustering interface, 
since there is no actual cluster support yet. It is likely those files will 
change as the clustering support is added, so they will get cleaned up along 
the way. The rest of the typedef's I'm seeing are all in the OS/2 and S/390 
plugins, which as I mentioned in the first announcement haven't been ported 
to 2.5 yet, and thus haven't gone through any cleanup. When those get ported 
to 2.5, I'll make sure they are cleaned up.

As for improper variable names, can you give me a better idea of where you 
are seeing them? Any specific examples?

> Also, is there any documentation on why the md code was reimplemented
> within evms, instead of using the existing kernel code?

It had to be reimplemented in order to fit into the plugin model in EVMS. We 
had many requests from our users about a year ago to support the MD metadata, 
so we added it by porting the existing MD kernel code to an EVMS plugin. Mike 
Tran has been keeping up with Neil Brown's latest MD code for 2.5, in an 
attempt to not greatly diverge the code. I believe Mike intends to talk with 
Neil at some point about seeing if there is a way to provide a common set of 
code/services that could be used by both MD and EVMS.

-- 
Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/
