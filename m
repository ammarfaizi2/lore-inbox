Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316935AbSIEFos>; Thu, 5 Sep 2002 01:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316957AbSIEFor>; Thu, 5 Sep 2002 01:44:47 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:9221 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S316935AbSIEFor>; Thu, 5 Sep 2002 01:44:47 -0400
Date: Thu, 5 Sep 2002 07:48:58 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: "David S. Miller" <davem@redhat.com>
Cc: mason@suse.com, reiser@namesys.com, shaggy@austin.ibm.com,
       marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
       aurora-sparc-devel@linuxpower.org, reiserfs-dev@namesys.com,
       linuxjfs@us.ibm.com, green@namesys.com
Subject: Re: [reiserfs-dev] Re: [PATCH] sparc32: wrong type of nlink_t
Message-ID: <20020905054858.GI24323@louise.pinerecords.com>
References: <3D76A6FF.509@namesys.com> <1031186951.1684.205.camel@tiny> <20020905054008.GH24323@louise.pinerecords.com> <20020904.223651.79770866.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020904.223651.79770866.davem@redhat.com>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.20-pre1/sparc SMP
X-Uptime: 10 days, 7:39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    From: Tomas Szepe <szepe@pinerecords.com>
>    Date: Thu, 5 Sep 2002 07:40:08 +0200
> 
>    > Our disk format has link counts > 32k
>    
>    Does the internal reiserfs nlink value translate directly
>    to what stat() puts in st_nlink?
>    
> It really doesn't matter.  Even if you have some huge value that can't
> be represented in st_nlink, you can report to the user that st_nlink
> is NLINK_MAX.
> 
> This is one possible solution to this whole problem.

And a pretty straightforward one, too. Convert the internal reiserfs
link stuff to an unsigned short, find NLINK_MAX using the code I posted
last night (or maybe simply grab it from userspace includes) and add
a check to your stat() code to return NLINK_MAX if necessary.

T.
