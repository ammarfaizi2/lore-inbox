Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbVCOQlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVCOQlp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 11:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbVCOQlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 11:41:45 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:1165 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261413AbVCOQlZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 11:41:25 -0500
Subject: Re: [Ext2-devel] Re: [PATCH] 2.6.11-mm3 patch for ext3 writeback
	"nobh" option
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>
In-Reply-To: <1110903996.6290.73.camel@laptopd505.fenrus.org>
References: <1110827903.24286.275.camel@dyn318077bld.beaverton.ibm.com>
	 <20050314180917.07f7ac58.akpm@osdl.org>
	 <1110902996.24286.328.camel@dyn318077bld.beaverton.ibm.com>
	 <1110903996.6290.73.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Organization: 
Message-Id: <1110904587.24286.353.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Mar 2005 08:36:28 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-15 at 08:26, Arjan van de Ven wrote:
> On Tue, 2005-03-15 at 08:09 -0800, Badari Pulavarty wrote:
> > On Mon, 2005-03-14 at 18:09, Andrew Morton wrote:
> > > Badari Pulavarty <pbadari@us.ibm.com> wrote:
> > > >
> > > > Here is the 2.6.11-mm3 version of patch for adding "nobh"
> > > >  support for ext3 writeback mode.
> > > 
> > > Care to update Documentation/filesystems/ext3.txt?
> > 
> > Yes. I will do that. I am planning to add "nobh" support to
> > ext3 ordered mode also, since its the default one. We need
> > to modify generic interfaces like mpage_writepage(s) to
> > keep track of bio count and make journal code wait for them etc. -
> > at that point the "generic" code will no longer be generic.
> > I am thinking of a way to do it *less* intrusively. 
> > 
> > At that point, we can make "nobh" default option. (which
> > needs less documentation).
> 
> I still don't get why you want a mount option. Sure during development
> it can be nice.. but do you still want it in the production trees??

Once I get "nobh" working for both ordered and writeback mode - 
I will take out the option. Only reason why, you may
want "bh"s are for faster lookups. "bh" stores the get_block()
information, getting rid of it means - we need to do few more
get_block() calls when we need the disk mapping. 

We have seen small amount of "reads" when we are doing write-only 
tests with "nobh" option. I am not at a point, where I can quantify
the performance hit due to not caching the disk mapping info. 

Thanks,
Badari

